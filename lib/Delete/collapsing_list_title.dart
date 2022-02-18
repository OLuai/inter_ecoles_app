import 'package:flutter/material.dart';
import 'package:inter_ecoles_app/theme.dart';

class CollapsingListTitle extends StatefulWidget{
  final String title;
  final String assetName;
  final AnimationController animationController;
  final bool isSelected;
  final VoidCallback? onTap;

  const CollapsingListTitle({Key? key,
    required this.title,
    required this.assetName,
    required this.animationController,
    this.isSelected = false,
    this.onTap
  }) : super(key: key);

  @override
  State<CollapsingListTitle> createState() => _CollapsingListTitleState();
}

class _CollapsingListTitleState extends State<CollapsingListTitle> {

  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 60, end: 220).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 0, end: 5).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: widget.isSelected
              ? Colors.blueAccent.withOpacity(0.5)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: const EdgeInsets.symmetric(horizontal: 4.0,),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Row(
          children: <Widget>[
            Image.asset(widget.assetName,height: 42,width: 42,),
            SizedBox(width: sizedBoxAnimation.value,),
            (widthAnimation.value >= 170)
                ? Text(widget.title, style: widget.isSelected
                ? listTitleSelectedTextStyle : listTitleDefaultTextStyle,)
                : Container()
          ],
        ),
      ),
    );
  }
}