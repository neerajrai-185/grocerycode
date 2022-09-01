/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/search.dart';
import 'package:userapp/custom-widgets/ProductCardSearch.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _search = TextEditingController();
  SearchController _searchCtrl = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
    // _searchCtrl.Search();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.clear), onPressed: () {}),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchCtrl.Search(_search.text);
            },
          )
        ],
        title: TextField(
          controller: _search,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: InputBorder.none,
              hintText: "Search Product"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: _searchCtrl.search.length,
                itemBuilder: (bc, index) {
                  return ProductCardSearch(
                    id: _searchCtrl.search[index]["id"],
                    imageURL: _searchCtrl.search[index]["imageURL"],
                    title: _searchCtrl.search[index]["title"],
                    price: _searchCtrl.search[index]["price"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _search = TextEditingController();
  SearchController _searchCtrl = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.clear), onPressed: () {}),
      //backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchCtrl.Search(_search.text);
              //Get.offAll(TabsScreen());
            },
          )
        ],
        title: TextField(
          controller: _search,

          // maxLines: 1,
          decoration: InputDecoration(
              filled: true,

              // fillColor: Colors.orange,
              fillColor: Colors.grey[200],
              border: InputBorder.none,
              hintText: "Search Product"),
        ),
        //   backgroundColor: Colors.white,

        /*
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefix: Icon(Icons.search), hintText: "Search Products"),
          ),
        ),
        */
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/search.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchController = TextEditingController();
  late QuerySnapshot snapshotData;
  bool isExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshotData.docs[index]['imageURL']),
              ),
              title: Text(
                snapshotData.docs[index]['title'],
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),
              ),
              subtitle: Text(
                snapshotData.docs[index]['price'].toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              isExcecuted = false;
            });
          }),
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
            init: DataController(),
            builder: (val) {
              return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    val.VqueryData(searchController.text).then((value) {
                      snapshotData = value;
                      setState(() {
                        isExcecuted = true;
                      });
                    });
                  });
            },
          ),
        ],
        title: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              hintText: 'Search Product',
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
        backgroundColor: Colors.black,
      ),
      body: isExcecuted
          ? searchedData()
          : Container(
              child: Center(
                child: Text('Search any product',
                    style: TextStyle(color: Colors.white, fontSize: 30.0)),
              ),
            ),
    );
  }
}
