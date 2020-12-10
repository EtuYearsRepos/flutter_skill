import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranListe.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Loader extends StatefulWidget {

  final String id;
  final String name;
  final String email;
  final String password;
  final String status;

  Loader({Key key, @required this.id, this.name, this.email, this.password, this.status}) : super(key: key);

  @override
  LoaderState createState() => LoaderState();
  }


class LoaderState extends State<Loader> 
{
  List<dynamic> message;


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration:  BoxDecoration(color: Colors.white),
            ),
            new Container(
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(top:30.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        ),
                        Text(() 
                      {
                        if (widget.status == "0")
                          return "Récupération de vos professeurs";
                        else
                          return "Récupération de vos éleves";
                      }()),
                    ],
                  ),
                ),
              ],
            ),
          ],
       ),
      ),
    );
  }

@override
void initState()
{
  super.initState();

  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    fetch();
  });

}

@protected
Future fetch() async
{
  int id = int.parse(widget.id);
  // SERVER LOGIN API URL
  var url = 'https://flagrant-amusements.000webhostapp.com/getListeUser.php';

  // Store all data with Param Name.
  var data = {'id' : id};

  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));

  message = json.decode(response.body);

  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) =>
    EcranListe(
      id: widget.id,
      name: widget.name,
      email: widget.email,
      password: widget.password,
      status: widget.status,
      message : message)
  ),
);
}
}