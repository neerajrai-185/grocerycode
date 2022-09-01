import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/controllers/carouselslider.dart';

class CarouselManageScreen extends StatefulWidget {
  var canEdit = false;
  var carousel = {};

  CarouselManageScreen(
      {Key? key, required this.canEdit, required this.carousel})
      : super(key: key);

  @override
  _CarouselManageScreenState createState() => _CarouselManageScreenState();
}

class _CarouselManageScreenState extends State<CarouselManageScreen> {
  CarouselSliderCont _carouselCtrl = Get.put(CarouselSliderCont());

  FirebaseFirestore _db = FirebaseFirestore.instance;
  TextEditingController _titleCtrl = TextEditingController();

  var imgURL = "http://placehold.it/150x";

  uploadImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      var filePath = (DateTime.now().millisecondsSinceEpoch).toString();
      _storage
          .ref()
          .child("carousels")
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
    if (widget.canEdit) {
      _titleCtrl.text = widget.carousel["title"]; //product index wise fetching
      imgURL = widget.carousel["imageURL"] != null
          ? widget.carousel["imageURL"]
          : 'http://placehold.it/120x120';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Carousel"),
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
                  labelText: "Image Title",
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
                    "${widget.canEdit ? 'Update' : 'Add'}",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    widget.canEdit
                        ? _carouselCtrl.updateCarousel(widget.carousel["id"],
                            {"title": _titleCtrl.text, "imageURL": imgURL})
                        : _carouselCtrl.add(
                            {"title": _titleCtrl.text, "imageURL": imgURL});
                  },
                ),
              ),
              widget.canEdit
                  ? TextButton(
                      child: Text("Delete"),
                      onPressed: () {
                        _carouselCtrl.delete(widget.carousel["id"]);
                      })
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
