import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/widgets.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    if (width > 600) {
      width = 600;
    }
    return Scaffold(
      backgroundColor: darkColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            return ExpandablePanel(
                theme: const ExpandableThemeData(iconColor: Colors.white),
                header: TextFontBangers(
                    mokupwidth: mokupwidth,
                    textColor: Colors.white,
                    width: width,
                    text: "Order ${orders[index].date}"),
                collapsed: const SizedBox(),
                expanded: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            TextFontBangers(
                                mokupwidth: mokupwidth,
                                width: width,
                                textColor: Colors.white,
                                text: "Confirmed"),
                            const SizedBox(
                              width: 5,
                            ),
                            if (orders[index].isconfirmed!)
                              Icon(
                                Icons.verified,
                                color: yellow,
                              )
                            else
                              const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )
                          ],
                        ),
                        Row(
                          children: [
                            TextFontBangers(
                                textColor: Colors.white,
                                mokupwidth: mokupwidth,
                                width: width,
                                text: "Onway"),
                            const SizedBox(
                              width: 5,
                            ),
                            if (orders[index].onway!)
                              Icon(
                                Icons.verified,
                                color: yellow,
                              )
                            else
                              const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )
                          ],
                        ),
                        Row(
                          children: [
                            TextFontBangers(
                                textColor: Colors.white,
                                mokupwidth: mokupwidth,
                                width: width,
                                text: "Deliverd"),
                            const SizedBox(
                              width: 5,
                            ),
                            if (orders[index].deliverd!)
                              Icon(
                                Icons.verified,
                                color: yellow,
                              )
                            else
                              const Icon(
                                Icons.cancel,
                                color: Colors.white,
                              )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return orderDetails(width: width, i: index);
                                  });
                            },
                            child: TextFontBangers(
                              mokupwidth: mokupwidth,
                              width: width,
                              text: "Details",
                              textColor: Colors.white,
                            )),
                        Visibility(
                          visible: orders[index].isconfirmed! ? false : true,
                          child: InkWell(
                              child: TextFontBangers(
                            mokupwidth: mokupwidth,
                            width: width,
                            text: "Cancel",
                            textColor: Colors.white,
                          )),
                        ),
                      ],
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class orderDetails extends StatelessWidget {
  const orderDetails({
    Key? key,
    required this.width,
    required this.i,
  }) : super(key: key);

  final double width;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkColor,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orders[i].orders!.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextFontBangers(
                      mokupwidth: mokupwidth,
                      width: width,
                      text: "${orders[i].orders![index].name}",
                      textColor: Colors.white,
                    ),
                    TextFontBangers(
                      mokupwidth: mokupwidth,
                      width: width,
                      text: "${orders[i].qunitity![index]}",
                      textColor: Colors.white,
                    ),
                    TextFontBangers(
                      mokupwidth: mokupwidth,
                      width: width,
                      text: "${orders[i].orders![index].price}",
                      textColor: Colors.white,
                    ),
                  ],
                );
              },
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
                  text: "Sub Total",
                  textColor: Colors.white,
                ),
                const Spacer(),
                TextFontBangers(
                  mokupwidth: mokupwidth,
                  width: width,
                  text: "${orders[i].subtotal}.00",
                  textColor: Colors.white,
                )
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
                  text: "Tax",
                  textColor: Colors.white,
                ),
                Spacer(),
                TextFontBangers(
                  mokupwidth: mokupwidth,
                  width: width,
                  text: "${orders[i].tax}.00",
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFontBangers(
                mokupwidth: mokupwidth,
                width: width,
                text: "Total",
                textColor: Colors.white,
              ),
              TextFontBangers(
                mokupwidth: mokupwidth,
                width: width,
                text: "${orders[i].total}.00",
                textColor: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
