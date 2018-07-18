import 'package:flutter/material.dart';

class CounterActionButton extends StatefulWidget{
  final VoidCallback onPressed;
  final Icon iconType;

  CounterActionButton({Key key, this.onPressed, this.iconType}) : super(key: key);

  @override
  _MyCounterActionButton createState() => new _MyCounterActionButton();
}

class _MyCounterActionButton extends State<CounterActionButton> {

  int count = 1;

  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
        onPressed: () {
          setState(() {
            count = count + 1;
          });
        },
      tooltip: 'Increment',
      child:new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.iconType,
        ],
      )
    );
  }
}
