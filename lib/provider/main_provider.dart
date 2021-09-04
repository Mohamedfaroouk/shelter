import 'package:flutter/material.dart';
import 'package:shelter/Screens/cart.dart';
import 'package:shelter/Screens/menu.dart';
import 'package:shelter/models/foodmodel.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/remote/diohelper.dart';

class MainProvider with ChangeNotifier {
  Map<String, dynamic> foodcat = {};

  void getmenudata() {
    Diohelp.getdata(text: "food").then((value) {
      mymodel = FoodModel.fromJson(value.data);
      theBody = categorybuilder(mymodel!);
      print(mymodel!.keys);

      notifyListeners();
    });
  }
}
