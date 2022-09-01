import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/products.dart';
import 'package:store/screens/categories.dart';
import 'package:store/screens/manage-product.dart';

class ProductsScreen extends StatelessWidget {
  ProductsController _productsCtrl = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ManageProductScreen(canEdit: false, product: {}));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    Get.to(CategoriesScreen());
                  },
                  child: Text("Manage Categories")),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _productsCtrl.products.length,
                  itemBuilder: (bc, index) {
                    return ListTile(
                      title: Text("${_productsCtrl.products[index]["title"]}"),
                      subtitle:
                          Text("${_productsCtrl.products[index]["price"]}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                        onPressed: () {
                          Get.to(ManageProductScreen(
                              canEdit: true,
                              product: _productsCtrl.products[index]));
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
