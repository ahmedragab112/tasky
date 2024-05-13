import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foucesflow3/models/task_model.dart';
import 'package:foucesflow3/models/user_model.dart';


class FirebaseManger {
  static CollectionReference<TaskModel> getCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromjson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task) {
    CollectionReference collection = getCollection();
    var doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks() {
    return getCollection()
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getCollection().doc(taskId).delete();
  }

  static Future<void> update(TaskModel task) {
    return getCollection().doc(task.id).update(task.toJson());
  }

  static Future<void> signUp(
      {required String emailAddress,
      required String password,
      required Function onSccuess,
      required Function onError,
      required String age,
      required String name}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      UserModel user = UserModel(
          email: emailAddress, age: age, id: credential.user!.uid, name: name);
      addUserToDb(user);
      credential.user!.sendEmailVerification();
      if (credential.user!.emailVerified) {
        onSccuess();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> loginUser(
      {required String emailAddress,
      required String password,
      required Function onSuccess,
      required Function onFail}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      onSuccess();
    } on FirebaseAuthException {
      onFail('Wrong email or password');
    } catch (e) {
      onFail(e.toString());
    }
  }

  static void logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserModel?> readUser(String id) async {
    DocumentSnapshot<UserModel> userDoc =
        await getUserCollection().doc(id).get();
    return userDoc.data();
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static Future<void> addUserToDb(UserModel user) {
    CollectionReference<UserModel> collection = getUserCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }
}
