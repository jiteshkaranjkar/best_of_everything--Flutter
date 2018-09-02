//import 'package:boe/common/grid_view_cards.dart';
import 'dart:async';

import 'package:boe/poll.dart';
import 'package:boe/poll_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollManager extends StatelessWidget {
  List<String> lstDocumentIds = new List<String>();
  List<Polls> lstPolls = new List<Polls>();
  String pollDocumentId;
  List<PollItem> lstPollItems = new List<PollItem>();
  Map<String, String> mapPollDetails = new Map<String, String>();
  List<String> lstPollImages = new List<String>();

  _fetchPollImages() {
    Firestore.instance.collection('Polls').getDocuments().then((docs) {
      docs.documents.forEach((DocumentSnapshot docSnapshot) {
        if (!lstPollImages.contains(docSnapshot.data['image']))
          lstPollImages.add(docSnapshot.data['image']);
      });
    });
  }

  Future _fetchPolls(List<DocumentSnapshot> lstDocSnapshot) {
    lstDocSnapshot.forEach((DocumentSnapshot docSnapshot) {
      if (!lstDocumentIds.contains(docSnapshot.documentID))
        lstDocumentIds.add(docSnapshot.documentID);
      //lstPolls.add(new Polls(docSnapshot.data["name"], "", "", ""));
    });
  }
//  _fetchPolls() async {
//    print(
//        "------------------------------------------------ JK ONE --------------------------------------------------------------------------------");
//    await Firestore.instance.collection('Polls').getDocuments().then((docs) {
//      print(
//          "------------------------------------------------ JK ONE 1 --------------------------------------------------------------------------------");
//      docs.documents.forEach((DocumentSnapshot docSnapshot) {
//        print(
//            "------------------------------------------------ JK ONE 2 --------------------------------------------------------------------------------");
//        if (docSnapshot.exists) {
//          print(
//              "------------------------------------------------ JK ONE 3 --------------------------------------------------------------------------------");
//          lstDocumentIds.add(docSnapshot.documentID);
//        }
//      });
//    });
//    Polls polls;
//    print(
//        "------------------------------------------------ JK TWO ${lstDocumentIds
//            .length}--------------------------------------------------------------------------------");
//  }
//    lstDocumentIds.forEach((docId) {
//      if (pollDocumentId == null) pollDocumentId = docId;
//      print(
//          "------------------------------------------------ JK THREE --------------------------------------------------------------------------------");
//      Firestore.instance.collection(docId).getDocuments().then((docs) {
//        List<PollItem> pollItems = new List<PollItem>();
//        docs.documents.forEach((DocumentSnapshot docSnapshot) {
//          if (docSnapshot.exists) {
//            pollItems.add(new PollItem(
//                docId,
//                docSnapshot.documentID,
//                docSnapshot.data['name'],
//                docSnapshot.data['inc'],
//                docSnapshot.data['dec'],
//                docSnapshot));
//          }
//        });
//        polls = new Polls(docId, pollItems, docId);
//        if (polls != null) {
//          lstPolls.add(polls);
//          if (lstPollItems.length == 0) {
//            lstPollItems = pollItems;
//          }
//        }
//      });
//    });

//
//  _fetchPollDocuments(List<DocumentSnapshot> documents) async {
////    await Firestore.instance.collection('Polls').getDocuments().then((docs) {
////     docs.documents.forEach((DocumentSnapshot docSnapshot) {
//    documents.forEach((DocumentSnapshot docSnapshot) {
//      if (docSnapshot.exists) {
//        lstDocumentIds.add(docSnapshot.documentID);
//      }
//    });
//    print(
//        "------------------------------------------------ TWO --------------------------------------------------------------------------------");
//    _fetch(documents);
//  }
//
//  _fetch(List<DocumentSnapshot> documents) {
//    Polls polls;
//    if (lstDocumentIds != null) {
//      print(
//          "------------------------------------------------THREE --------------------------------------------------------------------------------");
//      lstDocumentIds.forEach((docId) {
//        if (pollDocumentId == null) pollDocumentId = docId;
//        print(
//            "------------------------------------------------FOUR --------------------------------------------------------------------------------");
////        print(
////            "------------------------------------------------------------- #### Jabsdkjf K 1 #### -------------------${docId}");
////        Firestore.instance.collection(docId).getDocuments().then((docs) {
////          List<PollItem> pollItems = new List<PollItem>();
////          docs.documents.forEach((DocumentSnapshot docSnapshot) {
//        List<PollItem> pollItems = new List<PollItem>();
//        documents.forEach((DocumentSnapshot docSnapshot) {
//          if (docSnapshot.exists) {
////              print("--- #### NJK 0 #### -----${docSnapshot.documentID} ");
////              print("--- #### NJK 3 #### -----${docSnapshot.data['name']} " +
////                  " --- " +
////                  "${docSnapshot.data['inc']} " +
////                  " --- " +
////                  "${docSnapshot.data['dec']} ");
//            pollItems.add(new PollItem(
//                docId,
//                docSnapshot.documentID,
//                docSnapshot.data['name'],
//                docSnapshot.data['inc'],
//                docSnapshot.data['dec'],
//                docSnapshot));
//
////              print(
////                  "--- #### VVK --------- 0 #### -----${pollItems.elementAt(0)} ");
//          }
//        });
//        polls = new Polls(docId, pollItems, docId);
//        if (polls != null) {
//          lstPolls.add(polls);
//          if (lstPollItems.length == 0) {
//            lstPollItems = pollItems;
//          }
//        }
//      });
////      });
//    }
//  }

  Widget build(BuildContext context) {
    _fetchPollImages();
    return new Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance.collection('Polls').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.data.documents != null) {
                _fetchPolls(snapshot.data.documents);
                return PollContainer(
                    lstPollImages: lstPollImages,
                    lstDocumentIds: lstDocumentIds,
                    //lstPollItems: lstPollItems,
                    lstPolls: lstPolls);
              }
            }
          }),
    );
  }
}
