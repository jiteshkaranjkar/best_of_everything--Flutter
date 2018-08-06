import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Counter {
  Counter({this.name, this.inc, this.dec});
  String name;
  int inc;
  int dec;
}

abstract class Database {
  Future<void> addCounter();
  Future<void> setCounter(Counter counter);
  Future<void> deleteCounter(Counter counter);
  //Stream<List<Counter>> countersStream();
  Stream<QuerySnapshot> pollsStream();
  DocumentReference pollsData();
  CollectionReference _collectionReference(Counter counter);
  String getPollsTitle();
}

class PollsFireStore extends StatefulWidget {
  final String poll;
  PollsFireStore({Key key, this.poll}) : super(key: key);
  @override
  _PollsFireStoreState createState() => _PollsFireStoreState();
}

class _PollsFireStoreState extends State<PollsFireStore> {
  String myText;
//  StreamSubscription<DocumentSnapshot> subscription;

  final DocumentReference documentReference =
      Firestore.instance.document('Polls'); //'Polls/MorningDrink'
  final CollectionReference collectionReference =
      Firestore.instance.collection('Polls');
  final Stream<QuerySnapshot> streamQuerySnapshot =
      Firestore.instance.collection('Polls').snapshots();

  @override
  void initState() {
    print(widget.poll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, int> mapCounter = <int, int>{0: 2, 1: 5};
    Map<String, Map<int, int>> mapPoll = <String, Map<int, int>>{
      "Tea": mapCounter
    };

    documentReference.setData(mapPoll).whenComplete(() {
      print("aslkfjas");
    }).catchError((err) => print("Error $err"));
    return Container();
  }
}

class FireDatabase implements Database {
  DocumentReference documentReference;
  FireDatabase() {
    documentReference = Firestore.instance.document('Polls/MorningDrink');
  }

  Future<void> addCounter() async {
    //int now = DateTime.now().millisecondsSinceEpoch;
    Counter counter = new Counter(name: "PollItem", inc: 0, dec: 0);
    await setCounter(counter);
  }

  Future<void> setCounter(Counter counter) async {
    CollectionReference collectionReference = _collectionReference(counter);
    //await collectionReference.set(counter.value);
  }

  Future<void> deleteCounter(Counter counter) async {
    CollectionReference collectionReference = _collectionReference(counter);
//    await collectionReference.remove();
  }

  CollectionReference _collectionReference(Counter counter) {
    //var path = '$rootPath/${counter.id}';
    return Firestore.instance.collection('Polls'); // .snapshots();
  }

  Stream<QuerySnapshot> pollsStream() {
    return Firestore.instance.collection('Polls').snapshots();
  }

  String getPollsTitle() {
    documentReference.get().then((dataSnapshot) {
      if (dataSnapshot.exists) {
        return dataSnapshot.data['title'];
      } else {
        return "No Data Found";
      }
    });
    return "";
  }

  DocumentReference pollsData() {
    return Firestore.instance.collection('Polls').document('MorningDrink');
  }

//  Stream<List<Counter>> countersStream() {
////    return _DatabaseStream<List<Counter>>(
////      apiPath: rootPath,
////      parser: _DatabaseCountersParser(),
////    ).stream;
//  }

  static final String rootPath = 'counters';
}
//
//class _DatabaseStream<T> {
//  _DatabaseStream({String apiPath, DatabaseNodeParser<T> parser}) {
//    Firestore firestoreInstance = Firestore.instance;
//    CollectionReference collectionReference =
//        firestoreInstance.collection('Polls');
//    var eventStream = collectionReference.snapshots();
//    stream = eventStream.map((event) => parser.parse(eventStream));
//  }
//
//  Stream<T> stream;
//}

abstract class DatabaseNodeParser<T> {
  T parse(Event event);
}
//
//class _DatabaseCountersParser implements DatabaseNodeParser<List<Counter>> {
//  List<Counter> parse(Event event) {
//    Map<dynamic, dynamic> values = event.snapshot.value;
//    if (values != null) {
//      Iterable<String> keys = values.keys.cast<String>();
//
//      var counters = keys
//          .map((key) => Counter(id: int.parse(key), value: values[key]))
//          .toList();
//      counters.sort((lhs, rhs) => rhs.id.compareTo(lhs.id));
//      return counters;
//    } else {
//      return [];
//    }
//  }
//}
