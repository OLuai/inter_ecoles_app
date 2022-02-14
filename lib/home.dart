import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/collapsing_navigation_drawes.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CallapsingNavigationDrawer()
      ],
    );
  }
}