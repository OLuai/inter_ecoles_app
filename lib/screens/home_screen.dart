import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/screens/home.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final String collectionPath = "Round";
  late final DocumentReference _roundReference =
      FirebaseFirestore.instance.collection(collectionPath).doc('current');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _roundReference.snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            dynamic currentRound = snapshot.data!.data();
            String currentRoundId = currentRound['id'];
            return Home(currentRoundId: currentRoundId);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
