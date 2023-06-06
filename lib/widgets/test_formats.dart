import 'package:flutter/material.dart';

class SmallHeader extends StatelessWidget {
  final String text;

  const SmallHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
          letterSpacing: 2
        ), 
      ),
    );
  }
}

class AdjustableText extends StatelessWidget {
  final String text;
  final bool bold;
  final double size;
  const AdjustableText({
    super.key,
    required this.text,
    required this.size,
    required this.bold
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: Colors.black,
        decoration: TextDecoration.none
      ),
    );
  }
}