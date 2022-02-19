import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/individual_sport.dart';
import 'package:inter_ecoles_app/models/sport.dart';
import 'package:inter_ecoles_app/models/winner.dart';
import 'package:inter_ecoles_app/theme.dart';
import 'package:inter_ecoles_app/widgets/sports_indiv/winner_tile.dart';

class SportIndivWinnersScreen extends StatefulWidget {
  const SportIndivWinnersScreen({
    Key? key,
    required this.currentRoundId,
    required this.sport,
  }) : super(key: key);
  final String currentRoundId;
  final IndividualSport sport;

  @override
  State<SportIndivWinnersScreen> createState() =>
      _SportIndivWinnersScreenState();
}

class _SportIndivWinnersScreenState extends State<SportIndivWinnersScreen> {
  @override
  Widget build(BuildContext context) {
    final String _collectionPath =
        "Rounds/${widget.currentRoundId}/sports/${Sports.individuels.id}/disciplines/${widget.sport.id}/winners";
    final CollectionReference _collectionReference = FirebaseFirestore.instance
        .collection(_collectionPath)
        .withConverter<Winner>(
          fromFirestore: (snapshot, _) => Winner.fromJson(
            snapshot.data()!,
          ),
          toFirestore: (winner, _) => winner.toJson(),
        );
    void addWinner(Winner winner) {
      _collectionReference.doc(winner.id).set(winner);
    }

    return Container(
      child: StreamBuilder<Object>(
          stream: _collectionReference.snapshots(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot<Winner>> items =
                  snapshot.data.docs as List<QueryDocumentSnapshot<Winner>>;
              List<Winner> winners = items.map((e) => e.data()).toList();
              winners.sort(
                (a, b) => a.rank.compareTo(b.rank),
              );
              return ListView.builder(
                itemCount: winners.length,
                itemBuilder: (ctx, index) {
                  return WinnerTile(
                    winner: winners[index],
                  );
                },
              );
            }
            return ListView();
          }),
    );
  }
}
