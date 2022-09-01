import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WelcomeSlide extends StatelessWidget {
  String image;
  String title;
  String subtitle;

  WelcomeSlide(
      {required this.image, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: 1.0,
            height: 400,
          ),
          SizedBox(height: 4),
          Text(
            "$title",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            "$subtitle",
          ),
        ],
      ),
    );
  }
}
