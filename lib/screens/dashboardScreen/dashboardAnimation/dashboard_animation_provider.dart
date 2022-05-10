import 'package:flutter/material.dart';

class DashboardAnimationProvider extends ChangeNotifier {

  double pvToBatAnimationPositionVal = 0;

  setPvToBatAnim(newPostion) {
    pvToBatAnimationPositionVal = newPostion;
  notifyListeners();
  }


}