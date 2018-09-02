import 'package:cloud_firestore/cloud_firestore.dart';

class PollItem {
  String pollId;
  String documentId;
  String name;
  int inc = 0;
  int dec = 0;
  DocumentSnapshot docSnapshot;
  PollItem(this.pollId, this.documentId, this.name, this.inc, this.dec,
      this.docSnapshot);
}

class Polls {
  String pollId;
//List<PollItem> lstPollItems;
//  String id;
  String name;
  String category;
//  String subCategory;
//  String createdBy;
//  DateTime createdOn;
  String image;
  Polls(this.pollId, this.name, this.category, this.image);

  List<Polls> lstPolls = [
    Polls("1", "Mars", "Milkyway Galaxy", "assets/img/mars.png"),
    Polls("2", "Neptune", "Milkyway Galaxy", "assets/img/neptune.png"),
    Polls("3", "Moon", "Milkyway Galaxy", "assets/img/moon.png"),
    Polls("4", "Earth", "Milkyway Galaxy", "assets/img/earth.png"),
  ];
}
