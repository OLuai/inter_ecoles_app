import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/matchs.dart';

// ignore: non_constant_identifier_names
Widget MatchTile(Matchs match) {
  dynamic score = match.getScore();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            match.teamA.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Image(
          image: AssetImage(match.teamA.logoUrl),
          width: 36.0,
        ),
        Expanded(
          child: Text(
            "${score[match.teamA.id]} - ${score[match.teamB.id]}",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        Image(
          image: AssetImage(match.teamB.logoUrl),
          width: 36.0,
        ),
        Expanded(
          child: Text(
            match.teamB.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    ),
  );
}
