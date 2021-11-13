import 'package:flutter/material.dart';
import 'dart:math' as math;

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  late String? _email;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator PrincipalctaWidget - INSTANCE

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Bubbles.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Form(
              key: _keyForm,
              child: ListView(
                  children: [
                    Container(
              margin: EdgeInsets.fromLTRB(15, 150, 15, 0),
              child: Column(
                  children: [
                   Text('Se Connecter', textAlign: TextAlign.center, style: TextStyle(
                        color: Color.fromRGBO(18, 14, 33, 1),
                        fontFamily: 'Red Hat Display',
                        fontSize: 27,
                        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1
                    ),)

                    ,

                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 35, 10, 10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Email",
                          fillColor: Colors.white,
                        ),
                        onSaved: (String? value) {
                          _email = value;
                        },
                        validator: (String? value) {
                          String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          if(value == null || value.isEmpty) {
                            return "L'adresse email ne doit pas etre vide";
                          }
                          else if(!RegExp(pattern).hasMatch(value)) {
                            return "L'adresse email est incorrecte";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Mot de passe"),
                        onSaved: (String? value) {
                          _password = value;
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Le mot de passe ne doit pas etre vide";
                          }
                          else if(value.length < 5) {
                            return "Le mot de passe doit avoir au moins 5 caractères";
                          }
                          else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                        child: ElevatedButton(
                          onPressed: () { Navigator.pushNamed(context, "/accueil");  },
                          style:  ElevatedButton.styleFrom(
                            primary : Colors.green,
                          ),
                          child: const Text("Se connecter",textScaleFactor: 1.1,),

                        )
                    ),



                       Row(
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          const Text("Vous n'avez pas de compte ?"),
                          const SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            child:  const Text('Cliquez ici ', style: TextStyle(color: Colors.blueAccent),),
                            onTap: () {Navigator.pushNamed(context, "/signup");},
                          ),
                        ],
                      ),



              ]))]))),
    );
  }
}

/*typedef void TextCallBack(String? value);

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
*/