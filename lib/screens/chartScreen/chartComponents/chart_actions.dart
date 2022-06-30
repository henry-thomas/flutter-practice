import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ChartActions extends ChangeNotifier {
  bool isPowerTypeChartMenuOpen = false;
  bool isEnergyTypeChartMenuOpen = false;
  bool isLiveChartMenuOpen = false;

  onPageLeave() {
    isPowerTypeChartMenuOpen = false;
    isEnergyTypeChartMenuOpen = false;
    isLiveChartMenuOpen = false;
    notifyListeners();
  }

  onPtChartOpen() {
    isPowerTypeChartMenuOpen = !isPowerTypeChartMenuOpen;
    notifyListeners();
  }

  onEtChartOpen() {
    isEnergyTypeChartMenuOpen = !isEnergyTypeChartMenuOpen;
    notifyListeners();
  }

  liveChartMenuOpen() {
    if (isLiveChartMenuOpen == false) {
      isLiveChartMenuOpen = true;
    } else {
      isLiveChartMenuOpen = false;
    }
    notifyListeners();
  }
}
