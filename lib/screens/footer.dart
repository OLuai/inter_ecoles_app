import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/models/sport.dart';
import 'package:inter_ecoles_app/screens/list_sports_indiv_screen.dart';
import 'package:inter_ecoles_app/models/sport_page.dart';
import 'package:inter_ecoles_app/theme.dart';

class Footer extends StatefulWidget {
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
      case 4:
        return ListSportsIndivScreen(
          sport: Sports.individuels,
          currentRoundId: widget.currentRoundId,
        );
      default:
        return SportPage(
            title: "FOOTBALL",
            idSport: "ID_FOOTBALL",
            currentRoundId: widget.currentRoundId);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset("assets/logos/logoApp.png"),
        ),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  showAboutDialog(
                    context: context,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Equipe Dev :",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("GhostScripter"),
                                Text("Maraboot"),
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                  "assets/images/profil.jpg",
                                  ),
                                ),
                                Text("en collaboration avec le pôle sport du BDE"),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                    applicationIcon: Image.asset(
                      "assets/logos/logoApp.png",
                      width:size.width/2,
                      height:size.height/2,
                    ),
                    applicationName: '☺',
                  );
                });
              },
              icon: const Icon(Icons.help_outline),
          ),
        ],
        leadingWidth: 40,
        backgroundColor: drawerBackgroundColor,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Center(child: getSportPage(_selectedIndex)),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'football',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'basketball',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_volleyball),
            label: 'volleyball',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_handball),
            label: 'handball',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports),
            label: 'sports',
          ),
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
