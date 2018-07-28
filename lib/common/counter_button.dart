import 'package:flutter/material.dart';

class CounterActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Icon iconType;
  final Text counterNo;
  CounterActionButton({Key key, this.onPressed, this.iconType, this.counterNo})
      : super(key: key);
  @override
  _MyCounterActionButton createState() => new _MyCounterActionButton();
}

class _MyCounterActionButton extends State<CounterActionButton> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              new FloatingActionButton(
                onPressed: widget.onPressed,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    widget.iconType,
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            widget.counterNo,
          ],
        ),
      ],
    );
  }
}
