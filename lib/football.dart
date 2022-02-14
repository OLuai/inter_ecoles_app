import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/models/matchs.dart';
import 'package:inter_ecoles_app/theme.dart';

class Football extends StatefulWidget{

  final String title = "FootBall";

  @override
  State<Football> createState() => _FootballState();
}

class _FootballState extends State<Football> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 50, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: size.height/2.7,
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(getGender(Gender.dame), style: genderTextStyle,), // utiliser les enum de Gender pour plus d'éfficacité
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _matchView(Gender.dame),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2.7, color: Colors.blue,),
          Container(
            height: size.height/2.7,
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(getGender(Gender.homme), style: genderTextStyle,), // utiliser les enum de Gender pour plus d'éfficacité
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _matchView(Gender.homme),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// pour afficher le score d'un match
_matchView(Gender genre) {
  for (Matchs match in matchItems) {
    if (match.gender == genre && match.sport.id == "ID_FOOTBALL"){
      return Row(
        children: [
          Text(match.teamA.name, style: matchTextStyle,),
          CircleAvatar(radius: 15, backgroundImage: AssetImage(match.teamA.logoUrl),),
          Text(" 0-0 ", style: matchTextStyle,),
          CircleAvatar(radius: 15, backgroundImage: AssetImage(match.teamB.logoUrl),),
          Text(match.teamB.name, style: matchTextStyle,),
        ],
      );
    }
  }
}