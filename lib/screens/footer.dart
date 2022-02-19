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
                  showDialog(
                    context: context,
                    builder: (context)=> AlertDialog(
                      backgroundColor: selectedColor,
                      scrollable: false,
                      title: const Text("Auteurs :", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      content: SizedBox(
                        height: size.height/2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text("@GhostScripte"),
                                      Text("@MaraBoot👹"),
                                      Text("@Kar^Tch☠"),
                                    ],
                                  ),
                                  const CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage("assets/images/profil.jpg"),
                                  ),
                                ],
                              ),
                            ),
                            const Text("Détails :", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                  child: Image.asset("assets/logos/logoApp.png"),
                                ),
                                Container(
                                  width: size.width/2.5,
                                  child: Text("Projet publié avec la collaboration du pôle sport du Bureau des Etudiants (BDE) de l'INP-HB "),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
