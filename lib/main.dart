//import 'package:boe/search_bar.dart';
import 'package:boe/display_poll_items.dart';
import 'package:boe/poll_list_items.dart';
import 'package:boe/poll_manager.dart';
import 'package:flutter/material.dart';

void main() => runApp(new PollApp());

class PollApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[200],
      ),
      home: Scaffold(
        body: PollManager(), //SearchBar(), //CrudSample(), //SearchBar(),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/PollPage': (BuildContext context) => new PollListItems(),
        '/DisplayPollItems': (BuildContext context) => new DisplayPollItems(),
      },
    );
  }
}
