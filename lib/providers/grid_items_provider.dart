import 'package:flutter/material.dart';

class GridItems with ChangeNotifier {
  bool moreButtonOn = false;

  updateMoreButton(bool val) {
    moreButtonOn = val;
    notifyListeners();
  }
}
