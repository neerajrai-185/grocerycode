import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';

class OrderController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  CartController _cartCtrl = Get.put(CartController());

  var orders = [].obs;

  @override
  onInit() {
    super.onInit();
    this.fetchOrders();
  }
//Here, data fetching from firebase of the orders based on id. and assigning
//to the list var orders = [].obs.

  fetchOrders() {
    _db
        .collection("orders")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((order) {
        _tmp.add({"id": order.id, ...order.data()});
      });
      orders.assignAll(_tmp);
    });
  }

  createOrder(paymentId, orderId) {
    var obj = {
      "userId": _auth.currentUser!.uid,
      "cart": _cartCtrl.cart.value, //total cart value will goes.
      "deliveryAddress": _cartCtrl.selectedAddress.value,
      //total address value will goes
      "paymentMode": _cartCtrl.paymentMode.value, //same here.
      "createdAt": FieldValue.serverTimestamp(), //here same
      "cartTotal": _cartCtrl.getTotal(), //here same
      "itemCount": _cartCtrl.getProductCount(), //here same.
      "status": "PROCESS", //here same.
      'paymentId': paymentId,
      'orderId': orderId,
    };

    //here, i am pasting whole data of the map to the add as obj. for making collection
    //also, here will be add cart qty , price, product name, cart total etc/
    _db.collection("orders").add(obj).then((res) {
      print("order placed");
      _cartCtrl.clearCart();
      Get.back();
    }).catchError((e) {
      print(e);
      print("error");
    });
  }
}
