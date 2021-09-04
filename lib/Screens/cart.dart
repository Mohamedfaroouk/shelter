import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter/Screens/checkout.dart';
import 'package:shelter/models/foodmodel.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/widgets.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);
  double bb = 100;
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    if (width > 600) {
      width = 600;
    }
    return Scaffold(
        backgroundColor: darkColor,
        bottomNavigationBar: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Consumer<CartProvider>(builder: (context, value, child) {
              return AnimatedContainer(
                color: yellow,
                duration: const Duration(milliseconds: 650),
                height: value.bottomHeight + 20,
                width: double.infinity,
                child: Column(
                  children: [
                    CustomAnimatedIcon(
                      animatedbool: value.openMore,
                      closeIcon: Icons.arrow_circle_up,
                      closeIconColor: darkColor,
                      openIcon: Icons.arrow_circle_down,
                      openIconColor: darkColor,
                      onopen: () {
                        value.openMoreMenu();
                      },
                    ),
                    Container(
                      width: width * 0.52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFontBangers(
                              mokupwidth: mokupwidth,
                              width: width,
                              text: "Sub Total"),
                          Spacer(),
                          TextFontBangers(
                              mokupwidth: mokupwidth,
                              width: width,
                              text: "${value.subtotal}.00")
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFontBangers(
                              mokupwidth: mokupwidth,
                              width: width,
                              text: "Tax"),
                          const Spacer(),
                          TextFontBangers(
                              mokupwidth: mokupwidth,
                              width: width,
                              text: "${value.tax}.00"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Container(
                  height: 80,
                  color: yellowColor,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFontBangers(
                                mokupwidth: mokupwidth,
                                width: width,
                                text: "Total"),
                            TextFontBangers(
                                mokupwidth: mokupwidth,
                                width: width,
                                text: "${value.total}.00")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: darkColor,
                                borderRadius: BorderRadius.circular(25)),
                            child: MaterialButton(
                              onPressed: () {
                                var value = Provider.of<CartProvider>(context,
                                    listen: false);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckoutScreen(
                                            checkoutitems: value.allCartItems,
                                            ordersQuintity: value.itemQuintity,
                                            ordersubtotal: value.subtotal,
                                            ordertax: value.tax,
                                            ordertotal: value.total)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFontBangers(
                                  mokupwidth: mokupwidth,
                                  width: width,
                                  text: "Checkout",
                                  textColor: Colors.white,
                                  size: 15,
                                ),
                              ),
                            )),
                      )
                    ],
                  ));
            }),
          ],
        ),
        body: Consumer<CartProvider>(builder: (context, value, child) {
          return ListView.separated(
            itemCount: value.allCartItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 2,
                color: Colors.white,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return CartItem(
                width: width,
                model: value.allCartItems[index],
                index: index,
              );
            },
          );
        }));
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.width,
    required this.model,
    required this.index,
  }) : super(key: key);

  final double width;
  final ItemsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                text: "${model.name}",
                textColor: Colors.white,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFontBangers(
                  mokupwidth: mokupwidth,
                  width: width,
                  text: "${model.price}",
                  textColor: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  final value =
                      Provider.of<CartProvider>(context, listen: true);
                  value.allCartItems.removeAt(index);
                  incartitemes.removeAt(index);
                  value.itemQuintity.removeAt(index);
                  value.UpdateCartTotal();
                },
                icon: const Icon(
                  Icons.remove_shopping_cart,
                  color: Colors.white,
                ),
              )
            ],
          ),
          Row(
            children: [
              const Spacer(),
              Quintity(
                width: width,
                index: index,
                model: model,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Quintity extends StatelessWidget {
  const Quintity(
      {Key? key, required this.width, required this.model, required this.index})
      : super(key: key);
  final double width;
  final ItemsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Row(
        children: [
          IconButton(
              onPressed: () {
                if (value.itemQuintity[index] == 1) {
                } else {
                  value.updateQuntitiy(index, false);
                }
              },
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
              )),
          TextFontBangers(
            mokupwidth: mokupwidth,
            width: width,
            text: "${value.itemQuintity[index]}",
            textColor: Colors.white,
          ),
          IconButton(
              onPressed: () {
                value.updateQuntitiy(index, true);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              )),
        ],
      );
    });
  }
}
