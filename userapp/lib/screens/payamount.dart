/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Razorpay Sample App'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              ElevatedButton(onPressed: openCheckout, child: Text('Open'))
            ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  Future<void> placeOrder(paymentId, orderId) async {
    try {
      Map<String, dynamic> details = {
        'paymentId': paymentId,
        'orderId': orderId,
        'status': 0,
        'time': FieldValue.serverTimestamp(),
      };

      await _db.collection('payments').add(details).then((value) {
        Get.back();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_5dm7DxBLVbGGYs',
      'amount': 100,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Future.wait([
      placeOrder(response.paymentId ?? "", response.orderId ?? ""),
    ]).then((value) {
      print("Payment Sucessfull");
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {}
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:userapp/controllers/cart.dart';
import 'package:userapp/controllers/orders.dart';
import 'package:userapp/screens/tabs.dart';

//OrderController _orderCtrl = Get.put(OrderController());

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CartController _cartCtrl = Get.put(CartController());
  OrderController _orderCtrl = Get.put(OrderController());

  late Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Pay'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "WELCOME TO THE RAZORPAY",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: Text(
                    "Please Click Below",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: openCheckout,
                  child: Text(
                    'Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
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

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_5dm7DxBLVbGGYs',
      'amount': _cartCtrl.getTotal() * 100,
      'prefill': {
        'contact': _auth.currentUser!.phoneNumber,
        'email': _auth.currentUser!.email,
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    placeOrder(response.paymentId ?? "", response.orderId ?? "");
    _orderCtrl.createOrder(response.paymentId ?? "", response.orderId ?? "");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // _orderCtrl.createOrder(response.code ?? "", response.message ?? "");
  }
}
