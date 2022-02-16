import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/collapsing_navigation_drawes.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.currentRoundId}) : super(key: key);
  final String currentRoundId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CallapsingNavigationDrawer(currentRoundId: currentRoundId)
      ],
    );
  }
}
