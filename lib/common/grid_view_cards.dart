import 'package:flutter/material.dart';

class GridViewCards extends StatefulWidget {
  List<String> lstDocumentIds;
  GridViewCards({Key key, this.lstDocumentIds}) : super(key: key);

  @override
  _GridViewCardsState createState() => new _GridViewCardsState();
}

class _GridViewCardsState extends State<GridViewCards> {
  Card makeGridCell(String name, IconData icon) {
    return Card(
      elevation: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Center(child: Icon(icon)),
          Center(child: Text(name)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        primary: true,
        padding: EdgeInsets.all(1.0),
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          makeGridCell("Home", Icons.home),
          makeGridCell("Email", Icons.email),
          makeGridCell("Chat", Icons.chat_bubble),
          makeGridCell("News", Icons.new_releases),
          makeGridCell("Network", Icons.network_wifi),
          makeGridCell("Options", Icons.settings),
        ]);
  }
}
