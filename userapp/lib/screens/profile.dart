import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/auth.dart';
import 'package:userapp/controllers/profile.dart';

class ProfileScreen extends StatelessWidget {
  static AuthController _auth = Get.put(AuthController());
  static ProfileController _profileCtrl = Get.put(ProfileController());

  TextEditingController _nameCtrl =
      TextEditingController(text: _profileCtrl.userObj["name"]);
  TextEditingController _emailCtrl =
      TextEditingController(text: _profileCtrl.userObj["email"]);
  TextEditingController _mobileCtrl =
      TextEditingController(text: _profileCtrl.userObj["mobile"]);
//  TextEditingController _addressCtrl =
  //     TextEditingController(text: _profileCtrl.userObj["address"]);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _profileCtrl.uploadProfileImage();
                  },
                  child: Obx(
                    () => CircleAvatar(
                      backgroundImage:
                          NetworkImage(_profileCtrl.userObj["imageURL"]),
                      radius: 60,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Full Name",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
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
                      return 'Enter @';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _mobileCtrl,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Mobile Number",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Mobile No';
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
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    //  onPressed: () {
                    //    _profileCtrl.updateProfile({
                    //      "mobile": _mobileCtrl.text,
                    //      "email": _emailCtrl.text,
                    //      "name": _nameCtrl.text,
                    //    });
                    //  },

                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _profileCtrl.updateProfile({
                          "mobile": _mobileCtrl.text,
                          "email": _emailCtrl.text,
                          "name": _nameCtrl.text,
                        });
                        print("Profile successful");

                        return;
                      } else {
                        print("Profile UnSuccessfull");
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    _auth.logout();
                  },
                  child: Text("Logout"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
