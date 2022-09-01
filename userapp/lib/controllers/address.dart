import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  var addresses = [].obs;

  @override
  onInit() {
    super.onInit();
    getAllAddress();
  }

  getAllAddress() {
    _db
        .collection("addresses")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((address) {
        _tmp.add({"id": address.id, ...address.data()});
      });
      addresses.assignAll(_tmp);
    });
  }

  addAddress(obj) {
    obj["userId"] = _auth.currentUser!.uid;
    _db.collection("addresses").add(obj).then((Value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  updateAddress(id, obj) {
    _db.collection("addresses").doc(id).update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  deleteAddress(id) {
    _db.collection("addresses").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
