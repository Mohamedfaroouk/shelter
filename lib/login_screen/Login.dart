import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shelter/Screens/menu.dart';
import 'package:shelter/models/usermodel.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/remote/diohelper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'customroate.dart';

const users = const {
  'farouk@gmail.com': '123456',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => const Duration(milliseconds: 2250);
  static const routeName = '/auth';
  Future<String?> _authUser(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: data.name, password: data.password);
      return Future.delayed(const Duration(seconds: 3)).then((_) async {
        uid = userCredential.user!.uid;
        var box = await Hive.box("token");
        box.put("uid", "$uid");

        Diohelp.getdata(text: "users?uid=$uid").then((value) {
          value.data[0]["incart"] == null
              ? incartitemes = []
              : incartitemes = value.data[0]["incart"];
          thecurrentuser = UserModel.fromJson(value.data[0]);
        });
        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.delayed(const Duration(seconds: 3)).then((_) {
          return 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        return Future.delayed(const Duration(seconds: 3)).then((_) {
          return 'Wrong password provided for that user';
        });
      }
    }
  }

  Future<String?> _regUser(RegData data) async {
    //print('Name: ${data.name}, Password: ${data.password}');

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: data.name, password: data.password);
      return Future.delayed(const Duration(seconds: 3)).then((_) async {
        uid = userCredential.user!.uid;
        var box = await Hive.box("token");
        box.put("uid", "$uid");

        Diohelp.getdata(text: "users?uid=$uid").then((value) {
          value.data[0]["incart"] == null
              ? incartitemes = []
              : incartitemes = value.data[0]["incart"];
          thecurrentuser = UserModel.fromJson(value.data[0]);
        });
        Diohelp.postdata(text: "users", data: {
          "uid": userCredential.user!.uid,
          "name": data.myname,
          "phone": data.myphone,
          "email": data.name,
        });
        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.delayed(const Duration(seconds: 3)).then((_) {
          return 'No user found for that email.';
        });
      } else if (e.code == 'wrong-password') {
        return Future.delayed(const Duration(seconds: 3)).then((_) {
          return 'Wrong password provided for that user';
        });
      }
    }
  }

  Future<String?> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double logosize = 45;
    if (width > 360) {
      width = 360;
      logosize = 50;
    }
    if (width < 350) {
      logosize = 30;
    }
    return FlutterLogin(
      theme: LoginTheme(
          footerBottomPadding: 20,
          logoWidth: 20,
          inputTheme: const InputDecorationTheme(
              labelStyle: TextStyle(), filled: true, fillColor: Colors.black12),
          cardTheme: CardTheme(color: Colors.white),
          textFieldStyle: TextStyle(color: darkColor),
          primaryColor: yellow,
          pageColorLight: yellow,
          pageColorDark: yellow.withOpacity(0.5),
          titleStyle: TextStyle(
              height: 0,
              fontSize: width * 0.05,
              color: darkColor,
              fontFamily: "Oswald",
              fontWeight: FontWeight.w500)),
      userType: LoginUserType.phone,
      logo: ("assets/icons/logo.png"),
      messages: LoginMessages(nameHint: "Name", phoneHint: "Phone number"),
      onLogin: (LoginData) => _authUser(LoginData),
      onSignup: (RegData) => _regUser(RegData),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => const Menu(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            if (!kIsWeb) {
              await signInWithGoogle().then((valuee) async {
                uid = valuee.user!.uid;
                var box = await Hive.box("token");
                box.put("uid", "$uid");
                Diohelp.getdata(text: "users?uid=$uid").then((value) {
                  thecurrentuser = UserModel.fromJson(value.data[0]);
                  value.data[0]["incart"] == null
                      ? incartitemes = []
                      : incartitemes = value.data[0]["incart"];
                  if (value.statusCode == 404) {
                    Diohelp.postdata(text: "users", data: {
                      "uid": valuee.user!.uid,
                      "name": valuee.user!.displayName,
                      "phone": valuee.user!.phoneNumber,
                      "email": valuee.user!.email
                    });
                  }
                });
              });
              ;
            } else {
              await signInWithGoogleWithWeb().then((valuee) async {
                uid = valuee.user!.uid;
                var box = await Hive.box("token");
                box.put("uid", "$uid");
                Diohelp.getdata(text: "users?uid=$uid").then((value) {
                  thecurrentuser = UserModel.fromJson(value.data[0]);
                  value.data[0]["incart"] == null
                      ? incartitemes = []
                      : incartitemes = value.data[0]["incart"];
                  if (value.statusCode == 404) {
                    Diohelp.postdata(text: "users", data: {
                      "uid": valuee.user!.uid,
                      "name": valuee.user!.displayName,
                      "phone": valuee.user!.phoneNumber,
                      "email": valuee.user!.email
                    });
                  }
                });
              });
            }
          },
        ),
      ],
    );
  }
}

Future<UserCredential> signInWithGoogleWithWeb() async {
  // Create a new provider
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithPopup(googleProvider);
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
