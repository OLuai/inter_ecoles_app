import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  String assetName;

  NavigationModel({required this.title, required this.assetName});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Football", assetName: "assets/images/football.png"),
  NavigationModel(title: "Basket", assetName: "assets/images/basketBall.png"),
  NavigationModel(title: "Volley Ball", assetName: "assets/images/volleyball.png"),
  NavigationModel(title: "Hand Ball", assetName: "assets/images/handball.png"),
  NavigationModel(title: "Autre Sports", assetName: "assets/images/sports.png"),
];