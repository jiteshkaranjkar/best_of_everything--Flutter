//import 'package:boe/common/grid_view_cards.dart';
import 'package:boe/display_poll_items.dart';
import 'package:boe/poll_list_items.dart';
import 'package:boe/poll_manager.dart';
import 'package:flutter/material.dart';

void main() => runApp(new PollApp());

class PollApp extends StatefulWidget {
  PollApp({Key key}) : super(key: key);

  @override
  _PollAppState createState() => new _PollAppState();
}

class _PollAppState extends State<PollApp> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

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
