import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  final String text;
  final double height;
  final double fontSize;
  final double padding;
  final double radius;

  const Header({
    super.key, 
    this.text = "DALE INC.",
    this.height = 150,
    this.fontSize = 50,
    this.padding = 35,
    this.radius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 4, 88, 99),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(radius), 
            bottomEnd: Radius.circular(radius),
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      );
  }
}