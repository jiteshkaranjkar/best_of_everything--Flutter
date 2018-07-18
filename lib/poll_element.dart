import 'package:flutter/material.dart';

import './counter_button.dart';
import './poll.dart';

class PollElement extends StatefulWidget{
  final String poll;
  PollElement({Key key, this.poll}) : super(key: key);

  @override
  _MyPollElement createState() => new _MyPollElement();
}

class _MyPollElement extends State<PollElement> {
  int _incCounter = 0;
  int _decCounter = 0;
  @override
  Widget build(BuildContext context){
    return
      Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: [
            new Text(
              widget.poll, style:Theme.of(context).textTheme.display1,
            ),
          ],
        ),
        Column(
          children: [
            FloatingActionButton(
              onPressed: () {
                  setState(() {
                    _incCounter++;
                  });
                },
                child:new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                      new Icon(Icons.thumb_up, color: Colors.white),
                ],
              )
            ),
            new Text(
              '$_incCounter',
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),
        Column(
          children: [
            FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _decCounter++;
                  });
                },
                child:new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.thumb_down, color: Colors.black),
                  ],
                )
            ),
            new Text(
              '$_decCounter',
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),// This trailing comma makes auto-formatting nicer for build methods.
      ],
    );
  }
}