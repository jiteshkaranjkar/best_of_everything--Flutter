import 'package:boe/search_bar.dart';
import 'package:flutter/material.dart';

class PollManager extends StatelessWidget {
  Widget build(BuildContext context) {
    //var divHeight = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: new Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//              Column(
//                children: [
//                  new Container(
//                    decoration: new BoxDecoration(
//                      gradient: new LinearGradient(
//                          begin: Alignment.topLeft,
//                          end: Alignment.bottomRight,
//                          colors: [Colors.blue, Colors.blueAccent]),
//                      boxShadow: [
//                        new BoxShadow(color: Colors.black, blurRadius: 10.0),
//                      ],
////                      color: Colors.black54,
//                      borderRadius: BorderRadius.only(
//                          bottomLeft: Radius.circular(15.0),
//                          bottomRight: Radius.circular(15.0)),
////                      image: new DecorationImage(
////                        colorFilter: new ColorFilter.mode(
////                            Colors.white.withOpacity(0.8), BlendMode.dstOver),
////                        image: new AssetImage('res/images/M0Ctvh9.jpeg'),
////                        fit: BoxFit.cover,
////                      )
//                    ),
//                    height: divHeight / 2 * 0.3,
//                  ),
//                ],
//              ),
            Column(children: <Widget>[
              SearchBar(),
            ]),
          ],
        ),
      ),
    );
  }
}
