import 'package:flutter/material.dart';

class CounterActionButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Icon iconType;
  final Text counterNo;
  final String tag;
  CounterActionButton(
      {Key key, this.onPressed, this.iconType, this.tag, this.counterNo})
      : super(key: key);
  @override
  _MyCounterActionButton createState() => new _MyCounterActionButton();
}

class _MyCounterActionButton extends State<CounterActionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: [
              new FloatingActionButton(
                heroTag: widget.tag,
                mini: true,
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
