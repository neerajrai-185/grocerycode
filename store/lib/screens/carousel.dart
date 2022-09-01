import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/carouselslider.dart';
import 'package:store/screens/manage-carousel.dart';
import 'package:store/screens/subcategoriesjuicy.dart';

class CarouselScreen extends StatelessWidget {
  CarouselSliderCont _carouselCtrl = Get.put(CarouselSliderCont());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(CarouselManageScreen(
                canEdit: false,
                carousel: {},
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
                    Get.to(SubCategoriesScreen());
                  },
                  child: Text("Manage Carousel Images")),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: _carouselCtrl.carousels.length,
                  itemBuilder: (bc, index) {
                    return ListTile(
                      title: Text("${_carouselCtrl.carousels[index]["title"]}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                        ),
                        onPressed: () {
                          Get.to(CarouselManageScreen(
                              canEdit: true,
                              carousel: _carouselCtrl.carousels[index]));
                          //product["id"]//calling constructor
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
