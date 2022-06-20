import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ChartActions extends ChangeNotifier {
  bool isPowerTypeChartMenuOpen = false;

  onPageLeave() {
    isPowerTypeChartMenuOpen = false;
    isLiveChartMenuOpen = false;
    notifyListeners();
  }

  onMenuOpen() {
    isPowerTypeChartMenuOpen = !isPowerTypeChartMenuOpen;
    // if (isPowerTypeChartMenuOpen == false) {
    //   isPowerTypeChartMenuOpen = true;
    // } else {
    //   isPowerTypeChartMenuOpen = false;
    // }
    notifyListeners();
  }

  bool isLiveChartMenuOpen = false;

  liveChartMenuOpen() {
    if (isLiveChartMenuOpen == false) {
      isLiveChartMenuOpen = true;
    } else {
      isLiveChartMenuOpen = false;
    }
    notifyListeners();
  }
}
