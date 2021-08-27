import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Great places",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Great places"),
        ),
        body: Center(
          child: Text("hello there"),
        ),
      ),
    );
  }
}
