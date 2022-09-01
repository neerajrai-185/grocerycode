import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfController extends GetxController {
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
}
