import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shelter/shared/constants.dart';

class testanimation extends StatefulWidget {
  testanimation({Key? key}) : super(key: key);

  @override
  _testanimationState createState() => _testanimationState();
}

Animation<double>? _buttonScaleAnimation;
AnimationController? controller;
Animation<Offset>? offset;
bool show = false;
double x = 50;
Interval? tstinhertant;

class _testanimationState extends State<testanimation>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    tstinhertant = const Interval(0, .85);

    offset = Tween<Offset>(begin: Offset(-.1, 0), end: Offset.zero).animate(

        // TODO: implement initState
        _buttonScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller!.view, curve: Curves.easeOutBack),
    ));
    controller!.forward();
    Timer(const Duration(milliseconds: 300), () {
      x = 200;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: Center(
        child: Container(
          width: 300,
          child: Container(
            decoration: BoxDecoration(color: Colors.yellow, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            width: 200,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ScaleTransition(
                      scale: _buttonScaleAnimation!,
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          color: Colors.red,
                          width: x,
                          height: 50)),
                ),
                /*  Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.red,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            color: Colors.blue,
                          ),
                          Container(
                            width: 200,
                            child: AnimatedCrossFade(
                                alignment: Alignment.centerLeft,
                                firstCurve: Curves.easeInOut,
                                secondCurve: Curves.linear,
                                firstChild: Container(
                                  color: Colors.white,
                                  width: 0,
                                ),
                                sizeCurve: Curves.bounceOut,
                                secondChild: SlideTransition(
                                  position: offset!,
                                  child: Container(
                                    color: Colors.yellow,
                                    width: 200,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                    ),
                                  ),
                                ),
                                crossFadeState: show
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: Duration(milliseconds: 1000)),
                          ),
                          Container(
                            width: 200,
                            height: 100,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                */
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (controller!.isCompleted) {
                          controller!.reverse();
                          Timer(Duration(milliseconds: 1100), () {
                            setState(() {
                              show = !show;
                            });
                          });
                        } else {
                          show = !show;
                          Timer(Duration(milliseconds: 1100), () {
                            setState(() {
                              controller!.forward();
                            });
                          });
                        }
                      });
                    },
                    icon: Icon(Icons.ac_unit))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
