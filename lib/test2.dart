import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:ui' as ui;

class testclipper extends StatefulWidget {
  testclipper({Key? key}) : super(key: key);

  @override
  _testclipperState createState() => _testclipperState();
}

class _testclipperState extends State<testclipper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipPath(
                clipper: nameClipper(),
                child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .5,
                    color: Colors.grey.shade300),
              ),
              BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 4.0,
                  sigmaY: 4.0,
                ),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  ClipPath(
                    clipper: nameClipper(),
                    child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .6,
                        color: Colors.red),
                  ),
                  Container(
                    child: FittedBox(
                      clipBehavior: Clip.antiAlias,
                      fit: BoxFit.fitWidth,
                      child: Image.asset(
                        "/icons/nnn.png",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width * 0.9,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "/icons/wff.png",
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.height * 0.14,
                      filterQuality: FilterQuality.high,
                    ),
                    Text("Meal", style: TextStyle(fontSize: 34))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class nameClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double _xScaling = size.width / 400;
    final double _yScaling = size.height / 500;
    Path path_0 = Path();
    path_0.moveTo(0.065 * _xScaling, 203.082 * _yScaling);
    path_0.lineTo(0.131 * _xScaling, 406.164 * _yScaling);
    path_0.lineTo(1.282 * _xScaling, 408.525 * _yScaling);
    path_0.cubicTo(3.57 * _xScaling, 413.22 * _yScaling, 8.159,
        416.784 * _yScaling, 14.033 * _xScaling, 418.429 * _yScaling);
    path_0.lineTo(16.131 * _xScaling, 419.016 * _yScaling);
    path_0.lineTo(56.647 * _xScaling, 419.087 * _yScaling);
    path_0.cubicTo(96.46 * _xScaling, 419.156 * _yScaling, 97.19 * _xScaling,
        419.148 * _yScaling, 98.704 * _xScaling, 418.637 * _yScaling);
    path_0.cubicTo(102.23 * _xScaling, 417.446 * _yScaling, 105.295 * _xScaling,
        415.175 * _yScaling, 107.45 * _xScaling, 412.154 * _yScaling);
    path_0.cubicTo(
        109.625 * _xScaling,
        409.106 * _yScaling,
        110.241 * _xScaling,
        407.125 * _yScaling,
        111.351 * _xScaling,
        399.607 * _yScaling);
    path_0.cubicTo(
        112.617 * _xScaling,
        391.031 * _yScaling,
        116.827 * _xScaling,
        377.992 * _yScaling,
        121.047 * _xScaling,
        369.577 * _yScaling);
    path_0.cubicTo(
        148.816 * _xScaling,
        314.208 * _yScaling,
        217.834 * _xScaling,
        302.093 * _yScaling,
        260.62 * _xScaling,
        345.078 * _yScaling);
    path_0.cubicTo(
        274.706 * _xScaling,
        359.231 * _yScaling,
        286.245 * _xScaling,
        382.224 * _yScaling,
        288.642 * _xScaling,
        400.918 * _yScaling);
    path_0.cubicTo(
        289.811 * _xScaling,
        410.031 * _yScaling,
        293.419 * _xScaling,
        415.445 * _yScaling,
        300.197 * _xScaling,
        418.255 * _yScaling);
    path_0.lineTo(302.033 * _xScaling, 419.016 * _yScaling);
    path_0.lineTo(343.082 * _xScaling, 419.016 * _yScaling);
    path_0.lineTo(384.131 * _xScaling, 419.016 * _yScaling);
    path_0.lineTo(386.439 * _xScaling, 418.292 * _yScaling);
    path_0.cubicTo(
        392.818 * _xScaling,
        416.292 * _yScaling,
        396.604 * _xScaling,
        413.204 * _yScaling,
        399.083 * _xScaling,
        407.98 * _yScaling);
    path_0.lineTo(400 * _xScaling, 406.048 * _yScaling);
    path_0.lineTo(400 * _xScaling, 203.024 * _yScaling);
    path_0.lineTo(400 * _xScaling, 0);
    path_0.lineTo(199.999 * _xScaling, 0);
    path_0.lineTo(-0.001 * _xScaling, 0);
    path_0.lineTo(0.065 * _xScaling, 203.082 * _yScaling);
    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class BoxShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    // here are my custom shapes
    path.moveTo(size.width, size.height * 0.14);
    path.lineTo(size.width, size.height * 1.0);
    path.lineTo(size.width - (size.width * 0.99), size.height);
    path.close();

    canvas.drawShadow(path, Colors.black45, 3.0, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
