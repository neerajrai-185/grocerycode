import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:userapp/controllers/auth.dart';
import 'package:userapp/screens/login.dart';
import 'package:userapp/screens/tabs.dart';
import 'package:userapp/screens/welcome.dart';

class ValidateScreen extends StatelessWidget {
  AuthController _auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => _auth.isUserLoggedIn.value ? TabScreen() : WelcomeScreens());
  }
}
