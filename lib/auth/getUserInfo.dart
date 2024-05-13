// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class getUserInfo extends StatelessWidget {
//   getUserInfo({super.key});
//
//   final User? currentUser = FirebaseAuth.instance.currentUser!;
//
//   Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc(currentUser!.email)
//         .get();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//             future: getUserDetails(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               //error
//               else if (snapshot.hasError) {
//                 return Text("Error: ${snapshot.error}");
//               } else if (snapshot.hasData) {
//                 Map<String, dynamic>? user = snapshot.data!.data();
//
//                 return Column(
//                   children: [
//                     Text(user!['email']),
//                     Text(user!['firstName']),
//                   ],
//                 );
//               } else {
//                 return Text("No data");
//               }
//             }));
//   }
// }
