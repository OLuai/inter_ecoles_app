// ignore: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/winner.dart';

Widget WinnerTile({
  required Winner winner,
}) {
  return ListTile(
    leading: Text(
      "${winner.rank.toString()}.",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    title: Text(
      winner.fullName,
      style: const TextStyle(
        fontSize: 18,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image(
          image: AssetImage(winner.school.logoUrl),
          width: 40,
        ),
      ],
    ),
  );
}
