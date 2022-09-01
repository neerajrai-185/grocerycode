import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';

class CartItem extends StatelessWidget {
  CartController _cartCtrl = Get.put(CartController());

  String id;
  String imageURL;
  String title;
  int qty;
  double price;
  double total;

  CartItem(
      {required this.id,
      required this.imageURL,
      required this.title,
      required this.qty,
      required this.price,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: 40,
              width: 40,
              child: Image.network(
                "$imageURL",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Qty $qty x ₹ $price",
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RawMaterialButton(
                        fillColor: Colors.green,
                        elevation: 0,
                        shape: CircleBorder(),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
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
                      Text("$qty"),
                      RawMaterialButton(
                        fillColor: Colors.green,
                        elevation: 0,
                        shape: CircleBorder(),
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 16,
                        ),
                        onPressed: () {
                          _cartCtrl.removeFromCart({
                            "id": id,
                            "title": title,
                            "price": price,
                            "qty": 1,
                            "imageURL": imageURL
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Text(
            "₹ $total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
