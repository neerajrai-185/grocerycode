import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/*
class SearchController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  var search = [].obs;

  @override
  onInit() {
    super.onInit();
    //  Search();
  }

  Search(obj) {
    _db
        .collection("products")
        .where("categoryId", isGreaterThanOrEqualTo: obj)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((search) {
        _tmp.add({"id": search.id, ...search.data()});
      });
      search.assignAll(_tmp);
    });
  }
}
*/

class DataController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FqueryData(queryString) {
    return _db
        .collection('vegitables')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .get();
  }

  VqueryData(queryString) {
    return _db
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}



/*

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance
        .collection('featured')
        .where('title', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}

*/