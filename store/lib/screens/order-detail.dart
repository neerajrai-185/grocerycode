import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:store/controllers/orders.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatelessWidget {
  Map orderObj;
  OrderController _orderCtrl = Get.put(OrderController());

  OrderDetail({
    required this.orderObj,
  });

  void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy hh:mm");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("#${orderObj["id"]} - ${orderObj["status"]}"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Customer"),
              subtitle: Text("${orderObj["deliveryAddress"]["name"]}"),
              trailing: TextButton(
                child: Text("Call"),
                onPressed: () {
                  _launchURL("tel:${orderObj["deliveryAddress"]["mobile"]}");
                },
              ),
            ),
            ListTile(
              title: Text("Order"),
              subtitle: Text("${toDateString(orderObj["createdAt"])}"),
              trailing: Text("#${orderObj["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              trailing: Text("${orderObj["status"]}"),
              onTap: () {
                Get.bottomSheet(
                  BottomSheet(
                    onClosing: () {},
                    builder: (bc) => Wrap(
                      children: [
                        ListTile(
                          title: Text("Mark as completed"),
                          onTap: () {
                            _orderCtrl.updateOrder(orderObj["id"], {
                              "status": "COMPLETED",
                            });
                          },
                        ),
                        ListTile(
                          title: Text("Mark as Cancelled"),
                          onTap: () {
                            _orderCtrl.updateOrder(orderObj["id"], {
                              "status": "CANCELLED",
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObj["deliveryAddress"]["address"]}"),
              trailing: Text("${orderObj["paymentMode"]}"),
            ),
            ListTile(
              title: Text("Payment Mode"),
              trailing: Text("${orderObj["paymentMode"]}"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "CART ITEMS",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderObj["cart"].length,
                itemBuilder: (bc, index) {
                  return ListTile(
                    title: Text(
                      "${orderObj["cart"][index]["title"]}",
                    ),
                    subtitle: Text(
                        "Qty: ${orderObj["cart"][index]["qty"]} x ₹ ${orderObj["cart"][index]["price"]}"),
                    trailing: Text(
                      "₹ ${orderObj["cart"][index]["total"]}",
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.green,
              height: 80,
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "₹ ${orderObj["cartTotal"]}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*

import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  Map orderObj;

  OrderDetail({
    required this.orderObj,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("#${orderObj["id"]} - ${orderObj["status"]}"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Customer"),
              subtitle: Text("neerajrai"),
              trailing: TextButton(
                child: Text("Call"),
                onPressed: () {},
              ),
            ),
            ListTile(
              title: Text("Order"),
              subtitle: Text("${orderObj["dateString"]}"),
              trailing: Text("#${orderObj["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              trailing: Text("${orderObj["status"]}"),
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObj["deliveryAddress"]}"),
              trailing: Text("${orderObj["paymentMethod"]}"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "CART ITEMS",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderObj["cartItems"].length,
                itemBuilder: (bc, index) {
                  return ListTile(
                    title: Text(
                      "${orderObj["cartItems"][index]["title"]}",
                    ),
                    subtitle: Text(
                        "Qty: ${orderObj["cartItems"][index]["qty"]} x ₹ ${orderObj["cartItems"][index]["price"]}"),
                    trailing: Text(
                      "₹ ${orderObj["cartItems"][index]["total"]}",
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.green,
              height: 80,
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "₹ ${orderObj["cartTotal"]}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/