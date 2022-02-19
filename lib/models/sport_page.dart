import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/gender.dart';
import 'package:inter_ecoles_app/models/score_board.dart';
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
    var idSport = widget.idSport;

    return Scaffold(
      backgroundColor: gris,
      appBar: AppBar(
        toolbarHeight: 25,
        backgroundColor: subTitleSport,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
                fontSize: 20,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                child: Text(getGender(Gender.dame), style: genderTextStyle,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: matchView(Gender.dame, idSport, widget.currentRoundId),
              ),
              Padding(
                padding: const EdgeInsets.only(top:20.0, bottom: 8.0),
                child: Text(getGender(Gender.homme), style: genderTextStyle,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: matchView(Gender.homme, idSport, widget.currentRoundId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
