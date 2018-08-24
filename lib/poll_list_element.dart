import 'package:flutter/material.dart';

class PollListElement extends StatefulWidget {
  List<String> lstDocuments;
  String addItemName;
  String pollDocumentId;
  PollListElement({Key key, this.pollDocumentId}) : super(key: key);
  @override
  _PollListElementState createState() => new _PollListElementState();
}

class _PollListElementState extends State<PollListElement> {
  @override
  Widget build(BuildContext context) {
//    print(
    return Row(
      children: <Widget>[
        Column(
          children: [
            Text(widget.pollDocumentId),
//            widget.pollDocumentId != null
//                ? new Text(widget.pollDocumentId)
//                : new Text("Jitesh"),
          ],
        ),
      ],
    );
  }
}
//    return ListView.builder(
//      //itemCount: widget.documents.length,
//      itemExtent: 110.0,
//      itemBuilder: (BuildContext context, int index) {
//        String title = widget.lstDocuments[index].toString();
//        int score = 0; //widget.lstDocuments[index].data['inc'];
//        return ListTile(
//          title: Container(
//            decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(5.0),
//              border: Border.all(color: Colors.white),
//            ),
//            child: !widget.lstDocuments[index].isEmpty
//                ? Text(title)
//                : TextFormField(
//                    initialValue: title,
//                  ),
//          ),
//        );
//            padding: EdgeInsets.all(5.0),
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: !widget.lstDocuments[index].isEmpty
//                      ? Text(title)
//                      : TextFormField(
//                          initialValue: title,
//                        ),
////                            onFieldSubmitted: (String item) {
////                              Firestore.instance
////                                  .runTransaction((transaction) async {
////                                DocumentSnapshot snapshot = await transaction
////                                    .get(widget.lstDocuments[index].reference);
////
////                                await transaction.update(
////                                    snapshot.reference, {'title': item});
////
////                                await transaction.update(snapshot.reference,
////                                    {"editing": !snapshot['editing']});
////                              });
////                            },
////                        ),
//                ),
//                Text("$score"),
//                Column(
//                  children: <Widget>[
//                    IconButton(
//                      onPressed: () {},
////                          Firestore.instance
////                              .runTransaction((Transaction transaction) async {
////                            DocumentSnapshot snapshot = await transaction
////                                .get(widget.lstDocuments[index].reference);
////                            await transaction.update(snapshot.reference,
////                                {'inc': snapshot['inc'] + 1});
////                          });
////                        },
//                      icon: Icon(Icons.arrow_upward),
//                    ),
//                    IconButton(
//                      onPressed: () {},
////                          Firestore.instance
////                              .runTransaction((Transaction transaction) async {
////                            DocumentSnapshot snapshot = await transaction
////                                .get(widget.lstDocuments[index].reference);
////                            await transaction.update(snapshot.reference,
////                                {'inc': snapshot['inc'] - 1});
////                          });
////                        },
//                      icon: Icon(Icons.arrow_downward),
//                    ),
//                  ],
//                ),
//                IconButton(
//                  icon: Icon(Icons.delete),
//                  onPressed: () {},
////                    onPressed: () {
////                      Firestore.instance.runTransaction((transaction) async {
////                        DocumentSnapshot snapshot = await transaction
////                            .get(widget.lstDocuments[index].reference);
////                        await transaction.delete(snapshot.reference);
////                      });
////                    },
//                )
//              ],
//            ),
//          ),
////          onTap: () => Firestore.instance
////                  .runTransaction((Transaction transaction) async {
////                DocumentSnapshot snapshot =
////                    await transaction.get(widget.lstDocuments[index].reference);
////
////                await transaction.update(
////                    snapshot.reference, {"editing": !snapshot["editing"]});
////              }),
//        );
