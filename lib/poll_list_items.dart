//import 'package:boe/common/counter_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollListItems extends StatefulWidget {
  List<DocumentSnapshot> documents;
  List<String> lstDocumentIds;
  String selectedDocumentId;

  PollListItems(
      {Key key, this.selectedDocumentId}) //this.documents, this.lstPollItems})
      : super(key: key) {}

  @override
  PollListItemsState createState() => PollListItemsState();
}

class PollListItemsState extends State<PollListItems> {
  String myText;
  CollectionReference collectionReference;
  int inc;
  int dec;
  String docId;
  bool isOpened = false;
  final pollItemController = TextEditingController(text: "Add poll item");

  onDecrementCounter(DocumentSnapshot docSnapshot, String documentID) {
    print(
        "------------------------------------------------------------- #### JK dec 1#### ------------------${dec} -- ${docId} -- ${documentID}");
    setState(() {
      dec--;
    });
    print(
        "------------------------------------------------------------- #### JK dec 2#### ------------------${dec}-");
    collectionReference =
        Firestore.instance.collection(widget.selectedDocumentId);
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot =
          await transaction.get(collectionReference.document(documentID));
      await transaction.update(snapshot.reference, {'dec': dec});
    });
    print("Decrement counter ${dec}");
  }

  onIncrementCounter(DocumentSnapshot docSnapshot, String documentID) {
    print(
        "------------------------------------------------------------- #### JK inc 1#### ------------------${inc}-");
    setState(() {
      inc++;
    });
    print(
        "------------------------------------------------------------- #### JK inc 2#### ------------------${inc}-- -- ${docId} -- ${documentID}--${widget.selectedDocumentId}");
    collectionReference =
        Firestore.instance.collection(widget.selectedDocumentId);
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot =
          await transaction.get(collectionReference.document(documentID));
      await transaction.update(snapshot.reference, {'inc': inc});
    });
    print("Increment counter ${inc}");
  }

  @override
  Widget build(BuildContext context) {
    print(
        "-----------------${widget.selectedDocumentId}-------------------------------------------- #### Jabsdkjf K 789 #### -------------------");
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text("JKa"),
//      ),
//      body:
    return Row(
      children: <Widget>[
        Flexible(
          flex: 0,
          child:
//        Padding(
//          padding: const EdgeInsets.all(10.0),
              StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection(widget.selectedDocumentId)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Connecting...');
              final int cardLength = snapshot.data.documents.length;
              return new ListView.builder(
                itemCount: cardLength,
                itemBuilder: (context, index) {
                  final DocumentSnapshot docSnapshot =
                      snapshot.data.documents[index];
                  Text(
                    docSnapshot['name'],
                  );
//                  return new ListTile(
//                    leading: Text(
//                      docSnapshot['name'],
//                    ),
//                  trailing: ButtonBar(
//                    children: <Widget>[
//                      Column(
//                        //textDirection: TextDirection.rtl,
//                        children: [
//                          CounterActionButton(
//                              onPressed: () {
//                                setState(() {
//                                  inc =
//                                      int.parse(docSnapshot['inc'].toString());
//                                  docId = docSnapshot['name'];
//                                });
//                                onIncrementCounter(
//                                    docSnapshot, docSnapshot.documentID);
//                              },
//                              iconType: new Icon(
//                                Icons.thumb_up,
//                                color: Colors.white,
//                                size: 18.0,
//                              ),
//                              tag: "Inc",
//                              counterNo: new Text(
//                                  '${docSnapshot['inc'].toString()}',
//                                  style: Theme.of(context).textTheme.headline)),
//                        ],
//                      ),
//                      Column(
//                        children: [
//                          CounterActionButton(
//                              onPressed: () {
//                                setState(() {
//                                  dec =
//                                      int.parse(docSnapshot['dec'].toString());
//                                  docId = docSnapshot['name'];
//                                });
//                                onDecrementCounter(
//                                    docSnapshot, docSnapshot.documentID);
//                              },
//                              iconType: new Icon(
//                                Icons.thumb_down,
//                                color: Colors.red,
//                                size: 18.0,
//                              ),
//                              tag: "Dec",
//                              counterNo: new Text(
//                                  '${docSnapshot['dec'].toString()}',
//                                  style: Theme.of(context).textTheme.headline)),
//                        ],
//                      ),
//                    ],
//                  ),
//                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
