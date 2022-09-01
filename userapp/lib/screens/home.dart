import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/carouselslider.dart';
import 'package:userapp/controllers/category.dart';
import 'package:userapp/controllers/productdesc.dart';
import 'package:userapp/controllers/products.dart';
import 'package:userapp/custom-widgets/carousel-image.dart';
import 'package:userapp/custom-widgets/category-badge.dart';
import 'package:userapp/custom-widgets/product-card.dart';
import 'package:userapp/custom-widgets/productfulldetail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController _categoryCtrl = Get.put(CategoryController());
  ProductsController _productsCtrl = Get.put(ProductsController());
  CarouselSliderCont _carouselCtrl = Get.put(CarouselSliderCont());
  ProductdescController _productdescCtrl = Get.put(ProductdescController());

  @override
  void initState() {
    super.initState();
    _categoryCtrl.fetchCategories();
    _productsCtrl.fetchProducts();
    _carouselCtrl.fetchCarousels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
          //  IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Obx(
                () => _carouselCtrl.carousels.length != 0
                    ? CarouselSlider.builder(
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        itemCount: _carouselCtrl.carousels.length,
                        itemBuilder: (context, itemIndex, pageViewIndex) {
                          return CarouselSliderImages(
                            imageURL: _carouselCtrl.carousels[itemIndex]
                                ["imageURL"],
                          );
                        },
                      )
                    : Container(),
              ),
            ),
            Container(
              height: 40,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _productsCtrl.products.length,
                  itemBuilder: (bc, index) {
                    return CategoryBadge(
                      title: _productsCtrl.products[index]["title"],
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _productsCtrl.products.length,
                  itemBuilder: (bc, index) {
                    return GestureDetector(
                      onTap: () {
                        //   var timeAgo = timeago.format(_ads[index]["createdAt"]);
                        Get.to(
                          ProductFullDetails(
                            id: _productsCtrl.products[index]["id"],
                            imageURL: _productsCtrl.products[index]["imageURL"],
                            title: _productsCtrl.products[index]["title"],
                            price: _productsCtrl.products[index]["price"],
                            desc: _productsCtrl.products[index]["desc"],
                          ),
                        );
                      },
                      child: ProductCard(
                        id: _productsCtrl.products[index]["id"],
                        imageURL: _productsCtrl.products[index]["imageURL"],
                        title: _productsCtrl.products[index]["title"],
                        price: _productsCtrl.products[index]["price"],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
