import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() =>_LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  late Future<bool> _session;

  Future<bool> _verifySession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("first")) {
      if (prefs.containsKey("nomPrenom")) {
        Navigator.pushNamed(context, "/accueil");
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
