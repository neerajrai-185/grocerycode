import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductdescController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var productsdesc = [].obs;

  @override
  onInit() {
    super.onInit();
    getProductdesc();
  }

  getProductdesc() {
    _db
        .collection("products")
        .where("categoryId", isEqualTo: "categoryId")
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((productdesc) {
        _tmp.add({"id": productdesc.id, ...productdesc.data()});
      });
      productsdesc.assignAll(_tmp);
    });
  }
}
