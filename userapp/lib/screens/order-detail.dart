import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetail extends StatelessWidget {
  Map orderObj;

  OrderDetail({
    required this.orderObj,
  });

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy hh:mm");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    print(orderObj["cart"]);
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
              title: Text("Order"),
              subtitle: Text("${toDateString(orderObj["createdAt"])}"),
              trailing: Text("#${orderObj["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              trailing: Text("${orderObj["status"]}"),
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObj["deliveryAddress"]["address"]}"),
            ),
            ListTile(
              title: Text("Payment mode"),
              //subtitle: Text("${orderObj["deliveryAddress"]["address"]}"),
              trailing: Text("${orderObj["paymentMode"]}"),
            ),
            ListTile(
              title: Text("PaymentId"),
              trailing: Text("${orderObj["paymentId"]}"),
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
