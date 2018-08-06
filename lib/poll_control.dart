import 'dart:async';

import 'package:boe/add_poll_item.dart';
import 'package:boe/database.dart';
import 'package:boe/poll.dart';
import 'package:boe/poll_element.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollControl extends StatefulWidget {
  @override
  _PollControlState createState() => _PollControlState();
}

class _PollControlState extends State<PollControl> {
  String myText;
  String name;
  int inc;
  int dec;
  Polls lstPolls;
  Future<QuerySnapshot> pollList;
  StreamSubscription<DocumentSnapshot> subscription;
  final String pollDocumentId = 'Beverages';
  List<Map<dynamic, dynamic>> list;

  final formKey = GlobalKey<FormState>();

  final Database firestoreDatabase = FireDatabase();
  final PollsFireStore pollsFireStore = PollsFireStore();

  final DocumentReference documentReference =
      Firestore.instance.collection('Polls').document('Beverages');

//  final TextEditingController _textItemAdd =
//      new TextEditingController(text: "Add and item");
  final List<String> strList = [
    "Tea",
    "Coffee",
    "Juice",
//    "Shake",
//    "Milk",
//    "Water"
  ];

  Future<QuerySnapshot> _fetchPollList() async {
    return await documentReference.collection('Items').getDocuments();
  }

  Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await documentReference
        .collection('Items')
        .where('name', isEqualTo: name)
        .limit(1)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    return documents.length == 1;
  }

  _fetch() {
    documentReference.collection('Items').getDocuments().then((querySnapshot) {
      if (querySnapshot != null) {
        list = querySnapshot.documents.map((DocumentSnapshot docSnapshot) {
          if (docSnapshot.exists)
            return docSnapshot.data;
          else
            return null;
        }).toList();

        list.forEach((childSnapshot) {
          List<String> lstKeys = childSnapshot.keys.toList();
          List<String> lstValue = childSnapshot.values.toList();
          PollItem pollItem = new PollItem(
              "0",
              lstValue[lstKeys.indexOf("name")],
              int.parse(lstValue[lstKeys.indexOf("inc")]),
              int.parse(lstValue[lstKeys.indexOf("dec")]));
          lstPolls.lstPollItems.add(pollItem);
        });
      }
    });
  }
  //lstPolls.add({"name": item.name, "inc": item.inc, "dec": item.dec});
//    documentReference.get().then((datasnapshot) {
//      if (datasnapshot.exists) {
//        datasnapshot.data.entries documentID .data.entries
//        Map<dynamic, dynamic> values = datasnapshot.data;
//        if (values != null) {
//          Iterable<String> keys = values.keys.cast<String>();
//
////          var counters = keys
////              .map((key) => Counter(id: int.parse(key), value: values[key]))
////              .toList();
////          counters.sort((lhs, rhs) => rhs.id.compareTo(lhs.id));
////          return counters;
////        } else {
////          return [];
//        }
//
//        setState(() {
//          myText = datasnapshot.data['desc'];
//        });
//      }
//    });

  @override
  void initState() {
    _fetch();
    super.initState();
//    pollList = _fetchPollList();
//    //_fetch(pollList);
//    subscription = documentReference.snapshots().listen((datasnapshot) {
//      if (datasnapshot.exists) {
//        setState(() {
//          myText = datasnapshot.data['desc'];
//        });
//      }
//    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  void _add() {
    Map<String, String> data = <String, String>{
      "name": "Jitesh K",
      "desc": "Flutter Developer"
    };
    documentReference.setData(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }

//  void _delete() {
//    documentReference.delete().whenComplete(() {
//      print("Deleted Successfully");
//      setState(() {});
//    }).catchError((e) => print(e));
//  }
//
//  void _update() {
//    Map<String, String> data = <String, String>{
//      "name": "Yes Updated",
//      "desc": "Hurray  Updated"
//    };
//    documentReference.updateData(data).whenComplete(() {
//      print("Document Updated");
//    }).catchError((e) => print(e));
//  }

//  _handleSubmitted(String txtInput) {
//    _textItemAdd.clear();
//  }
//
//  _handlePressed() {
//    _textItemAdd.clear();
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Form(
        key: formKey,
        child: new Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: lstPolls.lstPollItems
                      .map(
                        (item) => PollElement(
                            poll: item.name,
                            inc: item.inc,
                            dec: item.dec,
                            pollDocumentId: pollDocumentId
                            //key: item.l, //Key('counter-${counter.id}'),
                            ),
                      )
                      .toList(),
                ),
              ],
            ),
            AddPollItem(
                handleAdd: _add,
                addItemName: myText,
                pollDocumentId: pollDocumentId),
          ],
        ),
      ),
    );

//      child: new Form(
//        key: formKey,
//        child: new Column(
//          children: <Widget>[
////            Row(
////              children: <Widget>[
////                Column(
////                    crossAxisAlignment: CrossAxisAlignment.start,
////                    children: strList
////                        .map((item) => PollElement(
////                              poll: item,
////                              //key: item.l, //Key('counter-${counter.id}'),
////                            ))
////                        .toList()),
////              ],
////            ),
//            new Row(
//              //mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                new TextFormField(
//                  decoration: new InputDecoration(labelText: "Email "),
//                  validator: (value) =>
//                      value.isEmpty ? "Email value cannot be empty" : null,
//                  //onSaved: (value) => _email = value,
//                ),
//              ],
////              textDirection: TextDirection.rtl,
////              children: <Widget>[
////                Column(
////                  crossAxisAlignment: CrossAxisAlignment.end,
////                  children: [
////                    FloatingActionButton(
////                      onPressed: _addItem,
////                      tooltip: 'Increment',
////                      child: new Icon(Icons.add),
////                    ),
////                  ],
////                ),
//////                Column(
//////                  crossAxisAlignment: CrossAxisAlignment.end,
//////                  children: [
//////                    new ListTile(
//////                      leading: const Icon(Icons.add),
//////                      title: new TextField(
//////                        decoration: new InputDecoration(
//////                          hintText: "Name",
//////                        ),
//////                      ),
//////                    ),
//////                  ],
//////                ),
////                Column(
////                  children: [
////                    Expanded(
////                      child: TextField(
////                        controller: _textItemAdd,
////                        onChanged: (String value) {
////                          _handleSubmitted(value);
////                        },
////                        onSubmitted: _handleSubmitted,
////                        decoration: InputDecoration(
////                          labelText: "skdjfgn;akjfn ;n ",
////                          //border: InputBorder.none,
////                          hintText: 'Add an entry for Poll',
////                        ),
////                        autofocus: false,
////                      ),
////                    ),
////                  ],
////                ),
////                Column(
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: [
//////                    TextFormField(
//////                      decoration: InputDecoration(
//////                        labelText: "Email ",
//////                        hintText: 'Add an entry for Poll',
//////                      ),
//////                      validator: (value) =>
//////                          value.isEmpty ? "Email value cannot be empty" : null,
//////                    ),
////                    new IconButton(
////                        icon: new Icon(Icons.gif), onPressed: _handlePressed),
////                    new Flexible(
////                      child: new TextField(
////                        controller: _textItemAdd,
////                        autocorrect: false,
////                        decoration: new InputDecoration(
////                            labelText: "Let's Talk ... ",
////                            labelStyle:
////                                new TextStyle(fontWeight: FontWeight.bold)),
////                        onChanged: (str) {
////                          setState(() {
////                            str = _textItemAdd.text;
////                          });
////                        },
////                      ),
////                    ),
////                  ],
////                ),
////              ],
//            ),
//          ],
//        ),
//      ),

//    return new Container(
//      color: Colors.grey[100],
//      child: Column(
//        children: <Widget>[
//          Row(
//            children: <Widget>[
//              Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: strList
//                      .map((item) => PollElement(
//                            poll: item,
//                            //key: item.l, //Key('counter-${counter.id}'),
//                          ))
//                      .toList()),
//            ],
//          ),
//          Row(
//            textDirection: TextDirection.rtl,
//            children: <Widget>[
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.end,
//                children: [
//                  FloatingActionButton(
//                    onPressed: _addItem,
//                    tooltip: 'Increment',
//                    child: new Icon(Icons.add),
//                  ),
//                ],
//              ),
//              Column(
//                children: [
//                  Expanded(
//                    child: TextField(
//                      controller: _textItemAdd,
//                      onChanged: (String value) {
//                        _handleSubmitted(value);
//                      },
//                      onSubmitted: _handleSubmitted,
//                      decoration: InputDecoration(
//                        //border: InputBorder.none,
//                        hintText: 'Add an entry for Poll',
//                      ),
//                      autofocus: false,
//                    ),
//                  ),
//                ],
//              ),
//              Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: [
//                  new TextFormField(
//                    decoration: new InputDecoration(labelText: "Email "),
//                    validator: (value) =>
//                        value.isEmpty ? "Email value cannot be empty" : null,
//                  ),
//                ],
//              ),
//            ],
//          ),
//        ],
//      ),
//    );
  }
}
