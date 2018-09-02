import 'package:boe/display_poll_items.dart';
import 'package:boe/poll.dart';
import 'package:flutter/material.dart';

//import 'package:boe/poll_element.dart';

class DisplayPolls extends StatelessWidget {
  List<String> lstDocumentIds;
  List<Polls> lstPolls;

  DisplayPolls({Key key, this.lstDocumentIds, this.lstPolls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Column(
        children: <Widget>[
          Expanded(
            child: createChildrenListView(context),
          ),
        ],
      ),
    );
  }

  List<Text> createChildrenTexts(BuildContext context) {
    List<Text> childrenTexts = List<Text>();
    for (String pollId in lstDocumentIds) {
      childrenTexts.add(new Text(
        pollId,
        style: TextStyle(fontSize: 32.0, color: Colors.deepOrange),
      ));
    }
    return childrenTexts;
  }

  ListView createChildrenListView(BuildContext context) {
    return new ListView(
        padding: kMaterialListPadding,
        children: lstPolls != null
            ? lstPolls.map((Polls poll) {
                return new ListTile(
                    title: new Text(poll.name),
                    leading: new Text('${poll.pollId}'),
                    subtitle: new Text(poll.name));
              }).toList()
            : lstDocumentIds.map((String poll) {
                return ListTile(
                  title: Text(poll),
                  leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange,
                      child: new Text(poll.substring(0, 1))),
                  subtitle: Text(poll),
                  trailing: new ButtonBar(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, size: 20.0),
                        onPressed: () {},
                      ),
                      IconButton(
                          icon: Icon(Icons.delete, size: 20.0), onPressed: () {}
//                          Firestore.instance
//                              .runTransaction((transaction) async {
//                            DocumentSnapshot snapshot = await transaction
//                                .set(new DocumentRefere(poll).reference);
//                            await transaction.delete(snapshot.reference);
//                          });
//                        },
                          ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      new PageRouteBuilder(
                        pageBuilder: (context, __, ___) =>
                            DisplayPollItems(selectedDocumentId: poll),
                        maintainState: true,
                      ),
                    );
                  },
                );
              }).toList());
  }
}
