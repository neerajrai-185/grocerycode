import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/address.dart';
import 'package:userapp/screens/manage-address.dart';

class AddressesScreen extends StatelessWidget {
  AddressController _addressCtrl = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      body: Obx(
        () => ListView.builder(
            itemCount: _addressCtrl.addresses.length,
            itemBuilder: (bc, index) {
              return ListTile(
                title: Text("${_addressCtrl.addresses[index]['tag']}"),
                subtitle: Text("${_addressCtrl.addresses[index]['address']}"),
                trailing: IconButton(
                  icon: Icon(Icons.edit_outlined),
                  onPressed: () {
                    Get.to(ManageAddressScreen(
                      canEdit: true,
                      address: _addressCtrl.addresses[index],
                    ));
                  },
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ManageAddressScreen(
            canEdit: false,
            address: {},
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
