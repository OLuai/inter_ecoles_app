import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/individual_sport.dart';

class SportIndivTile extends StatelessWidget {
  const SportIndivTile(
      {Key? key,
      required this.sport,
      required this.currentRoundId,
      required this.nextPage})
      : super(key: key);
  final IndividualSport sport;
  final String currentRoundId;
  final void Function(IndividualSport) nextPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => nextPage(sport),
          title: Text(sport.name),
          trailing: const Icon(Icons.navigate_next),
        ),
        const Divider(),
      ],
    );
  }
}
