import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var categories = [].obs;

  @override
  void onInit() {
    super.onInit();
    this.fetchSubCategories();
  }

  fetchSubCategories() {
    _db.collection("Subcategories").snapshots().listen((event) {
      categories.clear();
      var _tmp = [];
      event.docs.forEach((element) {
        _tmp.add({"id": element.id, "title": element.data()["title"]});
      });
      categories.assignAll(_tmp);
    });
  }

  updateCategory(id, obj) {
    _db.collection("Subcategories").doc(id).update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  add(obj) {
    _db.collection("Subcategories").add(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete(id) {
    _db.collection("Subcategories").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
