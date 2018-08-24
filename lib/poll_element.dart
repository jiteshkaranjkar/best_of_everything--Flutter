import 'package:boe/common/counter_button.dart';
import 'package:boe/poll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollElement extends StatefulWidget {
  PollItem pollItem;
  PollElement({Key key, this.pollItem}) : super(key: key) {
    print(
        "------------------------------------------------------------- #### AJK Poll Item 1 #### -------------------");
  }
  @override
  _MyPollElement createState() => new _MyPollElement();
}

class _MyPollElement extends State<PollElement> {
  String pollDocumentId;
  CollectionReference collectionReference;

  _MyPollElement() {
    print(
        "------------------------------------------------------------- #### AJK Poll Item 111 #### -------------------");
  }
  @override
  void initState() {
    print(
        "------------------------------------------------------------- #### AJK Poll Item 2 #### -------------------");
    collectionReference = Firestore.instance.collection(widget.pollItem.pollId);
    super.initState();
  }

  void updatePoll() {
    print(
        "-----------------------------------------------------------------JK 1-----------------------------------------------------------------------");
    final TransactionHandler updateTransaction = (Transaction tranx) async {
      final DocumentSnapshot doc = await tranx
          .get(collectionReference.document(widget.pollItem.documentId));

      print(
          "-----------------------------------------------------------------JK 2-----------------------------------------------------------------------");
      await tranx.update(doc.reference, <String, dynamic>{
        "name": widget.pollItem.name,
        "inc": widget.pollItem.inc,
        "dec": widget.pollItem.dec
      });
      print(
          "-----------------------------------------------------------------JK 3-----------------------------------------------------------------------");
//      .then((value) {
//      print("Item counter updated");
//      }).whenComplete(() {
//      print("Item counter updated");
//      }).catchError((e) => print(e))
    };

//    print(widget.pollItem.name);
//    collectionReference.document(widget.pollItem.documentId).setData({
//      "name": widget.pollItem.name,
//      "inc": widget.pollItem.inc,
//      "dec": widget.pollItem.dec
//    }).whenComplete(() {
//      print("Item counter updated");
//    }).catchError((e) => print(e));
  }

  onDecrementCounter() {
    setState(() {
      widget.pollItem.dec--;
    });
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction
          .get(collectionReference.document(widget.pollItem.documentId));
      await transaction
          .update(snapshot.reference, {'dec': snapshot['dec'] - 1});
    });
    print("Decrement counter ${widget.pollItem.dec}");
  }

  onIncrementCounter() {
    setState(() {
      widget.pollItem.inc++;
    });
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction
          .get(collectionReference.document(widget.pollItem.documentId));
      await transaction
          .update(snapshot.reference, {'inc': snapshot['inc'] + 1});
    });
    //updatePoll();
    print("Decrement counter $widget.pollItem.inc");
  }

  @override
  Widget build(BuildContext context) {
    print(
        "------------------------------------------------------------- #### AJK Poll Item 3 #### -------------------");
    return Row(
      children: <Widget>[
        Column(
          children: [
            new Text(
              widget.pollItem.name,
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.0),
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
                tag: "Inc",
                counterNo: new Text('${widget.pollItem.inc}',
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
                tag: "Dec",
                counterNo: new Text('${widget.pollItem.dec}',
                    style: Theme.of(context).textTheme.headline)),
          ],
        ),
      ],
    );
  }
}
