

import 'package:flutter/material.dart';

import '../profileComponents/electric_price_input.dart';
import '../profileComponents/electricity_price_card.dart';

class ElectricitySettings extends ChangeNotifier {
  List <Widget> electricityCard = [];
  double electricityPrice = 1.46;
  String username = "UserName";
  var electricPriceView = const ElectricityPriceComponent();
  var electricPriceInput = const ElectricPriceInputComponent();

  setUserName(name) {
    username = name;
    notifyListeners();
  }

  setElectricityPrice(price) {
    electricityPrice = double.parse(price) ;
  }

  bool init = false;
  insertElectricCard(context) {
    if (!init) {
      init = true;
        electricityCard.add(electricPriceView);
notifyListeners();
    }
  }

  insertElectricPriceInput() {
    if (electricityCard[0] == electricPriceInput) {
      electricityCard.removeAt(0);
      electricityCard.add(electricPriceView);
    } else {
      electricityCard.removeAt(0);
      electricityCard.add(electricPriceInput);
    }
    notifyListeners();
  }


}