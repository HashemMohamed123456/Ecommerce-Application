import 'package:flutter/material.dart';
class Navigation{
  static void push(context,screen){
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context)=>screen));
  }
  static void pushAndRemove(context,screen){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>screen), (route) => false);
  }
}