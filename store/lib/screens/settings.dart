import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/profile.dart';
import 'package:store/screens/categories.dart';
import 'package:store/screens/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:store/screens/subcategoriesjuicy.dart';

class SettingsScreen extends StatelessWidget {
  ProfileController _profileCtrl = Get.put(ProfileController());

  registerPushNotification() {
    FirebaseMessaging.instance.getToken().then((token) {
      print(token);
      _profileCtrl.updateStoreDetail({"pushToken": token});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: [
            Obx(
              () => ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(_profileCtrl.userObj["imageURL"]),
                ),
                title: Text("${_profileCtrl.userObj["name"]}"),
                subtitle: Text("${_profileCtrl.userObj["address"]}"),
                trailing: TextButton(
                  onPressed: () {
                    Get.to(ProfileScreen());
                  },
                  child: Text("Edit"),
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
                      _profileCtrl.updateStoreDetail({"pushToken": null});
                    }
                  },
                  value:
                      _profileCtrl.userObj["pushToken"] != null ? true : false,
                ),
              ),
            ),
            ListTile(
              // leading: Icon(Icons.shopping_bag_outlined, color: Colors.green),
              title: Text("Sub Categories"),
              //subtitle: Text("Manage Juicy"),
              //trailing: Icon(Icons.arrow_forward),
              //onTap: () {
              // Get.to(SubCategoriesScreen());
              //},
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined, color: Colors.green),
              title: Text("Juicy"),
              subtitle: Text("Manage Juicy"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Get.to(SubCategoriesScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined, color: Colors.green),
              title: Text("Row"),
              subtitle: Text("Manage Row"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Get.to(SubCategoriesScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}




/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/profile.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("lib/assets/images/profile.png"),
              ),
              title: Text("Sundar Shop"),
              subtitle: Text("234, SF St, 312"),
              trailing: TextButton(
                onPressed: () {
                  Get.to(ProfileScreen());
                },
                child: Text("Edit"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text("Notifications"),
              subtitle: Text("Manage Notifications"),
              trailing: Switch(
                onChanged: (i) {},
                value: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/