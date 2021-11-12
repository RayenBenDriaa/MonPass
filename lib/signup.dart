import 'package:flutter/material.dart';
import 'dart:math' as math;

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String? _username;
  late String? _email;
  late String? _password;
  late String? _birth;
  late String? _address;
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator PrincipalctaWidget - INSTANCE

    return Scaffold(
        body: Form(
            key: _keyForm,
            child: ListView(children: [
              Container(
                width: 501,
                height: 819,
                decoration: new BoxDecoration(color: Colors.white),
                child: Stack(children: <Widget>[
                  Positioned(
                      top: 768,
                      left: 41,
                      child: Container(
                          width: 52,
                          height: 51,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 235, 180, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(52, 51)),
                          )))

                  ,Positioned(
                      top: 583,
                      left: 421,
                      child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(154, 228, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(40, 40)),
                          ))),
                  Positioned(
                      top: 553,
                      left: 106,
                      child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(154, 228, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(60, 60)),
                          ))),
                  Positioned(
                      top: 534,
                      left: 310,
                      child: Container(
                          width: 79,
                          height: 77,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 235, 180, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(79, 77)),
                          ))),
                  Positioned(
                      top: 531,
                      left: 244,
                      child: Transform.rotate(
                        angle: -180 * (math.pi / 180),
                        child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 235, 180, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(30, 30)),
                            )),
                      )),
                  Positioned(
                      top: 493,
                      left: 310,
                      child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(173, 202, 168, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(16, 16)),
                          ))),
                  Positioned(
                      top: 463,
                      left: 404,
                      child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 249, 234, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(46, 46)),
                          ))),
                  Positioned(
                      top: 387,
                      left: 236,
                      child: Container(
                          width: 50,
                          height: 51,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 234, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(50, 51)),
                          ))),
                  Positioned(
                      top: 381,
                      left: 0,
                      child: Container(
                          width: 163,
                          height: 163,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 249, 234, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(163, 163)),
                          ))),
                  Positioned(
                      top: 365,
                      left: 346,
                      child: Container(
                          width: 66,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 235, 180, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(66, 65)),
                          ))),
                  Positioned(
                      top: 262,
                      left: 410,
                      child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(154, 228, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(48, 48)),
                          ))),
                  Positioned(
                      top: 262,
                      left: 67,
                      child: Container(
                          width: 72,
                          height: 73,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 234, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(72, 73)),
                          ))),
                  Positioned(
                      top: 237,
                      left: 271,
                      child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(191, 235, 180, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(25, 25)),
                          ))),
                  Positioned(
                      top: 231,
                      left: 221,
                      child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 249, 234, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(16, 16)),
                          ))),
                  Positioned(
                      top: 197,
                      left: 288,
                      child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(173, 202, 168, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15)),
                          ))),
                  Positioned(
                      top: 187,
                      left: 158,
                      child: Container(
                          width: 31,
                          height: 31,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(173, 202, 168, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(31, 31)),
                          ))),
                  Positioned(
                      top: 171,
                      left: 379,
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 249, 234, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(50, 50)),
                          ))),
                  Positioned(
                      top: 131,
                      left: 82,
                      child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(154, 228, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(46, 46)),
                          ))),
                  Positioned(
                      top: 130,
                      left: 207,
                      child: Container(
                          width: 65,
                          height: 66,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 234, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(65, 66)),
                          ))),
                  Positioned(
                      top: 100,
                      left: 303,
                      child: Container(
                          width: 40,
                          height: 41,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(154, 228, 153, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(40, 41)),
                          ))),
                  Positioned(
                      top: 91,
                      left: 189,
                      child: Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 234, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(15, 15)),
                          ))),
                  Positioned(
                      top: 13,
                      left: 225,
                      child: Container(
                          width: 78,
                          height: 79,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(173, 202, 168, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(78, 79)),
                          ))),
                  Positioned(
                      top: 9,
                      left: 93,
                      child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(235, 249, 234, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(54, 54)),
                          ))),Positioned(
                      top: 120,
                      left: 123,
                      child :Text('Inscription', textAlign: TextAlign.center, style: TextStyle(
                          color: Color.fromRGBO(18, 14, 33, 1),
                          fontFamily: 'Red Hat Display',
                          fontSize: 27,
                          letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.normal,
                          height: 1
                      ),)),

                  Positioned(
                      top: 0,
                      left: 356,
                      child: Container(
                          width: 145,
                          height: 147,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(213, 234, 211, 1),
                            borderRadius:
                                BorderRadius.all(Radius.elliptical(145, 147)),
                          ))),
                  Positioned(
                    top: 642,
                    left: 56,
                    child: Container(

                      width: 263,
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60),
                        ),
                        color: Color.fromRGBO(36, 140, 40, 1),
                      ),
                      child: ElevatedButton(
                        onPressed: () { Navigator.pushNamed(context, "/signin");  },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.green),
                                )
                            )
                        ),
                        child: Text(
                          "S'inscrire",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),

                  ),
                  Center(
                    child: Container(
                        width: 343,
                        height: 412,
                        decoration: BoxDecoration(
                          borderRadius : BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color : Color.fromRGBO(255, 255, 255, 0.23999999463558197),
                          border : Border.all(
                            color: Color.fromRGBO(251, 234, 255, 1),
                            width: 1,
                          ),
                        ),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            TextFieldUser(
                              label: "username",
                              onSaved: (value) {},
                            ),
                            SizedBox(height: 8,),
                            TextFieldUser(
                              label: "prenom",
                              onSaved: (value) {},
                            ),
                            SizedBox(height: 8,),
                            TextFieldUser(
                              label: "Email",
                              onSaved: (value) {},
                            ),
                            SizedBox(height: 8,),
                            TextFieldUser(
                              label: "Password",
                              onSaved: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ]),
              )
            ])));
  }
}

typedef void TextCallBack(String? value);

class TextFieldUser extends StatelessWidget {
  final String label;

  TextFieldUser({
    required this.label,
    required this.onSaved,
    Key? key,
  }) : super(key: key);
  TextCallBack onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
        onSaved: (value) => onSaved(value));
  }
}
