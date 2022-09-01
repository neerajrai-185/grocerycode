import 'package:flutter/material.dart';
import 'package:store/controllers/auth.dart';

class LoginScreen extends StatelessWidget {
  AuthController _auth = AuthController();

  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/images/logo.png",
                height: 120,
                width: 120,
              ),
              SizedBox(height: 16),
              Text(
                "Neeraj's shop",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text("LOGIN"),
                  onPressed: () {
                    _auth.login(_emailCtrl.text, _passwordCtrl.text);
                    //Get.offAll(TabsScreen());
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
