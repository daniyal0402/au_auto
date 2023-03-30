import 'package:au_auto/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class adminLogin extends StatelessWidget {
  static const String _title = 'AU AUTO';
  late bool adminControl;
  adminLogin(this.adminControl);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            _title,
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: MyStatefulWidget(adminControl),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  late bool adminControl;
  MyStatefulWidget(this.adminControl);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState(adminControl);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late bool adminControl;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  _MyStatefulWidgetState(this.adminControl);

  @override
  Widget build(BuildContext context) {
    return adminControl
        ? Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              // height: MediaQuery.of(context).size.height / 3,
              // width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                child: const Text('LOG OUT'),
                onPressed: () {
                  adminControl = false;
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyApp(adminControl)));
                },
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Admin Access',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () {
                        if (nameController.text == "auauto" &&
                            passwordController.text == "123321") {
                          adminControl = true;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MyApp(adminControl)));
                        } else {
                          print("here!");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Invalid Username or Password!'),
                          ));
                        }
                      },
                    )),
              ],
            ));
  }
}
