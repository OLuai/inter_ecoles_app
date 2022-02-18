import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/models/matchs.dart';
import 'package:inter_ecoles_app/theme.dart';


//VolleyBall
String getSetScore(Matchs match){
  String score="";
  for(int i=1 ; i<=match.period; i++) {
    score += "☼► ${match.periodsScores![i]![match.teamAId]}-${match.periodsScores![i]![match.teamBId]} ";
  }
  return score;
}
//FootBall

// pour afficher le score d'un match
Widget matchView(Gender genre, String idSport, String currentRoundId) {
  List<Widget> listMatchs(
    Gender genre,
    String idSport,
    List<Matchs> matchItems,
  ) {
    List<Widget> children = [];
    for (Matchs match in matchItems) {
      if (match.gender == genre && match.sport.id == idSport) {
        var score = match.getScore();
        var element = Container(
          margin: const EdgeInsets.only(top: 3, left: 3, right: 3),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,//
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "•",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        getMatchStatus(match.status),
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Text(
                    "${match.elapsedTime}'",
                    style: const TextStyle(
                        color: Colors.green,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(
                thickness: 2,
                height: 12.0,
                color: Color.fromRGBO(225, 225, 225, 1),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: gris,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage(match.teamA.logoUrl),
                          )),
                      Text(
                        match.teamA.name,
                        style: const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        match.status == MatchStatus.waiting
                            ? "VS"
                            : "${score[match.teamAId]} - ${score[match.teamBId]}",
                        style: matchScoreTextStyle,
                      ),
                      const Text(""),
                      Text(
                        "${match.period}• ${match.sport.periodShortName}",
                        style: matchTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: gris,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage(match.teamB.logoUrl),
                          )),
                      Text(
                        match.teamB.name,
                        style: const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              idSport == "ID_VOLLEYBALL"
                  ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            getSetScore(match),
                            style: const TextStyle(color: Colors.black, fontSize: 13, fontFamily: "Digit"),
                          )

                        ],
                      )
                  : const Text(""),
            ],
          )
        );
        children.add(element);
      }
    }
    return children;
  }

  String _collectionPath =
      "Rounds/$currentRoundId/sports/$idSport/${genre.toString()}/matchs/list";
  CollectionReference _collectionReference = FirebaseFirestore.instance
      .collection(_collectionPath)
      .withConverter<Matchs>(
        fromFirestore: (snapshot, _) => Matchs.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (match, _) => match.toJson(),
      );

  return StreamBuilder<Object>(
      stream: _collectionReference.snapshots(),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot<Matchs>> items =
              snapshot.data.docs as List<QueryDocumentSnapshot<Matchs>>;
          List<Matchs> matches = items.map((e) => e.data()).toList();
          matches.sort(
            (a, b) => a.order.compareTo(
              b.order,
            ),
          );
          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: listMatchs(genre, idSport, matches),
          ));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      });
}

