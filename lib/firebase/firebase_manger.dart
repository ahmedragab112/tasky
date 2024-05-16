// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foucesflow3/models/task_model.dart';
import 'package:foucesflow3/models/user_model.dart';
import 'package:foucesflow3/models/work_time_model.dart';

class FirebaseManger {
  static CollectionReference<TaskModel> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection('Tasks')
        .withConverter<TaskModel>(
          fromFirestore: (snapshot, _) => TaskModel.fromjson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task) {
    CollectionReference collection = getTaskCollection();
    var doc = collection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks() {
    return getTaskCollection()
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    return getTaskCollection().doc(taskId).delete();
  }

  static Future<void> update(TaskModel task) {
    return getTaskCollection().doc(task.id).update(task.toJson());
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

  static CollectionReference<WorkTimeModel> getWorkCollection() {
    return FirebaseFirestore.instance
        .collection('WorkTime')
        .withConverter<WorkTimeModel>(
          fromFirestore: (snapshot, _) =>
              WorkTimeModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addWorkTime(WorkTimeModel work) {
    CollectionReference collection = getWorkCollection();
    var doc = collection.doc();
    work.id = doc.id;
    return doc.set(work);
  }

  static Future<void> uploadChallengesData(
      Map<String, List<String>> data) async {
    try {
      CollectionReference challengesCollection =
          FirebaseFirestore.instance.collection('challenges');

      data.forEach((category, challenges) async {
        DocumentReference docRef = challengesCollection.doc(category);

        await docRef.set({'challenges': challenges});
      });

      print('Challenges data uploaded successfully!');
    } catch (e) {
      print('Error uploading challenges data: $e');
    }
  }

  static Future<List<String>> getChallengesForCategory(
      String categoryName) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference challengesCollection =
          FirebaseFirestore.instance.collection('challenges');

      // Query the Firestore collection for the document with the given category name
      DocumentSnapshot documentSnapshot =
          await challengesCollection.doc(categoryName).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Get the data from the document
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Extract the list of challenges from the data
        dynamic challengesData = data['challenges'][categoryName];

        // Check if the challengesData is a List<String>
        if (challengesData is List<String>) {
          return challengesData;
        } else {
          print('Error: Challenges data is not in the expected format');
          return [];
        }
      } else {
        print('Document does not exist for category: $categoryName');
        return [];
      }
    } catch (e) {
      print('Error getting challenges for category: $e');
      return [];
    }
  }
}
