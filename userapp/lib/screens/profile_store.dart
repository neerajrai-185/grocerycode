import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/profile_store.dart';

class ProfileStoreScreen extends StatelessWidget {
  static ProfController _profileCtrll = Get.put(ProfController());

  TextEditingController _nameCtrl =
      TextEditingController(text: _profileCtrll.userObj["name"]);
  TextEditingController _emailCtrl =
      TextEditingController(text: _profileCtrll.userObj["email"]);
  TextEditingController _mobileCtrl =
      TextEditingController(text: _profileCtrll.userObj["mobile"]);
  TextEditingController _addressCtrl =
      TextEditingController(text: _profileCtrll.userObj["address"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Store Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                child: Obx(
                  () => CircleAvatar(
                    backgroundImage:
                        NetworkImage(_profileCtrll.userObj["imageURL"]),
                    radius: 60,
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                enabled: false,
                controller: _nameCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Name",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                enabled: false,
                controller: _emailCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                enabled: false,
                controller: _mobileCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                enabled: false,
                controller: _addressCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Address",
                ),
              ),
              SizedBox(height: 12),

              // SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}






/*
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:store/controllers/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController _auth = AuthController();

  //FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var _profileImage = "http://placehold.it/120x120";

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();

  readStoreDetail() {
    _db.collection("settings").doc("store").snapshots().listen((res) {
      print(res);
      print(res.id);
      print(res.data());

      setState(() {
        _nameCtrl.text = res.data()!["name"];
        _emailCtrl.text = res.data()!["email"];
        _mobileCtrl.text = res.data()!["mobile"];
        _addressCtrl.text = res.data()!["address"];
        _profileImage = res.data()!["imageURL"];
      });
    });
  }

  updateStoreDetail() {
    _db.collection("settings").doc("store").update({
      "address": _addressCtrl.text,
      "mobile": _mobileCtrl.text,
      "email": _emailCtrl.text,
      "name": _nameCtrl.text,
    }).then((Value) {
      print("Updated");
    }).catchError((e) {
      print(e);
    });
  }

  uploadProfileImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      _storage
          .ref()
          .child("store")
          .child("storeImage")
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          print("upload URL" + url);

          _db
              .collection("settings")
              .doc("store")
              .update({"imageURL": url}).then((value) {
            print("Updated");
          }).catchError((e) {
            print(e);
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("No file picked");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readStoreDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit Store"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadProfileImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profileImage),
                  radius: 60,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Name",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _mobileCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _addressCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Address",
                ),
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
                  onPressed: () {
                    updateStoreDetail();
                  },
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _auth.logout();
                  //Get.offAll(LoginScreen());
                },
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/