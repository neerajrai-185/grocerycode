import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/orders.dart';
import 'package:userapp/screens/order-detail.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  OrderController _orderCtrl = Get.put(OrderController());

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Orders"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _orderCtrl.orders.length,
          itemBuilder: (bc, index) {
            return ListTile(
              title: Text("# ${_orderCtrl.orders[index]["id"]}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${toDateString(_orderCtrl.orders[index]["createdAt"])}"),
                  Text(
                      "${_orderCtrl.orders[index]["itemCount"]} Items - ₹ ${_orderCtrl.orders[index]["cartTotal"]}"),
                ],
              ),
              isThreeLine: true,
              trailing: Text("${_orderCtrl.orders[index]["status"]}"),
              onTap: () {
                Get.to(
                  OrderDetail(
                    orderObj: _orderCtrl.orders[index],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
