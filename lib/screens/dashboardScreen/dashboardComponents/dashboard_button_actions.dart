

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonAction extends ChangeNotifier {

 Color moreInfoColor = Colors.white;
 double offsetRadius = 0.0;
 double blurRadius = 0.0;

 showMoreInfo(color) {
   if (color==moreInfoColor){
     moreInfoColor = Colors.white;
     offsetRadius = 0.0;
     blurRadius = 0.0;
   }else {
     moreInfoColor = color;
     offsetRadius = 3.0;
     blurRadius = 2.0;
   }

   notifyListeners();
 }

}