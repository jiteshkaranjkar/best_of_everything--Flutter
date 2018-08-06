import 'dart:async';

import 'package:boe/add_poll_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class CrudSample extends StatefulWidget {
  @override
  CrudSampleState createState() {
    return new CrudSampleState();
  }
}

class CrudSampleState extends State<CrudSample> {
  String addItemvalue;
  StreamSubscription<DocumentSnapshot> subscription;
  final TextEditingController _textItemAdd =
      new TextEditingController(text: "Add and item");

  final DocumentReference documentReference =
      Firestore.instance.collection('Polls').document('Camera');
//Firestore.instance.document("Polls/MorningDrink");

  _handleSubmitted(String txtInput) {
    _textItemAdd.clear();
  }

  void _add() {
    //_fetch();
    print("JK --------------------------Item Adding");
//    Map<String, String> data = <String, String>{
//      "name": "Jitesh K",
//      "desc": "Flutter Developer"
//    };
    documentReference
        .collection('Items')
        .document(addItemvalue)
        .setData({"name": addItemvalue, "inc": 0, "dec": 0}).whenComplete(() {
      print("Item Added");
    }).catchError((e) => print(e));
  }

//  void _delete() {
//    documentReference.delete().whenComplete(() {
//      print("Deleted Successfully");
//      setState(() {});
//    }).catchError((e) => print(e));
//  }

  void _update() {
    Map<String, String> data = <String, String>{
      "name": "Yes Updated",
      "desc": "Hurray  Updated"
    };
    documentReference.updateData(data).whenComplete(() {
      print("Document Updated");
    }).catchError((e) => print(e));
  }

//  void _fetch() {
//    documentReference.get().then((datasnapshot) {
//      if (datasnapshot.exists) {
//        setState(() {
//          addItemvalue = datasnapshot.data['desc'];
//        });
//      }
//    });
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          addItemvalue = datasnapshot.data['desc'];
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Firebase Demo"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _add,
              child: new Text("Add"),
              color: Colors.cyan,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed: _update,
              child: new Text("Update"),
              color: Colors.lightBlue,
            ),
//            new Padding(
//              padding: const EdgeInsets.all(10.0),
//            ),
//            new RaisedButton(
//              onPressed: _delete,
//              child: new Text("Delete"),
//              color: Colors.orange,
//            ),
//            new Padding(
//              padding: const EdgeInsets.all(10.0),
//            ),
//            new RaisedButton(
//              onPressed: _fetch,
//              child: new Text("Fetch"),
//              color: Colors.lime,
//            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
//            addItemvalue == null
//                ? new Container()
//                :
            AddPollItem(handleAdd: _add, addItemName: addItemvalue),
//                : new Text(
//                    myText,
//                    style: new TextStyle(fontSize: 20.0),
//                  )
//                : new TextField(
//                    controller: _textItemAdd,
//                    onChanged: (String value) {
//                      _handleSubmitted(value);
//                    },
//                    onSubmitted: _handleSubmitted,
//                    decoration: InputDecoration(
//                      //border: InputBorder.none,
//                      hintText: 'Add an entry for Poll',
//                    ),
//                    autofocus: false,
//                  ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add a Poll'),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
