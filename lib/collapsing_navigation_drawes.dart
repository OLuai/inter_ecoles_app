import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/collapsing_list_title.dart';
import 'package:inter_ecoles_app/sport_page.dart';
import 'package:inter_ecoles_app/navigation.dart';
import 'package:inter_ecoles_app/theme.dart';

class CallapsingNavigationDrawer extends StatefulWidget {
  const CallapsingNavigationDrawer({
    Key? key,
    required this.currentRoundId,
  }) : super(key: key);
  final String currentRoundId;
  @override
  State<CallapsingNavigationDrawer> createState() =>
      _CallapsingNavigationDrawerState();
}

class _CallapsingNavigationDrawerState extends State<CallapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 220;
  double minWidth = 60;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  int indexSelectionner = 0;

  // Pour les récupérer pages liées aux sports
  Widget getSportPage(int index) {
    switch (index) {
      case 0:
        return SportPage(
            title: "FootBall",
            idSport: "ID_FOOTBALL",
            currentRoundId: widget.currentRoundId);
      case 1:
        return SportPage(
            title: "BasketBall",
            idSport: "ID_BASKETBALL",
            currentRoundId: widget.currentRoundId);
      case 2:
        return SportPage(
            title: "VolleyBall",
            idSport: "ID_VOLLEYBALL",
            currentRoundId: widget.currentRoundId);
      case 3:
        return SportPage(
            title: "HandBall",
            idSport: "ID_HANDBALL",
            currentRoundId: widget.currentRoundId);
      default:
        return SportPage(
            title: "FootBall",
            idSport: "ID_FOOTBALL",
            currentRoundId: widget.currentRoundId);
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget));
  }

  Widget getWidget(context, widget) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: getSportPage(indexSelectionner),
        ),
        Material(
          elevation: 60.0,
          child: Container(
            width: widthAnimation.value,
            color: drawerBackgroundColor,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 33.5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                      isCollapsed
                          ? _animationController.forward()
                          : _animationController.reverse();
                    });
                  },
                  child: CollapsingListTitle(
                    title: "INTER ECOLE",
                    assetName: "assets/logos/logoApp.png",
                    animationController: _animationController,
                  ),
                ),
                const SizedBox(
                  height: 147.0,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, counter) {
                      return const Divider(
                        height: 15.0,
                      );
                    },
                    itemBuilder: (context, counter) {
                      return CollapsingListTitle(
                        isSelected: indexSelectionner == counter,
                        title: navigationItems[counter].title,
                        assetName: navigationItems[counter].assetName,
                        animationController: _animationController,
                        onTap: () {
                          setState(() {
                            indexSelectionner = counter;
                          });
                        },
                      );
                    },
                    itemCount: navigationItems.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
