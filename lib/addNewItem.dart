import 'dart:convert';
import 'dart:io';

import 'package:au_auto/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class addNewItem extends StatelessWidget {
  static const String _title = 'AU AUTO';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            _title,
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  bool _load = false;
  late File imageFile;
  String type = "";
  Map<String, dynamic> data = new Map<String, dynamic>();

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        _load = true;
      });
    }
  }

  Future<void> InsertData(BuildContext cont) async {
    // Get docs from collection reference
    await FirebaseFirestore.instance.collection(type).add(data);
    Navigator.pop(cont, false);
  }

  static const List<String> items = [
    "Ecommerce Platforms",
    "Social Media Platforms"
  ];
  String dropDownValue = items.first;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Add new item',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                child: DropdownButton(
                  value: dropDownValue,
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  cursorColor: Colors.blue,
                  controller: linkController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusColor: Colors.blue,
                    fillColor: Colors.blue,
                    hoverColor: Colors.blue,
                    labelText: 'Link',
                  ),
                ),
              ),
              Container(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: Text("PICK FROM GALLERY"),
                      ),
                    ],
                  ),
                ),
              ),
              _load == false
                  ? Container()
                  : Container(
                      child: Image.file(
                        imageFile,
                        fit: BoxFit.cover,
                      ),
                    ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Add'),
                  onPressed: () {
                    if (linkController == "" ||
                        titleController == "" ||
                        !titleController.text.isNotEmpty ||
                        !linkController.text.isNotEmpty ||
                        _load == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 5),
                        content: Text('All fields are manadatory!'),
                      ));
                    } else {
                      final bytes = imageFile.readAsBytesSync();
                      String img64 = base64Encode(bytes);
                      type = dropDownValue == "Social Media Platforms"
                          ? "SocialItems"
                          : "EcomItems";
                      data = {
                        "link": linkController.text,
                        "title": titleController.text,
                        "img": img64
                      };
                      InsertData(context);
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }
}
