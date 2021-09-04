import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shelter/shared/constants.dart';

class TextArabicFont extends StatelessWidget {
  TextArabicFont({
    Key? key,
    required this.text,
  }) : super(key: key);
  String? text;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: "ElMessir",
        color: darkColor,
      ),
    );
  }
}

class TextFontBangers extends StatelessWidget {
  TextFontBangers(
      {Key? key,
      required this.mokupwidth,
      required this.width,
      required this.text,
      this.size = 25,
      this.textColor = const Color(0xff231f20)})
      : super(key: key);

  final int mokupwidth;
  final double width;
  final double size;
  final String text;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontFamily: "Bangers",
        color: textColor,
        fontSize: size / mokupwidth * width,
      ),
    );
  }
}

class CustomAnimatedIcon extends StatefulWidget {
  CustomAnimatedIcon(
      {Key? key,
      required this.animatedbool,
      required this.closeIcon,
      required this.closeIconColor,
      required this.openIcon,
      required this.openIconColor,
      required this.onopen})
      : super(key: key);
  final bool animatedbool;
  final IconData openIcon;
  final IconData closeIcon;
  final Color openIconColor;
  final Color closeIconColor;
  final VoidCallback onopen;

  @override
  _CustomAnimatedIconState createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onopen,
        icon: AnimatedSwitcher(
            switchInCurve: Curves.fastLinearToSlowEaseIn,
            switchOutCurve: Curves.easeInExpo,
            duration: const Duration(milliseconds: 2600),
            reverseDuration: const Duration(milliseconds: 100),
            transitionBuilder: (child, animat) => RotationTransition(
                  turns: animat,
                  child: child,
                ),
            child: widget.animatedbool
                ? Icon(
                    widget.openIcon,
                    key: const ValueKey(2),
                    color: widget.openIconColor,
                  )
                : Icon(
                    widget.closeIcon,
                    key: ValueKey(1),
                    color: widget.closeIconColor,
                  )));
  }
}

void showtost({text, color}) {
  Fluttertoast.showToast(
      msg: text,
      fontSize: 16,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: color,
      textColor: Colors.white);
}
