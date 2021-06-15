import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget{
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  Future<String> sendData() async{
  String cadena ="{"+
   " 'NameUser':'Roberto Gomez', "+
   "  'EventDate':DateTime.now().toIso8601String(),"+
   "  'message':'This is test crap message 1' "+
  "} ";
  var data = json.encode(cadena);
  var response = await http.post(
    Uri.encodeFull("https://apiproductortweet.azurewebsites.net/api/data"), //v13 no lo soporta
    headers: {"Content-type":"application/json"},
         body: jsonEncode(<String, String>{
        "NameUser":"Roberto Gomez Cossio",
        "EventDate":DateTime.now().toIso8601String(),
        "message":myController.text,
      })
  );
  print(response.body);
  return "Success!!";
}
final myController = TextEditingController();

@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

@override
  Widget build(BuildContext context){
    TextField(
  controller: myController,
);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tweet Analyzer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: sendData,
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}