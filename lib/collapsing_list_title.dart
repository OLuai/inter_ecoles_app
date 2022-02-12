import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/theme.dart';

class CollapsingListTitle extends StatefulWidget{
  final String title;
  final String assetName;
  final AnimationController animationController;
  final bool isSelected;
  final VoidCallback? onTap;

  CollapsingListTitle({
    required this.title,
    required this.assetName,
    required this.animationController,
    this.isSelected = false,
    this.onTap
  });

  @override
  State<CollapsingListTitle> createState() => _CollapsingListTitleState();
}

class _CollapsingListTitleState extends State<CollapsingListTitle> {

  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 220, end: 70).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.5)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0,),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(widget.assetName),
            ),
            SizedBox(width: sizedBoxAnimation.value,),
            (widthAnimation.value >= 180)
                ? Text(widget.title, style: widget.isSelected
                ? listTitleSelectedTextStyle : listTitleDefaultTextStyle,)
                : Container()
          ],
        ),
      ),
    );
  }
}