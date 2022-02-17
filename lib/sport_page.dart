import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/score_board.dart';
import 'package:inter_ecoles_app/theme.dart';

class SportPage extends StatefulWidget {
  final String title;
  final idSport;
  final String currentRoundId;

  const SportPage({
    Key? key,
    required this.title,
    required this.idSport,
    required this.currentRoundId,
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
        backgroundColor: drawerBackgroundColor,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 36,
                fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 8.0),
        margin: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${getGender(Gender.dame)}", style: genderTextStyle,),
              /*idSport == "ID_VOLLEYBALL"
                  ? volleyBallView(Gender.dame, idSport, widget.currentRoundId)==[]
                    ? Text("")
                    : Text("${getGender(Gender.dame)} ↓", style: genderTextStyle,)
                  : matchView(Gender.dame, idSport, widget.currentRoundId)==[]
                    ? Text("")
                    : Text("${getGender(Gender.dame)} ↓", style: genderTextStyle,),*/
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  idSport == "ID_VOLLEYBALL"
                      ? volleyBallView(Gender.dame, idSport, widget.currentRoundId)
                      : matchView(Gender.dame, idSport, widget.currentRoundId),
                ],
              ),
              Text("${getGender(Gender.homme)}", style: genderTextStyle,),
              /*idSport == "ID_VOLLEYBALL"
                  ? volleyBallView(Gender.homme, idSport, widget.currentRoundId)==[]
                    ? Text("")
                    : Text("${getGender(Gender.homme)} ↓", style: genderTextStyle,)
                  : matchView(Gender.homme, idSport, widget.currentRoundId)==[]
                    ? Text("")
                    : Text("${getGender(Gender.homme)} ↓", style: genderTextStyle,),*/
              Column(
                children: [
                  idSport == "ID_VOLLEYBALL"
                      ? volleyBallView(Gender.homme, idSport, widget.currentRoundId)
                      : matchView(Gender.homme, idSport, widget.currentRoundId),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
