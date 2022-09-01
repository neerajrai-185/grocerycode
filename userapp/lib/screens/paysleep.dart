import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/paymentid.dart';
import 'package:intl/intl.dart';

class PayScreen extends StatelessWidget {
  PayController _payCtrl = Get.put(PayController());

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy hh:mm");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay Orders"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: _payCtrl.payId.length,
          itemBuilder: (bc, index) {
            return ListTile(
              title: Text("# ${_payCtrl.payId[index]["paymentId"]}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${toDateString(_payCtrl.payId[index]["time"])}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
