import 'package:flutter/cupertino.dart';

import '../../../flutterFlow/flutter_flow_theme.dart';

class weatherController extends ChangeNotifier {



  String weatherBackground = 'Night';

  void checkTime() {
    weatherBackground = "Day";
    notifyListeners();
  }
}
