

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class chartActions extends ChangeNotifier {

  bool menuIsOpen = false;


  menuOpen() {
    if (menuIsOpen == false) {
      menuIsOpen = true;
    }else {
      menuIsOpen = false;
    }
  }


  bool liveChartMenuIsOpen = false;


  liveChartMenuOpen() {
    if (liveChartMenuIsOpen == false) {
      liveChartMenuIsOpen = true;
    }else {
      liveChartMenuIsOpen = false;
    }
  }

    notifyListeners();
}
