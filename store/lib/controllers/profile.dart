import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var userObj = {}.obs;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    readStoreDetail();
  }

  readStoreDetail() {
    _db.collection("settings").doc("store").snapshots().listen((res) {
      if (res.data() != null) {
        userObj.assignAll({"id": res.id, ...?res.data()});
      }
    });
  }

  updateStoreDetail(obj) {
    _db.collection("settings").doc("store").update(obj).then((value) {
      print("Updated");
    }).catchError((e) {
      print(e);
    });
  }

  uploadProfileImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
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
          print("uploaded URL" + url);
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
}
