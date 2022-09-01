import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/custom-widgets/welcome-side.dart';
import 'package:userapp/screens/login.dart';

class WelcomeScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: double.infinity,
                ),
                items: [
                  WelcomeSlide(
                    image: "lib/assets/images/slide_1.png",
                    title: "Get Fresh Food",
                    subtitle: "Get Fresh Food for your family",
                  ),
                  WelcomeSlide(
                    image: "lib/assets/images/slide_2.png",
                    title: "Secure Payments",
                    subtitle: "All your payments are securely processed",
                  ),
                  WelcomeSlide(
                    image: "lib/assets/images/slide_3.png",
                    title: "Fast Delivery",
                    subtitle: "Don't wait too much , we offer fast delivery",
                  ),
                ],
              ),
            )),
            Container(
              height: 80,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text("Getting Started",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                onPressed: () {
                  Get.to(LoginScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
