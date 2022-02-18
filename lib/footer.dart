import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/sport_page.dart';

class Footer extends StatefulWidget{
  final String currentRoundId;
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
      body: Center(
        child: getSportPage(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.sports_handball), label: 'handball',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_football), label: 'football',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_volleyball), label: 'volleyball',),
          BottomNavigationBarItem(icon: Icon(Icons.sports_basketball), label: 'basketball',),
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