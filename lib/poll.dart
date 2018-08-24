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
//  String category;
//  String subCategory;
//  String createdBy;
//  DateTime createdOn;
  Polls(this.pollId, this.name);
}
