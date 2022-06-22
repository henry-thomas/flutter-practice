import 'package:flutter/material.dart';

class DashboardAnimationProvider extends ChangeNotifier {
  double pvToBatAnimationPositionVal = 0;
  double gridAnimationPositionVal = 0;
  double loadAnimationPositionVal = 0;
  double batChargeAnimationPositionVal = 0;
  double batDischargeAnimationPositionVal = 0;

  setPvToBatAnim(newPostion) {
    pvToBatAnimationPositionVal = newPostion;
    notifyListeners();
  }

  setGridAnim(newPostion) {
    gridAnimationPositionVal = newPostion;
    notifyListeners();
  }

  setLoadAnim(newPostion) {
    loadAnimationPositionVal = newPostion;
    notifyListeners();
  }

  setBatChargeAnim(newPostion) {
    batChargeAnimationPositionVal = newPostion;
    notifyListeners();
  }

  setBatDischargeAnim(newPostion) {
    batDischargeAnimationPositionVal = newPostion;
    notifyListeners();
  }
}
