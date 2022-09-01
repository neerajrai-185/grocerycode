/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:userapp/controllers/address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ManageAddressScreen extends StatefulWidget {
  bool canEdit;
  var address;
  ManageAddressScreen({Key? key, required this.canEdit, this.address})
      : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  double _lat = 13.0827;
  double _lng = 80.2707;

  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late CameraPosition _currentPosition;

  AddressController _addressController = Get.put(AddressController());

  TextEditingController _tagCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _pinCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.canEdit) {
      _tagCtrl.text = widget.address["tag"];
      _nameCtrl.text = widget.address["name"];
      _mobileCtrl.text = widget.address["mobile"];
      _addressCtrl.text = widget.address["address"];
      _pinCtrl.text = widget.address["pincode"];
    }

    fetchMyLocation() async {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      await location.getLocation().then((res) async {
        final GoogleMapController controller = await _controller.future;
        final _position = CameraPosition(
          target: LatLng(res.latitude, res.longitude),
          zoom: 12,
        );
        controller.animateCamera(CameraUpdate.newCameraPosition(_position));
        setState(() {
          _lat = res.latitude!;
          _lng = res.longitude!;
        });
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Address"),
        actions: [
          widget.canEdit
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _addressController.deleteAddress(widget.address["id"]);
                  })
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_lat, _lng),
                  zoom: 12,
                ),
                onMapCreated: (res) {
                  _controller.complete(res);
                  //  fetchMyLocation();
                },
                markers: {
                  Marker(
                      markerId: MarkerId("current"),
                      position: LatLng(_lat, _lng),
                      draggable: true,
                      onDragEnd: (latlng) {
                        // generateAddress(latlng.latitude, latlng.longitude);
                      }),
                },
              ),
              height: 180,
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _tagCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: " Tag (Eg. Home, Office"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _mobileCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Mobile Number"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _addressCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Full Address"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _pinCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Pin Code"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.green,
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        widget.canEdit
                            ? _addressController
                                .updateAddress(widget.address["id"], {
                                "tag": _tagCtrl.text,
                                "name": _nameCtrl.text,
                                "mobile": _mobileCtrl.text,
                                "address": _addressCtrl.text,
                                "pincode": _pinCtrl.text
                              })
                            : _addressController.addAddress({
                                "tag": _tagCtrl.text,
                                "name": _nameCtrl.text,
                                "mobile": _mobileCtrl.text,
                                "address": _addressCtrl.text,
                                "pincode": _pinCtrl.text
                              });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/address.dart';

class ManageAddressScreen extends StatefulWidget {
  bool canEdit;
  var address;
  ManageAddressScreen({Key? key, required this.canEdit, this.address})
      : super(key: key);

  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  AddressController _addressController = Get.put(AddressController());

  TextEditingController _tagCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _pinCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.canEdit) {
      _tagCtrl.text = widget.address["tag"];
      _nameCtrl.text = widget.address["name"];
      _mobileCtrl.text = widget.address["mobile"];
      _addressCtrl.text = widget.address["address"];
      _pinCtrl.text = widget.address["pincode"];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.canEdit ? 'Edit' : 'Add'} Address"),
        actions: [
          widget.canEdit
              ? IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _addressController.deleteAddress(widget.address["id"]);
                  })
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                "lib/assets/images/map.png",
                fit: BoxFit.cover,
              ),
              height: 180,
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _tagCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: " Tag (Eg. Home, Office"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _nameCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Name"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _mobileCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Mobile Number"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _addressCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Full Address"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _pinCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: InputBorder.none,
                        labelText: "Pin Code"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.green,
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                        widget.canEdit
                            ? _addressController
                                .updateAddress(widget.address["id"], {
                                "tag": _tagCtrl.text,
                                "name": _nameCtrl.text,
                                "mobile": _mobileCtrl.text,
                                "address": _addressCtrl.text,
                                "pincode": _pinCtrl.text
                              })
                            : _addressController.addAddress({
                                "tag": _tagCtrl.text,
                                "name": _nameCtrl.text,
                                "mobile": _mobileCtrl.text,
                                "address": _addressCtrl.text,
                                "pincode": _pinCtrl.text
                              });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
