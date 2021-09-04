import 'package:flutter/material.dart';
import 'package:shelter/shared/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: yellow,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icons/logo.png",
                filterQuality: FilterQuality.high,
                width: width * 0.3,
              ),
              const Text("Shelter House Of Cheese",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Oswald",
                    color: Colors.black,
                  )),
            ],
          ),
        ));
  } //mohamedfarouk@gmail.com
}
