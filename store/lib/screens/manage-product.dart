import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/controllers/category.dart';
import 'package:store/controllers/products.dart';

class ManageProductScreen extends StatefulWidget {
  var canEdit = false;
  var product = {};

  ManageProductScreen({Key? key, required this.canEdit, required this.product})
      : super(key: key);

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  ProductsController _productCtrl = Get.put(ProductsController());
  CategoryController _categoryCtrl = Get.put(CategoryController());

  var _categories = [];
  String? _selectedId = "5VLM3Y5ci4eYDemxlMbi";

  FirebaseFirestore _db = FirebaseFirestore.instance;
  var imgURL = "http://placehold.it/150x";

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

  fetchCategories() {
    _db.collection("categories").snapshots().listen((event) {
      var _tmp = [];
      for (var element in event.docs) {
        _tmp.add({
          "id": element.id,
          "title": element.data()["title"],
        });
      }
      setState(() {
        _categories = _tmp;
      });
    });
  }

  uploadImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      var filePath = (DateTime.now().millisecondsSinceEpoch).toString();
      _storage
          .ref()
          .child("products")
          .child(filePath)
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          print("uploaded URL" + url);
          setState(() {
            imgURL = url;
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("No file picked");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    if (widget.canEdit) {
      _titleCtrl.text = widget.product["title"];
      _priceCtrl.text = (widget.product["price"]).toString();
      _descCtrl.text = widget.product["desc"];
      _selectedId = widget.product["categoryId"];
      imgURL = widget.product["imageURL"] != null
          ? widget.product["imageURL"]
          : 'http://placehold.it/120x120';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgURL),
                  radius: 60,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Product Title",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _priceCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Price",
                ),
              ),
              SizedBox(height: 12),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category"),
                    Obx(
                      () => DropdownButton(
                        value: _selectedId,
                        onChanged: (v) {
                          setState(() {
                            _selectedId = v.toString();
                          });
                        },
                        items: _categoryCtrl.categories.map((category) {
                          return DropdownMenuItem(
                            value: category["id"],
                            child: Text(category["title"]),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Description",
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
                    "${widget.canEdit ? 'Update' : 'Add'} Product",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    widget.canEdit
                        ? _productCtrl.updateProduct(widget.product["id"], {
                            "title": _titleCtrl.text,
                            "price": double.parse(_priceCtrl.text),
                            "categoryId": _selectedId,
                            "desc": _descCtrl.text,
                            "imageURL": imgURL
                          })
                        : _productCtrl.add({
                            "title": _titleCtrl.text,
                            "price": double.parse(_priceCtrl.text),
                            "categoryId": _selectedId,
                            "desc": _descCtrl.text,
                            "imageURL": imgURL
                          });
                  },
                ),
              ),
              widget.canEdit
                  ? TextButton(
                      child: Text("Delete"),
                      onPressed: () {
                        _productCtrl.delete(widget.product["id"]);
                      })
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
