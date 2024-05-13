import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foucesflow3/auth/Calendar.dart';
import 'package:foucesflow3/auth/Pomodoro.dart';
import 'package:foucesflow3/auth/challenge.dart';
import 'package:foucesflow3/auth/colors.dart';
import 'package:foucesflow3/auth/notes.dart';


class Home extends StatelessWidget {
  Home({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  //
  // Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(currentUser!.email)
  //       .get();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,

          appBar: AppBar(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: BG,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 100,
                          color: BG,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Text(
                      //   // 'LOADING ...',
                      //   // currentUser.displayName!,
                      //   // user!['firstName'],
                      //   // currentUser.displayName!,
                      //   style: const TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 15), // Add space after the header
                ListTile(
                  title: Text(
                    currentUser.email!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  color: Colors.grey[600],
                ),
                // Grey line after email
                const SizedBox(height: 20),
                ListTile(
                  title: const Text(
                    'Focus Mode',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => FocusMode()),
                    // );
                  },
                ),
                const SizedBox(height: 10), // Add space after each ListTile
                Container(
                  height: 1,
                  color: Colors.grey[600],
                ),
                // Grey line after Focus Mode
                const SizedBox(height: 10),
                ListTile(
                  title: const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String currentPassword = '';
                        String newPassword = '';

                        return AlertDialog(
                          title: const Text('Change Password'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                decoration: const InputDecoration(labelText: 'Current Password'),
                                onChanged: (value) {
                                  currentPassword = value;
                                },
                              ),
                              TextField(
                                decoration: const InputDecoration(labelText: 'New Password'),
                                onChanged: (value) {
                                  newPassword = value;
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                try {
                                  final credential = EmailAuthProvider.credential(
                                    email: currentUser.email!,
                                    password: currentPassword,
                                  );
                                  await currentUser.reauthenticateWithCredential(credential);
                                  await currentUser.updatePassword(newPassword);
                                  Navigator.pop(context);
                                } catch (e) {
                                  // Handle password change failure
                                }
                              },
                              child: const Text('Change'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 15),
                ListTile(
                  title: const Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    // Navigate to Notifications screen
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: Colors.grey[600],
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.logout, size: 40, color: Colors.black),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    signUserOut();
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan your work',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'and ',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'stay productive',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFFD752B2),
                          ),
                        ),
                        Spacer(), // Add Spacer
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, bottom: 60, top: 40),
                  // Added bottom padding
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6D6D6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                    ),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    children: [
                      itemDashboardPomodoro(context),
                      itemDashboardCalendar(context),
                      itemDashboardNotes(context),
                      itemDashboardChallenge(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
  }

  Widget itemDashboardPomodoro(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Pomodoro()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.av_timer, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pomodoro',
              style: TextStyle(
                fontFamily: 'InriaSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDashboardCalendar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Calendar(
                    title: '',
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFD752B2),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.calendar_month_rounded, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Calendar',
              style: TextStyle(
                fontFamily: 'InriaSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDashboardNotes(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const notes()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sticky_note_2, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Notes',
              style: TextStyle(
                fontFamily: 'InriaSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemDashboardChallenge(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const challenge()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.sports_gymnastics, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              '21-Days   Challenge',
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(
                fontFamily: 'InriaSans',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
