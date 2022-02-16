import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/collapsing_list_title.dart';
import 'package:inter_ecoles_app/sport_page.dart';
import 'package:inter_ecoles_app/navigation.dart';
import 'package:inter_ecoles_app/theme.dart';

class CallapsingNavigationDrawer extends StatefulWidget {
  @override
  State<CallapsingNavigationDrawer> createState() => _CallapsingNavigationDrawerState();
}

class _CallapsingNavigationDrawerState
    extends State<CallapsingNavigationDrawer>
    with SingleTickerProviderStateMixin{

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
        return SportPage(title: "FootBall",idSport: "ID_FOOTBALL");
      case 1:
        return SportPage(title: "BasketBall",idSport: "ID_BASKETBALL");
      case 2:
        return Text("VolleyBall", style: genderTextStyle,);
      case 3:
        return SportPage(title: "HandBall",idSport: "ID_HANDBALL");
      default:
        return SportPage(title: "FootBall",idSport: "ID_FOOTBALL");
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)
    );
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => getWidget(context, widget)
    );
  }
  Widget getWidget(context, widget){
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: getSportPage(indexSelectionner),
        ),
        Material(
        elevation: 60.0,
        child: Container(
          width: widthAnimation.value,
          color: drawerBackgroundColor,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 49.5,),
              CollapsingListTitle(
                title: "INTER ECOLE",
                assetName: "assets/images/sports.png",
                animationController: _animationController,
              ),
              const Divider(color: Colors.white70, height: 10.0, thickness: 5,),
              const SizedBox(height: 147.0,),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, counter){
                    return const Divider(height: 15.0,);
                  },
                  itemBuilder: (context, counter) {
                    return CollapsingListTitle(
                      isSelected: indexSelectionner == counter,
                      title: navigationItems[counter].title,
                      assetName: navigationItems[counter].assetName,
                      animationController: _animationController,
                      onTap: (){
                        setState(() {
                          indexSelectionner = counter;
                        });
                      },
                    );
                  },
                  itemCount: navigationItems.length,
                ),
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  progress: _animationController,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 70.0,),
            ],
          ),
        ),),
      ],
    );
  }
}

