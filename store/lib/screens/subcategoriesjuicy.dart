import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/category.dart';
import 'package:store/controllers/subcategoryjuicy.dart';
import 'package:store/screens/carousel.dart';
import 'package:store/screens/categories.dart';
import 'package:store/screens/manage-category.dart';
import 'package:store/screens/sub-manage-categoryjuicy.dart';

class SubCategoriesScreen extends StatelessWidget {
  SubCategoryController _categoryCtrl = Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SubCategories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(SubManageCategoryScreen(
                canEdit: false,
                category: {},
              ));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                /*
              child: TextButton(
                  onPressed: () {
                    Get.to(SubCategoriesScreen());
                  },
                  child: Text("Juicy Manage Category screen")),
                  */
                ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _categoryCtrl.categories.length,
                  itemBuilder: (bc, index) {
                    return ListTile(
                      title:
                          Text("${_categoryCtrl.categories[index]["title"]}"),
                      trailing: Icon(Icons.edit_outlined),
                      onTap: () {
                        //here manage category screen it will be used for if condition when it will be true
                        Get.to(SubManageCategoryScreen(
                          canEdit: true,
                          category: _categoryCtrl.categories[index],
                        ));
                      },
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
