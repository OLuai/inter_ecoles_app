import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/models/matchs.dart';
import 'package:inter_ecoles_app/theme.dart';

class SportPage extends StatefulWidget{

  final String title;
  final idSport;

  const SportPage({
    Key? key,
    required this.title,
    required this.idSport
  }) : super(key: key);

  @override
  State<SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var idSport = widget.idSport;

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
            height: size.height/3,
            padding: const EdgeInsets.only(left: 10.0, right: 8.0),
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(getGender(Gender.dame), style: genderTextStyle,), // utiliser les enum de Gender pour plus d'éfficacité
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _matchView(Gender.dame, idSport),
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
                _matchView(Gender.homme, idSport),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// pour afficher le score d'un match
_matchView(Gender genre, String idSport) {
  List<Widget> children = [];
  for (Matchs match in matchItems) {
    if (match.gender == genre && match.sport.id == idSport){
      var score = match.getScore();
      Container element = Container(
        margin: const EdgeInsets.only(top: 3, left: 3, right: 3),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(225, 225, 225, 1),
        ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(match.teamA.name, style: matchTextStyle,),
            CircleAvatar(radius: 12, backgroundImage: AssetImage(match.teamA.logoUrl),),
            Column(
              children: [
                Text("1 ${match.sport.periodShortName}", style: matchScoreTextStyle,),
                Text("${score[match.teamAId]} - ${score[match.teamBId]}", style: matchTextStyle,),
                Text(getMatchStatus(match.status), style: matchScoreTextStyle,),
              ],
            ),
            CircleAvatar(radius: 12, backgroundImage: AssetImage(match.teamB.logoUrl),),
            Text(match.teamB.name, style: matchTextStyle,),
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("${match.elapsedTime} '", style: matchTextStyle,),
                  ],
                )
            )
          ],
        )
      );
      children.add(element);
    }
  }
  return SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: children,));
}