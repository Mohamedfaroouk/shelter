import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter/Screens/drawer.dart';
import 'package:shelter/models/foodmodel.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/provider/drawer_provider.dart';
import 'package:shelter/provider/main_provider.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  int listindex = 0;
  List<List<String>> test1 = [
    ["pasta", "sandwatch", "pizaa"],
    ["chicked", "beaf", "burger"]
  ];
  ScrollController? test;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double logosize = 45;
    if (width > 600) {
      width = 600;
      logosize = 50;
    }
    if (width < 350) {
      logosize = 30;
    }
    print("hi");
    var value = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      drawer: const Drawer(
        child: MyDrawer(),
      ),
      backgroundColor: darkColor,
      body: mymodel == null
          ? const Center(child: CircularProgressIndicator())
          : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    leading: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu),
                      ),
                    ),
                    leadingWidth: 24,
                    //toolbarHeight: 100 / mokupheight * height,
                    // expandedHeight: 120 / mokupwidth * width,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(
                        bottom: 8.0 / mokupheight * height,
                      ),
                      child: Image.asset(
                        "assets/icons/Daco_78140.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    excludeHeaderSemantics: true,
                    backgroundColor: yellowColor,
                    elevation: 0,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                            padding: EdgeInsets.all(8 / mokupwidth * width),
                            onPressed: () {},
                            icon: const Icon(Icons.search, size: 24)),
                      ),
                      const Divider(),
                    ],
                    title: Center(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/icons/logo.png",
                            width: logosize,
                            filterQuality: FilterQuality.high,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Shelter',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Oswald",
                                    fontSize: 25 / mokupwidth * width,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: AppBar(
                      leading: const SizedBox(),
                      leadingWidth: 0,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      title: Consumer<DrawerProvider>(
                          builder: (context, snapshot, child) {
                        return Text(
                          "$mytitle",
                          style: const TextStyle(
                              fontSize: 30, fontFamily: "Bangers"),
                        );
                      }),
                    ),
                  )
                ];
              },
              body: Consumer<DrawerProvider>(
                builder: (context, value, child) {
                  return theBody!;
                },
              ) //categorybuilder(foodcat, value.mymodel!),
              ),
    );
    ;
  }
}

List allitems(FoodModel mymodel, el) {
  return mymodel.allfood[el];
}

class categorybuilder extends StatefulWidget {
  categorybuilder(this.mymodel, {Key? key}) : super(key: key);
  FoodModel mymodel;

  @override
  _categorybuilderState createState() => _categorybuilderState();
}

class _categorybuilderState extends State<categorybuilder> {
  Map<String, dynamic> foodcat = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuilt");
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    const int mokupwidth = 411;
    if (width > 600) {
      width = 600;
    }
    return SingleChildScrollView(
      child: Column(
          children: widget.mymodel.keys
              .map(
                (el) => Column(
                  children: [
                    ExpandablePanel(
                      theme: ExpandableThemeData(
                        iconColor: Colors.grey[100],
                      ),
                      header: Padding(
                        padding: EdgeInsets.only(top: 10 / mokupwidth * width),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8 / mokupwidth * width),
                          child: Row(
                            children: [
                              Text(
                                "${el}",
                                style: const TextStyle(
                                    fontFamily: "Oswald",
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      collapsed: const SizedBox(),
                      expanded: Container(
                        color: yellow,
                        child: Column(
                            children: allitems(widget.mymodel, el).map((e) {
                          ItemsModel item = ItemsModel.fromJson(e);
                          if (incartitemes
                              .any((element) => element == item.name)) {
                            item.incart = true;
                            if (Provider.of<CartProvider>(context,
                                    listen: false)
                                .allCartItems
                                .any((element) => element.name == item.name)) {
                            } else {
                              Provider.of<CartProvider>(context, listen: false)
                                  .allCartItems
                                  .add(item);
                              Provider.of<CartProvider>(context, listen: false)
                                  .itemQuintity
                                  .add(1);
                              Timer(const Duration(seconds: 1), () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .UpdateCartTotal();
                              });
                            }
                          } else {
                            setState(() {
                              item.incart = false;
                            });
                          }

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8 / mokupwidth * width,
                                horizontal: 20 / mokupwidth * width),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextFontBangers(
                                      mokupwidth: mokupwidth,
                                      width: width,
                                      text: "${item.name}",
                                      textColor: darkColor,
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: e["type"] == "Chicken Sandwich" ||
                                              e["type"] == "Beaf Sandwich"
                                          ? TextFontBangers(
                                              mokupwidth: mokupwidth,
                                              width: width,
                                              text: "${item.price.first}.00",
                                              textColor: darkColor,
                                            )
                                          : TextFontBangers(
                                              mokupwidth: mokupwidth,
                                              width: width,
                                              text: "${item.price}.00",
                                              textColor: darkColor,
                                            ),
                                    ),
                                    Consumer<CartProvider>(
                                        builder: (context, snapshot, child) {
                                      return CustomAnimatedIcon(
                                        animatedbool: item.incart!,
                                        closeIcon: Icons.add_shopping_cart,
                                        closeIconColor: darkColor,
                                        openIcon: Icons.remove_shopping_cart,
                                        openIconColor: Colors.white,
                                        onopen: () {
                                          if (e["type"] == "Chicken Sandwich" ||
                                              e["type"] == "Beaf Sandwich") {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Bottomsheet(
                                                      mokupwidth: mokupwidth,
                                                      width: width,
                                                      e: e,
                                                      cartbool: item.incart);
                                                });
                                          } else {
                                            // e["incart"] = !e["incart"];
                                            final value =
                                                Provider.of<CartProvider>(
                                                    context,
                                                    listen: false);
                                            final elemnt =
                                                ItemsModel.fromJson(e);

                                            if (value.allCartItems.any(
                                                (element) =>
                                                    element.name ==
                                                    item.name)) {
                                              item.incart = !(item.incart!);

                                              final int theindex = value
                                                  .allCartItems
                                                  .indexOf(value.allCartItems
                                                      .where((element) =>
                                                          element.name ==
                                                          item.name)
                                                      .first);
                                              value.allCartItems
                                                  .removeAt(theindex);
                                              value.itemQuintity
                                                  .removeAt(theindex);
                                              value.UpdateCartTotal();
                                            } else {
                                              value.allCartItems.add(elemnt);
                                              value.itemQuintity.add(1);
                                              value.UpdateCartTotal();
                                              item.incart = !(item.incart!);
                                            }
                                          }
                                        },
                                      );
                                    })
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    TextArabicFont(
                                      text: e["cont"],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: darkColor,
                                ),
                              ],
                            ),
                          );
                        }).toList()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30 / mokupwidth * width),
                      child: const Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
              .toList()),
    );
  }
}

class Bottomsheet extends StatelessWidget {
  Bottomsheet({
    Key? key,
    required this.mokupwidth,
    required this.width,
    required this.e,
    required this.cartbool,
  }) : super(key: key);

  final int mokupwidth;
  final Map<String, dynamic> e;
  final double width;
  bool? cartbool;
  List size = ["Single", "Double", "Triple"];

  @override
  Widget build(BuildContext context) {
    List prices = e["price"];
    var item = ItemsModel.fromJson(e);
    return Container(
      decoration: BoxDecoration(
          color: yellowColor,
          image: const DecorationImage(
            image: AssetImage(
              "assets/icons/Daco_78140.png",
            ),
            fit: BoxFit.fill,
          )),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFontBangers(
              mokupwidth: mokupwidth,
              width: width,
              text: "Choose the size",
              textColor: darkColor,
            ),
          ),
          Consumer<CartProvider>(builder: (context, snapshot, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: prices.map(
                (el) {
                  int priceindex = prices.indexOf(el);

                  return InkWell(
                    onTap: () {
                      print(size[priceindex]);

                      final value =
                          Provider.of<CartProvider>(context, listen: false);

                      if (value.allCartItems.any((element) =>
                          element.name ==
                          item.name! + " " + "(" + size[priceindex] + ")")) {
                        //   item.incart = !(item.incart!);
                        print(item.incart);

                        final int theindex = value.allCartItems.indexOf(value
                            .allCartItems
                            .where((element) =>
                                element.name ==
                                "${item.name!} (${"${size[priceindex]}"})")
                            .first);
                        value.allCartItems.removeAt(theindex);
                        value.itemQuintity.removeAt(theindex);
                        cartbool = false;
                        add = false;
                        value.UpdateCartTotal();
                      } else {
                        item.price = el;
                        item.name =
                            ("${item.name!} (${"${size[priceindex]}"})");
                        value.allCartItems.add(item);
                        value.itemQuintity.add(1);
                        value.UpdateCartTotal();
                        //item.incart = false;
                        print(item.incart);
                      }

                      Navigator.pop(context);
                    },
                    child: Column(
                      children: [
                        TextFontBangers(
                          mokupwidth: mokupwidth,
                          width: width,
                          text: "${size[priceindex]}",
                          textColor: Provider.of<CartProvider>(context,
                                      listen: false)
                                  .allCartItems
                                  .any((element) =>
                                      element.name ==
                                      "${"${item.name!} (" + size[priceindex]})")
                              ? Colors.white
                              : darkColor,
                        ),
                        TextFontBangers(
                          mokupwidth: mokupwidth,
                          width: width,
                          text: "${el}.00",
                          textColor: Provider.of<CartProvider>(context,
                                      listen: false)
                                  .allCartItems
                                  .any((element) =>
                                      element.name ==
                                      "${"${item.name!} (" + size[priceindex]})")
                              ? Colors.white
                              : darkColor,
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            );
          })
        ],
      ),
    );
  }
}
