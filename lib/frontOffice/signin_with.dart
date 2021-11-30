import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SigninWith extends StatefulWidget {
  const SigninWith({Key? key}) : super(key: key);

  @override
  State<SigninWith> createState() => _SigninWithState();
}

class _SigninWithState extends State<SigninWith> {


  bool requestData=false;
  bool sendData=false;

  final String _baseUrl = "10.0.2.2:8000";

  late Future<bool> fetchedData;

  Future<bool> fetchData() async {
    //requete GET pour obtenir l'entité CIN d'un user
    http.Response responseDocs= await http.get(Uri.http(_baseUrl, "/api/getDocsBy/"+"1"));
    http.Response responseRd= await http.get(Uri.http(_baseUrl, "/requested/data/showRdJSON/"+"rayenbd63s@gmail.com"));
    //http.Response responseRdEdit = await http.post(Uri.http(_baseUrl, "/requested/data/editRdJSON/"+"3"));
    print("\n");
    print(responseDocs.body);
    print("\n");
    print(responseRd.body);
    if (responseDocs.body!="User not found" && responseRd.statusCode==200)
    {
      Map<String,dynamic> dataDocs = json.decode(responseDocs.body);
      Map<String,dynamic> dataRd = json.decode(responseRd.body);
      if((dataRd["cin"]=="yes" && dataDocs["imageCin"]=="null")||
          (dataRd["passeport"]=="yes" && dataDocs["imagePasseport"]=="null")||
          (dataRd["facture"]=="yes" && dataDocs["imageFacture"]=="null"))
      {
        Navigator.pushNamed(context, "/profil");
      }
      else
      {
        requestData=true;
        String imageCin="null";
        String imagePasseport="null";
        String imageFacture="null";
        if(dataRd["cin"]=="yes")
        {
          imageCin=dataDocs["imageCin"];
        }
        if(dataRd["passeport"]=="yes")
        {
          imagePasseport=dataDocs["imagePasseport"];
        }
        if(dataRd["facture"]=="yes")
        {
          imageFacture=dataDocs["imageFacture"];
        }
        var dataDocsPost = {"email" : "rayenbd63s@gmail.com","cin" : imageCin,"passeport" : imagePasseport, "facture" :imageFacture};
        http.Response responseDocsEdit = await http.post(Uri.http("10.0.2.2:8001", "/editJSON"), body: dataDocsPost);
        if (responseDocsEdit.statusCode==200 || responseDocsEdit.statusCode==201)
        {
          sendData=true;
        }
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    }



    return true;
  }

  @override
  void initState() {
    fetchedData=fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedData,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if(snapshot.hasData)
          {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child:  Scaffold(
                body: Center(child: CircularProgressIndicator()),
                backgroundColor: Colors.transparent,
              ),

            );
          }
          else
          {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Bubbles.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child:  Scaffold(
                body: Center(child: CircularProgressIndicator()),
                backgroundColor: Colors.transparent,
              ),

            );
          }
        }
    );
  }
}
