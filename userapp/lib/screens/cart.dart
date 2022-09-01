import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/address.dart';
import 'package:userapp/controllers/cart.dart';
import 'package:userapp/controllers/orders.dart';
import 'package:userapp/custom-widgets/cart-item.dart';
import 'package:userapp/screens/payamount.dart';

class CartScreen extends StatelessWidget {
  CartController _cartCtrl = Get.put(CartController());
  AddressController _addressCtrl = Get.put(AddressController());
  OrderController _orderCtrl = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Container(
            child: _cartCtrl.getProductCount() == 0
                ? Text("Cart is Empty")
                : Text("Cart - ${_cartCtrl.getProductCount()} Items"),
          ),
        ),
      ),
      body: Obx(
        () => Container(
          child: _cartCtrl.getProductCount() == 0
              ? Center(child: Text("No Items In Cart"))
              : Column(
                  children: [
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: _cartCtrl.cart.length,
                          itemBuilder: (bc, index) {
                            //cart Items class constructor.
                            return CartItem(
                              id: _cartCtrl.cart[index]["id"],
                              imageURL: _cartCtrl.cart[index]["imageURL"],
                              title: _cartCtrl.cart[index]["title"],
                              qty: _cartCtrl.cart[index]["qty"],
                              price: _cartCtrl.cart[index]["price"],
                              total: _cartCtrl.cart[index]["total"],
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Obx(
                            () => ListTile(
                              title: Text("Delivery Address"),
                              subtitle: Text(
                                  "${_cartCtrl.selectedAddress["address"]}"),
                              trailing: TextButton(
                                child: Text("Change"),
                                onPressed: () {
                                  _addressCtrl.getAllAddress();
                                  Get.bottomSheet(
                                    BottomSheet(
                                        onClosing: () {},
                                        builder: (bc) {
                                          return Wrap(
                                            //here address is coming by calling through controller class obj _addressCtrl.addresses array here.
                                            children:
                                                _addressCtrl.addresses.map((a) {
                                              return ListTile(
                                                  title: Text("${a['tag']}"),
                                                  subtitle:
                                                      Text("${a['address']}"),
                                                  onTap: () {
                                                    _cartCtrl.selectedAddress
                                                        .value = a;
                                                    //here storing the address to the cart classs. by calling _cartCtrl through
                                                    //if (Get.isBottomSheetOpen)
                                                    Get.back();
                                                  });
                                            }).toList(),
                                          );
                                        }),
                                  );
                                },
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text("Payment Method"),
                            subtitle: Obx(
                              () => Text("${_cartCtrl.paymentMode}"),
                            ),
                            trailing: TextButton(
                              child: Text("Change"),
                              onPressed: () {
                                Get.bottomSheet(
                                  BottomSheet(
                                      onClosing: () {},
                                      builder: (bc) {
                                        return Wrap(
                                          children: [
                                            ListTile(
                                                title: Text("Cash on Delivery"),
                                                onTap: () {
                                                  _cartCtrl.paymentMode.value =
                                                      "COD";
                                                  // if (Get.isBottomSheetOpen)
                                                  Get.back();
                                                }),
                                            ListTile(
                                                title: Text("Card"),
                                                onTap: () {
                                                  _cartCtrl.paymentMode.value =
                                                      "Razorpay ";
                                                  //Get.to(CheckoutScreen());
                                                  //if (Get.isBottomSheetOpen)
                                                  Get.back();
                                                }),
                                            // ListTile(
                                            //     title: Text("PayPal"),
                                            //     onTap: () {
                                            //      _cartCtrl.paymentMode.value =
                                            //        "PAYPAL";
                                            // if (Get.isBottomSheetOpen)
                                            //    Get.back();
                                            //  }),
                                            //  ListTile(
                                            //     title: Text("Others"),
                                            //   onTap: () {
                                            //    _cartCtrl.paymentMode.value =
                                            //        "OTHERS";
                                            // if (Get.isBottomSheetOpen)
                                            //   Get.back();
                                            //})
                                          ],
                                        );
                                      }),
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.0),
                                //  width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                  ),
                                  child: Obx(
                                    () => Text(
                                        "Checkout (₹ ${_cartCtrl.getTotal()})"),
                                  ),
                                  onPressed: () {
                                    Get.to(CheckoutScreen());
                                    /*
                                  Get.defaultDialog(
                                    title: "Confirmation",
                                    content: Text(
                                        "Are You sure want to place this order?"),
                                    onConfirm: () {
                                      _orderCtrl.createOrder();
                                    },
                                    onCancel: () {
                                      Get.back();
                                    },
                                  );
                                  */
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(4.0),
                                //   width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                  ),
                                  child: Obx(
                                    () => Text(
                                        "Cash On (₹ ${_cartCtrl.getTotal()})"),
                                  ),
                                  onPressed: () {
                                    // Get.to(CheckoutScreen());

                                    Get.defaultDialog(
                                      title: "Confirmation",
                                      content: Text(
                                          "Are You sure want to place this order?"),
                                      onConfirm: () {
                                        _orderCtrl.createOrder(
                                          '',
                                          '',
                                        );
                                      },
                                      onCancel: () {
                                        Get.back();
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
