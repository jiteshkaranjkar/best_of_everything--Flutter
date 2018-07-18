import 'package:flutter/material.dart';

import './poll_manager.dart';

void main() => runApp(new PollApp());

class PollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme:ThemeData(
          primarySwatch: Colors.deepOrange
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Best Of Everything"),
        ),
        body: new PollManager(),
      ),
    );
  }
}