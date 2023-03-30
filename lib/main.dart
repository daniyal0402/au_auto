import 'dart:convert';
import 'dart:io';

import 'package:au_auto/addNewItem.dart';
import 'package:au_auto/adminLogin.dart';
import 'package:au_auto/gridItems.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_name/flutter_app_name.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(false));
}

class MyApp extends StatelessWidget {
  bool adminControl;
  MyApp(this.adminControl);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AU AUTO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(adminControl, 'AU AUTO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.adminControl, this.title);
  bool adminControl;

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState(adminControl);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.adminControl);
  List<Map<String, dynamic>> SocialItems = [];
  List<Map<String, dynamic>> EcomItems = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getDataSocial() async {
    // Get docs from collection reference
    FirebaseFirestore.instance.collection('SocialItems').get().then(
      (QuerySnapshot querySnapshot) {
        SocialItems.clear();
        querySnapshot.docs.forEach(
          (doc) {
            SocialItems.add(doc.data() as Map<String, dynamic>);
            SocialItems.last['id'] = doc.id;
            print(doc.data());
          },
        );
        print(SocialItems);
        setState(() {});
      },
    );
  }

  Future<void> getDataEcom() async {
    // Get docs from collection reference
    FirebaseFirestore.instance.collection('EcomItems').get().then(
      (QuerySnapshot querySnapshot) {
        EcomItems.clear();
        querySnapshot.docs.forEach(
          (doc) {
            EcomItems.add(doc.data() as Map<String, dynamic>);
            EcomItems.last['id'] = doc.id;
            print(doc.data());
          },
        );
        print(EcomItems);
        setState(() {});
      },
    );
  }

  Future<File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }

  void getData() {
    getDataEcom();
    getDataSocial();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  // static const List<Map<String, dynamic>> EcomItems = <Map<String, dynamic>>[
  //   <String, dynamic>{
  //     'title': "Shopify",
  //     'img': "assets/ShopifyLogo.png",
  //     'link': "https://marleys-closet.store/",
  //   },
  //   <String, dynamic>{
  //     'title': "Jazmine's",
  //     'img': "assets/ebay.png",
  //     'link':
  //         "https://www.ebay.com/str/jazzyautopartssales?mkcid=16&mkevt=1&mkrid=711-127632-2357-0&ssspo=lfojluwftms&sssrc=3418065&ssuid=lfojluwftms&widget_ver=artemis&media=SMS",
  //   },
  //   <String, dynamic>{
  //     'title': "Isabel",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/usr/isafue82",
  //   },
  //   <String, dynamic>{
  //     'title': "Angel",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/str/autopartsonthelow",
  //   },
  //   <String, dynamic>{
  //     'title': "Fransico",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/usr/franciscchave_77",
  //   },
  //   <String, dynamic>{
  //     'title': "Nathan",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/str/becksautoparts",
  //   },
  //   <String, dynamic>{
  //     'title': "Ebay",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/usr/autoparts7012",
  //   },
  //   <String, dynamic>{
  //     'title': "Ebay",
  //     'img': "assets/ebay.png",
  //     'link': "https://www.ebay.com/str/brianyucaipa",
  //   },
  // ];

  // static const List<Map<String, dynamic>> SocialItems = <Map<String, dynamic>>[
  //   <String, dynamic>{
  //     'title': "kevinangelogn100",
  //     'img': "assets/Insta.png",
  //     'link': "https://www.instagram.com/kevinangelogn100/",
  //   },
  //   <String, dynamic>{
  //     'title': "ausocialelevate",
  //     'img': "assets/AULOGO.png",
  //     'link': "https://www.instagram.com/ausocialelevate/",
  //   },
  //   <String, dynamic>{
  //     'title': "OnlyFans",
  //     'img': "assets/OF.png",
  //     'link': "https://onlyfans.com/auinternational",
  //   },
  //   <String, dynamic>{
  //     'title': "How to make millions on ebay",
  //     'img': "assets/book.png",
  //     'link':
  //         "https://www.amazon.com/dp/B0BSFLVYJN?ref_=cm_sw_r_apin_dp_CCHDT7C8TQXHA5CFQK46&fbclid=PAAaYhuCu-6_Ue9lWHqw3QIL7VbKJOj14NRLvfrlUy1VbGvqEPJUmaYwqLKWI",
  //   },
  //   <String, dynamic>{
  //     'title': "Tik Tok",
  //     'img': "assets/TikTok.png",
  //     'link': "https://www.tiktok.com/@auautopartsllc?_t=8ztlc1ywkzn&_r=1",
  //   },
  //   <String, dynamic>{
  //     'title': "Youtube",
  //     'img': "assets/Youtube.png",
  //     'link': "https://www.youtube.com/@auautopartsllc9589",
  //   },
  // ];

  int optionSelected = 0;
  String listSelected = "";
  late Uri _url;
  bool adminControl;

  void checkOption(int index, String list, Uri url) {
    setState(() {
      if (listSelected == list && optionSelected == index && adminControl)
        deleteThisItem();
      listSelected = list;
      optionSelected = index;
      _url = url;
      if (!adminControl) _launchUrl();
    });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void deleteThisItem() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete item'),
        content: const Text("Are you sure you want to delete this item?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              listSelected == "social"
                  ? FirebaseFirestore.instance
                      .collection('SocialItems')
                      .doc(SocialItems[optionSelected - 1]['id'])
                      .delete()
                      .then(
                      (doc) {
                        print("Document deleted");
                        getDataSocial();
                      },
                      onError: (e) => print("Error updating document $e"),
                    )
                  : FirebaseFirestore.instance
                      .collection('EcomItems')
                      .doc(EcomItems[optionSelected - 1]['id'])
                      .delete()
                      .then(
                      (doc) {
                        print("Document deleted");
                        getDataEcom();
                      },
                      onError: (e) => print("Error updating document $e"),
                    );
              setState(() {});
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void AddButtonClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => addNewItem()))
        .then((value) => getData());
  }

  void AdminControlLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => adminLogin(adminControl)))
        .then((value) => getData());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.amber, Colors.amber]),
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(
                  // icon: Icon(Icons.directions_car),
                  child: Text(
                    "Ecommerce Platforms",
                    style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // text: "Ecommerce Platforms",
                ),
                Tab(
                  child: Text(
                    "Social Media Platforms",
                    style: TextStyle(
                      // color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // text: "Social Media Platforms",
                  // icon: Icon(Icons.directions_transit),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.admin_panel_settings),
                tooltip: 'Access admin control',
                onPressed: () => AdminControlLogin(),
              ),
            ],
            title: const Text(
              'AU AUTO',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          floatingActionButton: adminControl
              ? FloatingActionButton(
                  onPressed: AddButtonClicked,
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.add,
                  ),
                )
              : Container(),
          body: TabBarView(
            children: [
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                children: [
                  for (int i = 0; i < EcomItems.length; i++)
                    gridItems(
                        EcomItems[i]['img'],
                        ((i + 1 == optionSelected) && (listSelected == "ecom")),
                        () => checkOption(
                            i + 1, "ecom", Uri.parse(EcomItems[i]['link'])),
                        EcomItems[i]['title'],
                        adminControl),
                ],
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                // padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                children: [
                  for (int i = 0; i < SocialItems.length; i++)
                    gridItems(
                        SocialItems[i]['img'],
                        ((i + 1 == optionSelected) &&
                            (listSelected == "social")),
                        () => checkOption(
                            i + 1, "social", Uri.parse(SocialItems[i]['link'])),
                        SocialItems[i]['title'],
                        adminControl)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
