import 'package:flutter/material.dart';

class CarouselSliderImages extends StatelessWidget {
  String imageURL;

  CarouselSliderImages({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      child: Image.network(
        imageURL,
        fit: BoxFit.cover,
        scale: 1.0,
      ),
    );
  }
}
