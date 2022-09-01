import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CarouselSliderCont extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var carousels = [].obs;

  @override
  void onInit() {
    super.onInit();
    this.fetchCarousels();
  }

  fetchCarousels() {
    _db.collection("carousels").snapshots().listen((event) {
      carousels.clear();
      var _tmp = [];
      event.docs.forEach((element) {
        _tmp.add({"id": element.id, "imageURL": element.data()["imageURL"]});
      });
      carousels.assignAll(_tmp);
    });
  }

/*
  updateCarousel(id, obj) {
    _db.collection("carousels").doc(id).update(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  add(obj) {
    _db.collection("carousels").add(obj).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete(id) {
    _db.collection("carousels").doc(id).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
  */
}
