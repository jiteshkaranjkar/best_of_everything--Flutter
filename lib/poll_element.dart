import 'package:boe/common/counter_button.dart';
import 'package:flutter/material.dart';

class PollElement extends StatefulWidget {
  final String poll;
  PollElement({Key key, this.poll}) : super(key: key);
  @override
  _MyPollElement createState() => new _MyPollElement();
}

class _MyPollElement extends State<PollElement> {
  int _incCounter = 0;
  int _decCounter = 0;

  onDecrementCounter() {
    setState(() {
      _decCounter--;
    });
    print("Decrement counter $_decCounter");
  }

  onIncrementCounter() {
    setState(() {
      _incCounter++;
    });
    print("Decrement counter $_decCounter");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          children: [
            new Text(
              widget.poll,
              style: Theme.of(context).textTheme.headline,
            ),
          ],
        ),
        Column(
          children: [
            CounterActionButton(
                onPressed: onIncrementCounter,
                iconType: new Icon(
                  Icons.thumb_up,
                  color: Colors.white,
                  size: 18.0,
                ),
                counterNo: new Text('$_incCounter',
                    style: Theme.of(context).textTheme.headline)),
          ],
        ),
        Column(
//          mainAxisSize: MainAxisSize.min,
//          mainAxisAlignment: MainAxisAlignment.end,
//          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CounterActionButton(
                onPressed: onDecrementCounter,
                iconType: new Icon(
                  Icons.thumb_down,
                  color: Colors.red,
                  size: 18.0,
                ),
                counterNo: new Text('$_decCounter',
                    style: Theme.of(context).textTheme.headline)),
          ],
        ),
      ],
    );
  }
}
