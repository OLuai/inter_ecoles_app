import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/screens/sport_indiv_winners_screen.dart';
import 'package:inter_ecoles_app/sport_page.dart';
import 'package:inter_ecoles_app/theme.dart';

class Footer extends StatefulWidget{
  final String currentRoundId;
  final String title = "INTER ECOLE";

  const Footer({
    Key? key,
    required this.currentRoundId,
  }) : super(key: key);
  
  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  int _selectedIndex = 0;

  Widget getSportPage(int index) {
    switch (index) {
      case 0:
        return SportPage(
            title: "FOOTBALL",
            idSport: "ID_FOOTBALL",
            currentRoundId: widget.currentRoundId);
      case 1:
        return SportPage(
            title: "BASKETBALL",
            idSport: "ID_BASKETBALL",
            currentRoundId: widget.currentRoundId);
      case 2:
        return SportPage(
            title: "VOLLEYBALL",
            idSport: "ID_VOLLEYBALL",
            currentRoundId: widget.currentRoundId);
      case 3:
        return SportPage(
            title: "HANDBALL",
            idSport: "ID_HANDBALL",
            currentRoundId: widget.currentRoundId);
      /*case 4:
        return SportIndivWinnersScreen(
          currentRoundId: widget.currentRoundId,
          sport: null,
        );*/
      default:
        return SportPage(
            title: "FOOTBALL",
            idSport: "ID_FOOTBALL",
            currentRoundId: widget.currentRoundId);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/logos/logoApp.png"),
        backgroundColor: drawerBackgroundColor,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(fontSize: 30,),
          ),
        ),
      ),
      body: Center(
        child: getSportPage(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: drawerBackgroundColor,
        selectedItemColor: subTitleSport,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.sports_soccer), label: 'football',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_basketball), label: 'basketball',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_volleyball), label: 'volleyball',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_handball), label: 'handball',),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'sports',),
        ],
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}