import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  var orders = [].obs;
  var totalOrders = 0.obs;
  var totalRevenue = 0.obs;
  var orderProcessingCount = 0.obs;
  var orderCompletedCount = 0.obs;
  var orderCancelledCount = 0.obs;

  @override
  onInit() {
    super.onInit();
    var today = DateTime.now();
    this.fetchOrders(today.toString());
  }

  calculate() {
    totalOrders.value = orders.length;
    totalRevenue.value = 0;
    orderProcessingCount.value = 0;
    orderCompletedCount.value = 0;
    orderCancelledCount.value = 0;

    orders.forEach((order) {
      print(order);
      if (order["status"] == "COMPLETED") {
        orderCompletedCount.value++;
        //  totalRevenue.value += (order["cartTotal"]).toInt();
      } else if (order["status"] == "PROCESS") {
        orderProcessingCount.value++;
      } else if (order["status"] == "CANCELLED") {
        orderCancelledCount.value++;
      }
    });
  }

  fetchOrders(givenDate) {
    var from = DateTime.parse(givenDate);
    from = DateTime(from.year, from.month, from.day, 0, 0, 0);

    var to = DateTime.parse(givenDate);
    to = DateTime(to.year, to.month, to.day, 23, 59, 59);

    _db
        .collection("orders")
        .where("createdAt", isGreaterThanOrEqualTo: from)
        .where("createdAt", isLessThanOrEqualTo: to)
        .snapshots()
        .listen((res) {
      orders.clear();
      var _tmp = [];
      res.docs.forEach((order) {
        _tmp.add({"id": order.id, ...order.data()});
      });
      orders.assignAll(_tmp);
      calculate();
    });
  }

  updateOrder(id, obj) {
    _db.collection("orders").doc(id).update(obj).then((res) {
      print("Updated");
      calculate();
      //if (Get.isBottomSheetOpen)
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }
}
