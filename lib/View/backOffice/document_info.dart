import 'package:flutter/material.dart';


class DocumentInfo extends StatelessWidget {
  final String _url_image;
  final String _date;
  final Map<String,dynamic> _user;


  DocumentInfo(this._url_image, this._date,this._user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ()=> showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Validation de la CIN'),
            content: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Image(image: AssetImage("assets/uploadedImages/"+_url_image),),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Refuser'),
                child: const Text('Refuser'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'Accepter'),
                child: const Text('Accepter'),
              ),
            ],
          ),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Row(
                  children: [
                    Text(_user["prenom"]+" "+_user["Nom"], textScaleFactor: 1.5),
                    Expanded(
                      child: Container(
                      ),
                    ),
                    Image(
                        image: AssetImage("assets/uploadedImages/"+_url_image),
                    height: 100,
                    width: 200,),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Déposé depuis " +_date,
                    textScaleFactor: 1,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
    );

  }
}