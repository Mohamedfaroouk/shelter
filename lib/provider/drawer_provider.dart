import 'package:flutter/material.dart';
import 'package:shelter/shared/constants.dart';

class DrawerProvider with ChangeNotifier {
  void setTheScreen(Widget myscreen, text, context) {
    theBody = myscreen;
    mytitle = text;
    Navigator.pop(context);
    notifyListeners();
  }
}
