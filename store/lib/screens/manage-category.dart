import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:store/controllers/category.dart';

class ManageCategoryScreen extends StatelessWidget {
  bool canEdit = false;
  var category = {};
  FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController _titleCtrl = TextEditingController();

  ManageCategoryScreen(
      {Key? key, required this.canEdit, required this.category})
      : super(key: key) {
    if (canEdit) _titleCtrl.text = category["title"];
  }

  CategoryController _categoryCtrl = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${canEdit ? 'Edit' : 'Add'} Category"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Category Name",
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.green,
                ),
                child: Text(
                  "${canEdit ? 'UPDATE' : 'ADD'}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: () {
                  canEdit
                      ? _categoryCtrl.updateCategory(category["id"], {
                          "title": _titleCtrl.text,
                        })
                      : _categoryCtrl.add({"title": _titleCtrl.text});
                },
              ),
            ),
            canEdit
                ? TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      _categoryCtrl.delete(category["id"]);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
