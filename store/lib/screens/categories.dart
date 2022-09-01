import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/category.dart';
import 'package:store/screens/carousel.dart';
import 'package:store/screens/manage-category.dart';

class CategoriesScreen extends StatelessWidget {
  CategoryController _categoryCtrl = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ManageCategoryScreen(
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
              child: TextButton(
                  onPressed: () {
                    Get.to(CarouselScreen());
                  },
                  child: Text("Manage Carousel Images")),
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
                        Get.to(ManageCategoryScreen(
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
