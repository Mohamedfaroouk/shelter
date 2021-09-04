import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shelter/models/foodmodel.dart';
import 'package:shelter/models/ordermodel.dart';
import 'package:shelter/models/usermodel.dart';

String? uid;
Color yellowColor = const Color(0xffffb218);
Color darkColor = const Color(0xff231f20);
const int mokupwidth = 411;
const int mokupheight = 823;
List incartitemes = [];
bool add = false;
Widget? theBody;
String mytitle = "Menu";
List<OrderModel> orders = [
  OrderModel(
      email: "farouk@gmail.com",
      date: DateFormat('h:m d/M/y').format(DateTime.now()),
      isconfirmed: true,
      onway: true,
      deliverd: true,
      phone: "01064580600",
      total: 115,
      subtotal: 101,
      tax: 14,
      qunitity: [
        1,
        1
      ],
      orders: [
        ItemsModel.fromJson(
          {
            "name": "NEGRESCO MOZZARELLA",
            "incart": false,
            "price": 43,
            "type": "Pasta",
            "cont":
                "مكرونة بنا بصوص جبن شيلتر مع قطع صدور الدجاج بالاضافة لجبن الموتزاريلا"
          },
        ),
        ItemsModel.fromJson(
          {
            "name": "CHICKEN BALLS MOZZARELLA",
            "incart": false,
            "price": 58,
            "type": "Pasta",
            "cont":
                "مكرونة شريط بصوص جبن شيلتر مع كرات الدجاج المقرمشة بالاضافة لجبن الموتزاريلا"
          },
        )
      ])
];
FoodModel? mymodel;
/* List<int> ordersQuintity = [];
List<ItemsModel> checkoutitems = [];

double ordertotal = 0;
double ordersubtotal = 0;
int ordertax = 0; */
MaterialColor yellow = const MaterialColor(0xffffb218, <int, Color>{
  50: Color(0xffffb218),
  100: Color(0xffffb218),
  200: Color(0xffffb218),
  300: Color(0xffffb218),
  400: Color(0xffffb218),
  500: Color(0xffffb218),
  600: Color(0xffffb218),
  700: Color(0xffffb218),
  800: Color(0xffffb218),
  900: Color(0xffffb218),
});
UserModel? thecurrentuser;
