import 'package:flutter/material.dart';
import 'package:userapp/controllers/auth.dart';

class ResetScreen extends StatelessWidget {
  AuthController _auth = AuthController();

  TextEditingController _emailCtrl = TextEditingController();

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
                    labelText: "Email Address"),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text("Reset"),
                  onPressed: () {
                    _auth.sendpasswordresetemail(_emailCtrl.text);

                    //Get.offAll(TabScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
