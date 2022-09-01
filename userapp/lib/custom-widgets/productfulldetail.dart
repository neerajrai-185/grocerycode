import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';

class ProductFullDetails extends StatelessWidget {
  CartController _cartCtrl = Get.put(CartController());

  String imageURL;
  String title;
  double price;
  String id;
  String desc;

  ProductFullDetails({
    required this.id,
    required this.imageURL,
    required this.title,
    required this.price,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                child: Align(
                  child: Container(
                    color: Colors.green,
                    height: 350,
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Description",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 15,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "$desc",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 18,
                                color: Colors.black54,
                                // fontWeight: FontWeight.bold,
                              ),
                              maxLines: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              Align(
                child: Container(
                  height: 270,
                  width: double.infinity,
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                    scale: 1.0,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.4),
              padding: EdgeInsets.only(left: 4, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "$title",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹ $price",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      child: Icon(Icons.add),
                      //addto cart screen //we will go cart logic
                      onPressed: () {
                        _cartCtrl.addToCart({
                          "id": id,
                          "title": title,
                          "price": price,
                          "qty": 1,
                          "imageURL": imageURL
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
