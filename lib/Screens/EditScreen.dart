import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shelter/Screens/checkout.dart';
import 'package:shelter/models/usermodel.dart';
import 'package:shelter/shared/constants.dart';
import 'package:shelter/shared/widgets.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController PhonenumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    emailController.text = thecurrentuser!.email!;
    thecurrentuser!.adress == null
        ? adressController.text = ""
        : adressController.text = thecurrentuser!.adress!;
    thecurrentuser!.phone == null
        ? PhonenumberController.text = ""
        : PhonenumberController.text = thecurrentuser!.phone!;

    nameController.text = thecurrentuser!.name!;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    adressController.dispose();
    nameController.dispose();
    PhonenumberController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: darkColor,
      appBar: AppBar(
        title: const Text('EditProfile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: yellow,
                  radius: min(height * 0.1, 500 * 0.1),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextform(
                    controller: nameController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "this feild must not be empty";
                      }
                    },
                    hinttext: "Enter your Name",
                    maxlines: 1,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    keyboardType: TextInputType.name,
                    prefexicon: const Icon(
                      Icons.person,
                    ),
                    text: "Name"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: defaulttextform(
                    controller: emailController,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "this feild must not be empty";
                      }
                    },
                    hinttext: "Enter your Email",
                    maxlines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    keyboardType: TextInputType.emailAddress,
                    prefexicon: const Icon(
                      Icons.email,
                    ),
                    text: "Email"),
              ),
              Padding(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                        width: 60,
                        child: Theme(
                          data: ThemeData(brightness: Brightness.dark),
                          child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: yellow),
                                labelText: "+20",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15)),
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
                          keyboardType: TextInputType.phone,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hinttext: "Enter Your Phone Number",
                          prefexicon: const Icon(Icons.phone),
                          text: "Phone"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: yellow, borderRadius: BorderRadius.circular(25)),
                    child: MaterialButton(
                      onPressed: () {
                        thecurrentuser = UserModel(
                            name: nameController.text,
                            adress: adressController.text,
                            phone: PhonenumberController.text,
                            email: emailController.text);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFontBangers(
                          mokupwidth: mokupwidth,
                          width: width,
                          text: "Save",
                          textColor: Colors.black,
                          size: 20,
                        ),
                      ),
                    )),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
