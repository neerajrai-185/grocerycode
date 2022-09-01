import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/auth.dart';
import 'package:userapp/screens/register.dart';
import 'package:userapp/screens/reset-password.dart';
import 'package:userapp/screens/tabs.dart';

class LoginScreen extends StatelessWidget {
  AuthController _auth = AuthController();

  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.green),
          title: Text(
            "Neeraj's Shop",
            style: TextStyle(color: Colors.green),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/images/logo.png",
                height: 120,
                width: 120,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Neeraj's shop",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Password",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text("Login"),
                  onPressed: () {
                    _auth.login(_emailCtrl.text, _passwordCtrl.text);

                    //   Get.offAll(TabScreen());
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: TextButton(
                  child: Text("Reset Password"),
                  onPressed: () {
                    Get.to((ResetScreen()));
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: TextButton(
                  child: Text("Create New Account"),
                  onPressed: () {
                    Get.to(RegisterScreen());
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, elevation: 0),
                      onPressed: () {
                        _auth.signInWithFacebook();
                      },
                      child: Image.asset(
                        "lib/assets/images/fb-icon.png",
                        height: 32,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, elevation: 0),
                      onPressed: () {
                        _auth.signInWithGoogle();
                      },
                      child: Image.asset(
                        "lib/assets/images/google-icon.png",
                        height: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
