import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:userapp/controllers/cart.dart';
import 'package:userapp/controllers/orders.dart';
import 'package:userapp/screens/tabs.dart';

class PaymentGateway extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CartController _cartCtrl = Get.put(CartController());
  OrderController _orderCtrl = Get.put(OrderController());

  var razorpay;

  @override
  void onInit() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handleSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    super.onInit();
  }

  placeOrder(paymentId, orderId) {
    var details = {
      'paymentId': paymentId,
      'orderId': orderId,
      'userId': _auth.currentUser!.uid,
      'status': 0,
      'time': FieldValue.serverTimestamp(),
    };
    _db.collection('payments').add(details).then((value) {
      Get.offAll(TabScreen());
    });
  }

  void handleError(PaymentFailureResponse response) {
    // _orderCtrl.createOrder(response.code ?? "", response.message ?? "");
  }

  void handleSuccess(PaymentSuccessResponse response) {
    placeOrder(response.paymentId ?? "", response.orderId ?? "");
    _orderCtrl.createOrder(response.paymentId ?? "", response.orderId ?? "");
  }

  void handleExternalWallet(ExternalWalletResponse externalWalletResponse) {}

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_5dm7DxBLVbGGYs',
      'amount': _cartCtrl.getTotal() * 100,
      'prefill': {'contact': '7041978741', 'email': 'raineeraj185@gmail.com'}
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
