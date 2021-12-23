import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;

class Avatar extends StatefulWidget {
  Avatar({
    Key? key,
  }) : super(key: key);

  @override
  _MyAvatarState createState() => _MyAvatarState();
}

class _MyAvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    var isWeb = platform != TargetPlatform.android &&
        platform != TargetPlatform.iOS &&
        platform != TargetPlatform.macOS &&
        platform != TargetPlatform.windows &&
        platform != TargetPlatform.fuchsia;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Use your Fluttermoji anywhere\nwith the below widget",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          FluttermojiCircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "and create your own page to customize them using our widgets",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Spacer(flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.edit),
                    label: Text("Customize"),
                    onPressed: () => Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => NewPage())),
                  ),
                ),
              ),
              Spacer(flex: 2),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          (isWeb)
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_rounded,
                size: 50,
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                child: Column(
                  children: [
                    Text("Web preview is unstable at the moment\n",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "This demo may not work on your mobile browser,\nUse your Desktop browser or install the app."),
                  ],
                ),
              )
            ],
          )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var platform = Theme.of(context).platform;
    var isWeb = platform != TargetPlatform.android ||
        platform != TargetPlatform.iOS ||
        platform != TargetPlatform.fuchsia;

    return Scaffold(
      appBar: AppBar(
        //title: const Text("Mon Passe"),
        backgroundColor: Color(0xff00a67c),
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Container(
            height: 80,
            margin: const EdgeInsets.fromLTRB(60, 20, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const Text("Customiser mon avatar",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                  ),
                ),
                const Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: FluttermojiCircleAvatar(
              radius: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
            child: FluttermojiCustomizer(
              //scaffoldHeight: 400,
              showSaveWidget: true,
              scaffoldWidth: isWeb ? 600 : 0,
            ),
          ),
        ],
      ),
    );
  }
}
