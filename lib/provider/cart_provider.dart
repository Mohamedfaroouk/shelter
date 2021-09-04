import 'package:flutter/material.dart';
import 'package:shelter/models/foodmodel.dart';

class CartProvider with ChangeNotifier {
  double bottomHeight = 100;
  bool openMore = false;
  List<ItemsModel> allCartItems = [];
  List<int> itemQuintity = [];
  List<bool> Iconcartbool = [];
  double total = 0;
  double subtotal = 0;
  int tax = 0;
  void openMoreMenu() {
    if (bottomHeight == 100) {
      bottomHeight = 200;
      openMore = !openMore;
    } else {
      bottomHeight = 100;
      openMore = !openMore;
    }
    notifyListeners();
  }

  void UpdateCartTotal() {
    if (allCartItems.isEmpty) {
      subtotal = 0.0;
      tax = 0;
      total = 0;
    }
    subtotal = 0.0;
    allCartItems.forEach((element) {
      subtotal += element.price;
      tax = (subtotal * 0.14).round();
      total = subtotal + tax;
      print(subtotal);
    });
    notifyListeners();
  }

  void updateQuntitiy(int index, bool isincr) {
    allCartItems[index].price = allCartItems[index].price / itemQuintity[index];
    if (isincr) {
      itemQuintity[index]++;
    } else {
      itemQuintity[index]--;
    }

    allCartItems[index].price = allCartItems[index].price * itemQuintity[index];
    notifyListeners();
    print(allCartItems[index].price);
    UpdateCartTotal();
  }

  bool animateIcon(bool isclicked) {
    isclicked ? isclicked = false : isclicked = true;
    print(isclicked);
    notifyListeners();
    return isclicked;
  }
}
