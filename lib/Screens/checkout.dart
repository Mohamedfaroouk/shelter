import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shelter/Screens/menu.dart';
import 'package:shelter/models/foodmodel.dart';
import 'package:shelter/models/ordermodel.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/widgets.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen(
      {Key? key,
      required this.checkoutitems,
      required this.ordersQuintity,
      required this.ordersubtotal,
      required this.ordertax,
      required this.ordertotal})
      : super(key: key);
  bool myswitch = false;
  List<int> ordersQuintity = [];
  List<ItemsModel> checkoutitems = [];
  double ordertotal = 0;
  double ordersubtotal = 0;
  int ordertax = 0;

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;
  bool show = false;
  TextEditingController tablenumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController PhonenumberController = TextEditingController();
  TextEditingController notenumberController = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    offset = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: controller!.view, curve: Curves.bounceOut));
    // TODO: implement initState
    thecurrentuser!.adress == null
        ? adressController.text = ""
        : adressController.text = thecurrentuser!.adress!;
    thecurrentuser!.phone == null
        ? PhonenumberController.text = ""
        : PhonenumberController.text = thecurrentuser!.phone!;
    super.initState();
  }

  @override
  void dispose() {
    adressController.dispose();
    PhonenumberController.dispose();
    tablenumberController.dispose();
    notenumberController.dispose();
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (width > 600) {
      width = 600;
    }
    return Scaffold(
      backgroundColor: yellow,
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: darkColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.restaurant, color: show ? Colors.white : yellow),
                    TextFontBangers(
                      mokupwidth: mokupwidth,
                      width: width,
                      text: "In Restaurant",
                      textColor: Colors.white,
                    ),
                    Switch(
                        inactiveTrackColor: Colors.white30,
                        value: show,
                        onChanged: (value) {
                          setState(() {
                            if (controller!.isCompleted) {
                              controller!.reverse();
                              Timer(const Duration(milliseconds: 1100), () {
                                setState(() {
                                  show = !show;
                                });
                              });
                            } else {
                              show = !show;
                              Timer(const Duration(milliseconds: 1100), () {
                                setState(() {
                                  controller!.forward();
                                });
                              });
                            }
                          });
                        }),
                    TextFontBangers(
                      mokupwidth: mokupwidth,
                      width: width,
                      text: "Delivery",
                      textColor: Colors.white,
                    ),
                    Icon(
                      Icons.delivery_dining,
                      color: show ? yellow : Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  color: darkColor,
                  height: height * 0.1,
                ),
                AnimatedCrossFade(
                    alignment: Alignment.centerLeft,
                    firstCurve: Curves.easeInOut,
                    secondCurve: Curves.easeIn,
                    firstChild: const SizedBox(),
                    sizeCurve: Curves.bounceOut,
                    secondChild: SlideTransition(
                      position: offset!,
                      child: Column(
                        children: [
                          Container(
                            color: darkColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: defaulttextform(
                                  controller: adressController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "this feild must not be empty";
                                    }
                                  },
                                  hinttext: "Enter your Adress",
                                  maxlines: 3,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  keyboardType: TextInputType.multiline,
                                  prefexicon: const Icon(
                                    Icons.home,
                                  ),
                                  text: "Adress"),
                            ),
                          ),

                          //Phone
                          Container(
                            color: darkColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      width: 60,
                                      child: Theme(
                                        data: ThemeData(
                                            brightness: Brightness.dark),
                                        child: TextField(
                                            enabled: false,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  TextStyle(color: yellow),
                                              labelText: "+20",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            )),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: defaulttextform(
                                        controller: PhonenumberController,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return "this feild must not be empty";
                                          }
                                        },
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        hinttext: "Enter Your Phone Number",
                                        password: widget.myswitch,
                                        prefexicon: const Icon(Icons.phone),
                                        text: "Phone"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    crossFadeState: show
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 1000)),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animat) => SizeTransition(
                    sizeFactor: animat,
                    child: child,
                  ),
                  child: show
                      ? const SizedBox()
                      : Container(
                          color: darkColor,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: defaulttextform(
                                      controller: tablenumberController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "this feild must not be empty";
                                        }
                                      },
                                      hinttext: "Enter Table Number",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      keyboardType: TextInputType.number,
                                      prefexicon: const Icon(
                                        Icons.home,
                                      ),
                                      text: "Table Number"),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                Column(
                  children: [
                    Container(
                      color: darkColor,
                      height: height * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: defaulttextform(
                                controller: notenumberController,
                                border: const UnderlineInputBorder(),
                                password: widget.myswitch,
                                prefexicon: const Icon(
                                  Icons.message,
                                ),
                                keyboardType: TextInputType.multiline,
                                maxlines: 5,
                                hinttext: "Anything else we need to know",
                                text: "Add a note"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: yellow,
                                    borderRadius: BorderRadius.circular(25)),
                                child: MaterialButton(
                                  onPressed: () {
                                    orders.add(OrderModel(
                                        adress: adressController.text,
                                        phone: PhonenumberController.text,
                                        date: DateFormat('h:m d/M/y')
                                            .format(DateTime.now()),
                                        orders: widget.checkoutitems,
                                        deliverd: false,
                                        isconfirmed: true,
                                        onway: false,
                                        subtotal: widget.ordersubtotal,
                                        tax: widget.ordertax,
                                        total: widget.ordertotal,
                                        qunitity: widget.ordersQuintity));

                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .allCartItems = [];
                                    incartitemes = [];
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .UpdateCartTotal();
                                    showtost(
                                        text: "Thank you for order",
                                        color: yellow);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Menu()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFontBangers(
                                      mokupwidth: mokupwidth,
                                      width: width,
                                      text: "Order",
                                      textColor: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaulttextform(
    {String? text,
    String? hinttext,
    context,
    TextEditingController? controller,
    Widget? prefexicon,
    Widget? subfexicon,
    bool password = false,
    int? maxlines,
    String? Function(String?)? validate,
    InputBorder border = const OutlineInputBorder(),
    TextInputType? keyboardType}) {
  return Theme(
    data: ThemeData(
        primaryColor: yellow,
        primarySwatch: yellow,
        brightness: Brightness.dark,
        accentIconTheme: IconThemeData(color: Colors.white)),
    child: TextFormField(
      controller: controller,
      obscureText: password,
      validator: validate,
      maxLines: maxlines,
      minLines: 1,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hinttext,
        labelText: text,
        border: border,
        prefixIcon: prefexicon,
        suffixIcon: subfexicon,
      ),
    ),
  );
}
