import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PayController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  var payId = [].obs;

  @override
  void onInit() {
    super.onInit();
    this.fetchpayids();
  }

  fetchpayids() {
    _db
        .collection("payments")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((payment) {
        _tmp.add({"id": payment.id, ...payment.data()});
      });
      payId.assignAll(_tmp);
    });
  }
}
