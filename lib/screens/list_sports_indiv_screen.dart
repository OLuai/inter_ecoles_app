import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/individual_sport.dart';
import 'package:inter_ecoles_app/models/sport.dart';
import 'package:inter_ecoles_app/screens/sport_indiv_winners_screen.dart';
import 'package:inter_ecoles_app/widgets/sports_indiv/sport_indiv_tile.dart';

class ListSportsIndivScreen extends StatelessWidget {
  const ListSportsIndivScreen({
    Key? key,
    required this.sport,
    required this.currentRoundId,
  }) : super(key: key);
  final Sport sport;
  final String currentRoundId;

  @override
  Widget build(BuildContext context) {
    final String _collectionPath =
        "Rounds/$currentRoundId/sports/${sport.id}/disciplines";
    final CollectionReference _collectionReference = FirebaseFirestore.instance
        .collection(_collectionPath)
        .withConverter<IndividualSport>(
          fromFirestore: (snapshot, _) => IndividualSport.fromJson(
            snapshot.data()!,
          ),
          toFirestore: (sport, _) => sport.toJson(),
        );

    void nextPage(IndividualSport sport) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SportIndivWinnersScreen(
            sport: sport,
            currentRoundId: currentRoundId,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(sport.name),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _collectionReference.snapshots(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot<IndividualSport>> items = snapshot
                .data.docs as List<QueryDocumentSnapshot<IndividualSport>>;
            List<IndividualSport> compets = items.map((e) => e.data()).toList();
            compets.sort(
              (a, b) => a.name.compareTo(b.name),
            );
            return Container(
              padding: const EdgeInsets.only(top: 15.0),
              width: double.infinity,
              child: ListView.builder(
                itemCount: compets.length,
                itemBuilder: (ctx, index) {
                  return SportIndivTile(
                    currentRoundId: currentRoundId,
                    sport: compets[index],
                    nextPage: nextPage,
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text('Aucune donnée.'),
            );
          }
        },
      ),
    );
  }
}
