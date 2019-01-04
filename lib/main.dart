import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './chuck_model.dart';

Future<Chuck> fetchChuck() async {
  final response =
      await http.get('https://api.chucknorris.io/jokes/random');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Chuck.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

void main() => runApp(MyApp(chuck: fetchChuck()));

class MyApp extends StatelessWidget {
  final Future<Chuck> chuck;

  MyApp({Key key, this.chuck}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuck Flutters',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Chuck Flutters'),
        ),
        body: Center(
          child: FutureBuilder<Chuck>(
            future: chuck,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.value, 
                            textAlign: TextAlign.center, 
                            overflow: TextOverflow.clip, 
                            style:TextStyle(fontWeight: FontWeight.bold));
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
