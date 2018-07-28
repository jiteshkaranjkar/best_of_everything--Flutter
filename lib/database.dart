import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_database/firebase_database.dart';

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
  Stream<List<Counter>> countersStream();
}

class PollsFireStore extends StatefulWidget {
  @override
  _PollsFireStoreState createState() => _PollsFireStoreState();
}

class _PollsFireStoreState extends State<PollsFireStore> {
  final DocumentReference documentReference =
      Firestore.instance.document('Polls');
  final CollectionReference collectionReference =
      Firestore.instance.collection('Polls');
  final Stream<QuerySnapshot> streamQuerySnapshot =
      Firestore.instance.collection('Polls').snapshots();

  @override
  Widget build(BuildContext context) {
    Map<int, int> mapCounter = <int, int>{0: 2, 1: 5};
    Map<String, Map<int, int>> mapPoll = <String, Map<int, int>>{
      "Tea": mapCounter
    };

    documentReference.setData(mapPoll).whenComplete(() {
      print("aslkfjas");
    }).catchError((e) => print("Error $e"));
    return Container();
  }
}

//class FireDatabase implements Database {
//  Future<void> addCounter() async {
//    int now = DateTime.now().millisecondsSinceEpoch;
//    Counter counter = new Counter(id: now, value: 0);
//    await setCounter(counter);
//  }
//
//  Future<void> setCounter(Counter counter) async {
//    DatabaseReference databaseReference = _databaseReference(counter);
//    await databaseReference.set(counter.value);
//  }
//
//  Future<void> deleteCounter(Counter counter) async {
//    DatabaseReference databaseReference = _databaseReference(counter);
//    await databaseReference.remove();
//  }
//
//  DatabaseReference _databaseSnapsho(Counter counter) {
//    var path = '$rootPath/${counter.id}';
//    return Firestore.instance.collection('Polls').snapshots();
//  }
//
//  Stream<List<Counter>> countersStream() {
//    return _DatabaseStream<List<Counter>>(
//      apiPath: rootPath,
//      parser: _DatabaseCountersParser(),
//    ).stream;
//  }
//
//  static final String rootPath = 'counters';
//}
//
//class _DatabaseStream<T> {
//  _DatabaseStream({String apiPath, DatabaseNodeParser<T> parser}) {
//    Firestore firestore = Firestore.instance;
//    DatabaseReference databaseReference = firestore.reference().child(apiPath);
//    var eventStream = databaseReference.onValue;
//    stream = eventStream.map((event) => parser.parse(event));
//  }
//
//  Stream<T> stream;
//}
//
//abstract class DatabaseNodeParser<T> {
//  T parse(Event event);
//}
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
