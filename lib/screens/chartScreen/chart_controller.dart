

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartController extends ChangeNotifier {
  Color pvPowerTypeIconSelectorColor = Colors.green;
  Color loadPowerTypeIconSelectorColor = Colors.blue;
  Color gridPowerTypeIconSelectorColor = Colors.red;
  Color batPowerTypeIconSelectorColor = Colors.orange;

  double pvIconDepth = 2;
  double gridIconDepth = 2;
  double loadIconDepth = 2;
  double batIconDepth = 2;

  batSelected() {
    if (batPowerTypeIconSelectorColor == Colors.orange){
      batPowerTypeIconSelectorColor = Colors.white;
      batIconDepth = -2;
    }else {
      batPowerTypeIconSelectorColor = Colors.orange;
      batIconDepth = 2;
    }
    notifyListeners();
  }
  gridSelected() {
    if (gridPowerTypeIconSelectorColor == Colors.red){
      gridPowerTypeIconSelectorColor = Colors.white;
      gridIconDepth = -2;
    }else {
      gridPowerTypeIconSelectorColor = Colors.red;
      gridIconDepth = 2;
    }
    notifyListeners();
  }

  loadSelected() {
    if (loadPowerTypeIconSelectorColor == Colors.blue){
      loadPowerTypeIconSelectorColor = Colors.white;
      loadIconDepth = -2;
    }else {
      loadPowerTypeIconSelectorColor = Colors.blue;
      loadIconDepth = 2;
    }
    notifyListeners();
  }
  pvSelected() {
    if (pvPowerTypeIconSelectorColor == Colors.green){
      pvPowerTypeIconSelectorColor = Colors.white;
      pvIconDepth = -2;
    }else {
      pvPowerTypeIconSelectorColor = Colors.green;
      pvIconDepth = 2;
    }
    notifyListeners();
  }

}








