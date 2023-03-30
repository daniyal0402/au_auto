import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class gridItems extends StatelessWidget {
  String img;
  VoidCallback onTap;
  bool selected;
  bool adminControl;
  String title;
  gridItems(this.img, this.selected, this.onTap, this.title, this.adminControl,
      {super.key});

  Future<File> writeImageTemp(String base64Image, String imageName) async {
    final dir = await getTemporaryDirectory();
    await dir.create(recursive: true);
    final tempFile = File(path.join(dir.path, imageName));
    await tempFile.writeAsBytes(base64.decode(base64Image));
    return tempFile;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),
        ),
      ),
      elevation: 15,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
            bottom: Radius.circular(20),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    gradient: selected
                        ? adminControl
                            ? const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                    // Colors.white70,
                                    Colors.red,
                                    Colors.red,
                                    Colors.red,
                                  ])
                            : const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                    // Colors.white70,
                                    Colors.blue,
                                    Colors.blue,
                                    Colors.blue,
                                  ])
                        : const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                                Colors.white70,
                                Colors.white70,
                              ]),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    // color:
                    //     selected ? Colors.grey.withOpacity(0.5) : Colors.amber,
                  ),
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        // color: Colors.amber,
                        child: Image.memory(
                          base64Decode(img),
                          fit: selected ? BoxFit.fitWidth : BoxFit.fitHeight,
                        ),
                      ),
                      selected && adminControl
                          ? Container(
                              height: double.infinity,
                              width: double.infinity,
                              color: Colors.black.withOpacity(0.1),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                      "Delete")
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    color: selected
                        ? adminControl
                            ? Colors.red
                            : Colors.blue
                        : Colors.white70,
                  ),
                  width: double.infinity,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      textAlign: TextAlign.center,
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
