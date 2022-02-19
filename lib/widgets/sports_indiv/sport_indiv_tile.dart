import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/individual_sport.dart';
import 'package:inter_ecoles_app/screens/sport_indiv_winners_screen.dart';
import 'package:inter_ecoles_app/theme.dart';

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
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        ListTile(
          onTap: ()=>
              showDialog(
                  context: context,
                  builder: (context)=> AlertDialog(
                    title: Text(
                        sport.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: subTitleSport,
                        ),
                    ),
                    scrollable: true,
                    backgroundColor: gris,
                    content: SizedBox(
                      height: size.height/3,
                      width: size.width,
                      child: SportIndivWinnersScreen(
                        sport: sport,
                        currentRoundId: currentRoundId,
                      ),
                    ),
                  )
              ),
        title: Text(sport.name),
        trailing: const Icon(Icons.navigate_next),
        ),
        const Divider(),
        ],
        );
      }
}

