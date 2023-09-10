import 'package:bitmap_controller/view/group.dart';
import 'package:flutter/material.dart';
import 'view/circleController.dart';

void main() {

  List<bool> a = [];

  for(var i = 0; i< 64; i++){
    a.add(false);
  }

  runApp(MaterialApp(
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent
      ),
    debugShowCheckedModeBanner: false,
    home: const GroupBitmap()
  ));
}



