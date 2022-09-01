import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';

class ProductCardSearch extends StatelessWidget {
  CartController _cartCtrl = Get.put(CartController());

  String imageURL;
  String title;
  double price;
  String id;

  ProductCardSearch({
    required this.id,
    required this.imageURL,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                imageURL,
                fit: BoxFit.cover,
                scale: 1.0,
              ),
            ),
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
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹ $price",
                          style: TextStyle(
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
