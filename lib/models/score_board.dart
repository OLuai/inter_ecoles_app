import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/models/matchs.dart';
import 'package:inter_ecoles_app/theme.dart';


//VolleyBall
String getMatchScore(Matchs match){
  String score="";
  for(int i=1 ; i<=match.period; i++) {
    score += "  ${match.periodsScores![i]![match.teamAId]}-${match.periodsScores![i]![match.teamBId]}  ";
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
        Color statusColors = match.status==MatchStatus.pending
            ?Colors.green
            :match.status==MatchStatus.end
              ?Colors.black
              :Colors.orange;
        var element = Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Container(
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
                      match.status!=MatchStatus.waiting
                          ? Text(
                              getMatchStatus(match.status),
                              style: TextStyle(
                                  color: statusColors,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400),
                            )
                          : const SizedBox(),
                      /*match.status==MatchStatus.pending && match.sport.id!="ID_VOLLEYBALL"
                          ?Text(
                              "${match.elapsedTime}'",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold),
                            )
                          :*/match.sport.id=="ID_VOLLEYBALL"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  getMatchScore(match),
                                  style: const TextStyle(color: Colors.indigo, fontSize: 13, fontFamily: "Digit"),
                                )
                              ],
                            )
                          : const SizedBox(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 21,
                                  backgroundColor: gris,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 19,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 17,
                                        child: Image.asset(match.teamA.logoUrl),
                                      )
                                  )
                              ),
                              const SizedBox(height: 5.0,),
                              Text(
                                match.teamA.name,
                                style: const TextStyle(color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              match.status == MatchStatus.pending || match.status == MatchStatus.pause
                                  ?match.sport.id=="ID_VOLLEYBALL"
                                  ?Text(
                                " ${score[match.teamAId]}",
                                style: matchScore,
                              )
                                  :const SizedBox()
                                  :const SizedBox(),
                              const SizedBox(height: 20.0,),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            match.status == MatchStatus.waiting
                                ? "VS"
                                : match.sport.id=="ID_VOLLEYBALL"
                                ? match.status == MatchStatus.end
                                ? "${score[match.teamAId]} - ${score[match.teamBId]}"
                                : "${match.periodsScores![match.period]![match.teamAId]} - ${match.periodsScores![match.period]![match.teamBId]}"
                                : "${score[match.teamAId]} - ${score[match.teamBId]}",
                            style: matchScoreTextStyle,
                          ),
                          const SizedBox(height: 20.0,),
                          match.status==MatchStatus.pending || match.status==MatchStatus.pause
                              ?Text(
                                  "${match.period}• ${match.sport.periodName}",
                                  style: matchTextStyle,
                                )
                              :const SizedBox(),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              match.status == MatchStatus.pending || match.status == MatchStatus.pause
                                  ?match.sport.id=="ID_VOLLEYBALL"
                                  ?Text(
                                      "${score[match.teamBId]} ",
                                      style: matchScore,
                                    )
                                  :const SizedBox()
                                  :const SizedBox(),
                              const SizedBox(height: 20.0,),
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  radius: 21,
                                  backgroundColor: gris,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 19,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 17,
                                        child: Image.asset(match.teamB.logoUrl),
                                      )
                                  )
                              ),
                              const SizedBox(height: 5.0,),
                              Text(
                                match.teamB.name,
                                style: const TextStyle(color: Colors.black, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
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

