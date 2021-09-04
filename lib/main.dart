import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelter/Screens/menu.dart';
import 'package:shelter/models/usermodel.dart';
import 'package:shelter/provider/cart_provider.dart';
import 'package:shelter/provider/drawer_provider.dart';
import 'package:shelter/provider/main_provider.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/remote/diohelper.dart';
import 'package:shelter/splashscreen.dart';
import 'package:shelter/test.dart';
import 'package:shelter/test2.dart';

import 'login_screen/Login.dart';

Widget screen = const Menu();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Diohelp.init();
  await Hive.initFlutter();
  var box = await Hive.openBox("token");
  uid = box.get("uid");
  await Firebase.initializeApp();

  if (uid == null) {
    screen = LoginScreen();
  } else {
    print(uid);
    Diohelp.getdata(text: "users?uid=$uid").then((value) {
      value.data[0]["incart"] == null
          ? incartitemes = []
          : incartitemes = value.data[0]["incart"];

      thecurrentuser = UserModel.fromJson(value.data[0]);
      print(thecurrentuser!.name);
    });
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: const Color(0xffffcc00).withOpacity(0.3)));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MainProvider()..getmenudata()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: DrawerProvider())
      ],
      child: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3)),
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: yellow,
              ),
              home: snapshot.connectionState == ConnectionState.waiting
                  ? const SplashScreen()
                  : //OrdersScreen()

                  screen,
            );
          }),
    );
  }
}
