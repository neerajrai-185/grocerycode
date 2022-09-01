import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/auth.dart';

class RegisterScreen extends StatelessWidget {
  AuthController _authCtrl = Get.put(AuthController());

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _confirmpasswordCtrl = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
        title:
            Text("Create New Account", style: TextStyle(color: Colors.green)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
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
                SizedBox(height: 20),
                Text(
                  "Neeraj's Shop",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                    labelText: "Full Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _confirmpasswordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Confirm Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please re-enter password';
                    }
                    print(_passwordCtrl.text);
                    print(_confirmpasswordCtrl.text);

                    if (_passwordCtrl.text != _confirmpasswordCtrl.text) {
                      return "Password does not match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.green,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _authCtrl.register(
                          _nameCtrl.text,
                          _emailCtrl.text,
                          _passwordCtrl.text,
                        );
                        print("successful");

                        return;
                      } else {
                        print("UnSuccessfull");
                      }
                    },
                  ),
                ),
                SizedBox(height: 12),
                TextButton(
                  child: Text(
                    "Already Have Account?",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*
child: ElevatedButton(
    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue)),
    onPressed: () {
    if (_formKey.currentState.validate()) {
        registerToFb();
    }
    },
    child: Text('Submit'),
),
*/