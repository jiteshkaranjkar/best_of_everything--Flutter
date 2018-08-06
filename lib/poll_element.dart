import 'package:boe/common/counter_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollElement extends StatefulWidget {
  final String poll;
  int inc;
  int dec;
  String addItemName;
  String pollDocumentId;
  PollElement({Key key, this.poll, this.inc, this.dec, this.pollDocumentId})
      : super(key: key);
  @override
  _MyPollElement createState() => new _MyPollElement();
}

class _MyPollElement extends State<PollElement> {
  int _incCounter = 0;
  int _decCounter = 0;
  String pollDocumentId;

  final CollectionReference collectionReference =
      Firestore.instance.collection('Polls');

  void updatePoll() {
    pollDocumentId = widget.pollDocumentId;
    print(widget.poll);
    collectionReference
        .document(widget.pollDocumentId)
        .collection('Items')
        .document(widget.poll)
        .setData({
      "name": widget.poll,
      "inc": _incCounter,
      "dec": _decCounter
    }).whenComplete(() {
      print("Item counter updated");
    }).catchError((e) => print(e));
  }

  onDecrementCounter() {
    setState(() {
      _decCounter--;
    });
    updatePoll();
    print("Decrement counter $_decCounter");
  }

  onIncrementCounter() {
    setState(() {
      _incCounter++;
    });
    updatePoll();
    print("Decrement counter $_decCounter");
  }

  @override
  Widget build(BuildContext context) {
    _incCounter = widget.inc;
    _decCounter = widget.dec;
    return Row(
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
          textDirection: TextDirection.rtl,
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
