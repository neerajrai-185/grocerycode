import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/profile.dart';
import 'package:userapp/controllers/profile_store.dart';
import 'package:userapp/screens/addresses.dart';
import 'package:userapp/screens/orders.dart';
import 'package:userapp/screens/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:userapp/screens/profile_store.dart';

class AccountScreen extends StatelessWidget {
  ProfileController _profileCtrl = Get.put(ProfileController());
  ProfController _profileCtrll = Get.put(ProfController());

  registerPushNotification() {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      _profileCtrl.updateProfile({"pushToken": token});
    }).catchError((e) {
      print(e);
    });
  }

  registerPushNotificationn() {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      _profileCtrll.updateStoreDetail({"pushToken": token});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(_profileCtrl.userObj["imageURL"]),
              ),
              title: Text("${_profileCtrl.userObj["name"]}"),
              subtitle: Text("${_profileCtrl.userObj["mobile"]}"),
              trailing: TextButton(
                child: Text("Edit"),
                onPressed: () {
                  Get.to(ProfileScreen());
                },
              ),
            ),
          ),
          Obx(
            () => ListTile(
              leading: Icon(Icons.notifications_active_outlined,
                  color: Colors.green),
              title: Text("Notifications"),
              subtitle: Text("Turn on/off Notification"),
              trailing: Switch(
                onChanged: (res) {
                  if (res) {
                    registerPushNotification();
                  } else {
                    _profileCtrl.updateProfile({"pushToken": null});
                  }
                },
                value: _profileCtrl.userObj["pushToken"] != null ? true : false,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined, color: Colors.green),
            title: Text("My Orders"),
            subtitle: Text("Manage My Orders"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Get.to(OrdersScreen());
            },
          ),
          ListTile(
            onTap: () {
              Get.to(AddressesScreen());
            },
            leading: Icon(Icons.note_outlined, color: Colors.green),
            title: Text("My Addresses"),
            subtitle: Text("Manage delivery address"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: () {
              Get.to(ProfileStoreScreen());
              registerPushNotificationn();
            },
            leading: Icon(Icons.note_outlined, color: Colors.green),
            title: Text("Store"),
            subtitle: Text("View Details"),
            trailing: Icon(Icons.arrow_forward),
          ),
/*
          16.height,
          SettingItemWidget(
              title: 'Manage Wallet',
              decoration: boxDecorationRoundedWithShadow(12,
                  backgroundColor: context.cardColor),
              trailing: Icon(Icons.arrow_right, color: grey.withOpacity(0.5)),
              onTap: () {
                //
              }),
              */
        ],
      ),
    );
  }
}
