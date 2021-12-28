import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() =>_LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  late Future<bool> _session;
  final String _baseUrl = "lencadrant.tn";

  Future<bool> _verifySession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("first")) {
      if (prefs.containsKey("nomPrenom")) {
        String email=prefs.getString("email")!;
        http.Response responseRd= await http.get(Uri.http(_baseUrl, "/requested/data/getRequestedDataJSON/"+email));
        print(responseRd.body);
        if(responseRd.statusCode==200)
          {
            print(responseRd.body);
            if(responseRd.body.toString().trim()!="null")
              {
                print("good");
                Map<String,dynamic> dataRd = json.decode(responseRd.body);
                print(dataRd);
                if(dataRd["approval"].toString()=="no")
                {
                  Navigator.pushNamed(context, "/signinWith");
                }
                else
                {
                  Navigator.pushNamed(context, "/accueil");
                }
              }
            else
            {
              print("not good");
              Navigator.pushNamed(context, "/accueil");
            }


          }
        else
          {
            Navigator.pushNamed(context, "/accueil");
          }
      }
      else
        {
          Navigator.pushNamed(context, "/signin");
        }
    }
    else
      {
        prefs.setString("first", "no");
        Navigator.pushNamed(context, "/introductionAnimationScreen");
      }

    return true;
  }


  @override
  void initState() {
    _session = _verifySession();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _session,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Bubbles.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:  Scaffold(
              body: Center(child: SpinKitFadingGrid(color: Color(0xff00a67c)),
              ),
              backgroundColor: Colors.white,
            ),

          );

        } else {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Bubbles.png'),
                fit: BoxFit.cover,
              ),
            ),
            child:  Scaffold(
              body: Center(child: SpinKitFadingGrid(color: Color(0xff00a67c)),
              ),
              backgroundColor: Colors.white,
            ),

          );
        }
      },
    );
  }

}
