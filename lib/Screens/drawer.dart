import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelter/Screens/EditScreen.dart';
import 'package:shelter/Screens/cart.dart';
import 'package:shelter/Screens/menu.dart';
import 'package:shelter/Screens/orders.dart';
import 'package:shelter/login_screen/Login.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/provider/drawer_provider.dart';
import 'package:shelter/shared/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var value = Provider.of<DrawerProvider>(context);
    return Container(
      color: darkColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [yellow, const Color(0xffffd500)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: darkColor,
                  radius: min(height * 0.1, 500 * 0.1),
                ),
                Text(
                  "${thecurrentuser!.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Bangers",
                    fontSize: min(height * 0.06, 500 * 0.06),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                  },
                  child: Text(
                    "Edit Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Bangers",
                      fontSize: min(height * 0.04, 500 * 0.04),
                    ),
                  ),
                ),
                Visibility(
                  visible: thecurrentuser!.adress == null ||
                          thecurrentuser!.phone == null
                      ? true
                      : false,
                  child: Text(
                    "Complete your Profile",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: min(height * 0.03, 500 * 0.03),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: darkColor,
                  border: Border(
                      top: const BorderSide(
                        color: Color(0xffffd500),
                        width: 0,
                      ),
                      bottom: BorderSide(color: darkColor, width: 0))),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      'assets/icons/Daco_78140.png',
                      isAntiAlias: true,
                      height: 65,
                      fit: BoxFit.fill,
                      color: Colors.black,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/Daco_78140.png',
                    isAntiAlias: true,
                    filterQuality: FilterQuality.high,
                  ),
                ],
              )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: double.infinity,
              color: darkColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DrawerButtons(
                      pressed: () {
                        value.setTheScreen(
                            categorybuilder(mymodel!), "Menu", context);
                      },
                      text: "Menu",
                      icon: FontAwesomeIcons.cheese,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DrawerButtons(
                        pressed: () {
                          value.setTheScreen(Cart(), "Cart", context);
                        },
                        text: "Cart",
                        icon: FontAwesomeIcons.shoppingCart),
                    const SizedBox(
                      height: 20,
                    ),
                    DrawerButtons(
                        pressed: () {
                          value.setTheScreen(OrdersScreen(), "Orders", context);
                        },
                        text: "Orders",
                        icon: FontAwesomeIcons.firstOrder),
                    const SizedBox(
                      height: 50,
                    ),
                    DrawerButtons(
                        pressed: () async {
                          await FirebaseAuth.instance.signOut();

                          uid = null;
                          var box = await Hive.box("token");
                          box.delete("uid");
                          Provider.of<CartProvider>(context, listen: false)
                              .allCartItems = [];
                          Provider.of<CartProvider>(context, listen: false)
                              .UpdateCartTotal();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        text: "Logout",
                        icon: FontAwesomeIcons.signOutAlt)
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class DrawerButtons extends StatefulWidget {
  DrawerButtons(
      {Key? key, required this.pressed, required this.text, required this.icon})
      : super(key: key);
  VoidCallback? pressed;
  String? text;
  IconData icon;
  @override
  _DrawerButtonsState createState() => _DrawerButtonsState();
}

class _DrawerButtonsState extends State<DrawerButtons> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      splashColor: Colors.white,
      onTap: widget.pressed,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: min(height * 0.04, 500 * 0.04),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${widget.text}",
              textAlign: TextAlign.center,
              style: TextStyle(
                textBaseline: TextBaseline.ideographic,
                color: Colors.white,
                fontFamily: "Bangers",
                fontSize: min(height * 0.06, 500 * 0.06),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
