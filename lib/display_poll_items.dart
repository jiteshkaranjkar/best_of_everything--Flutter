import 'dart:async';

import 'package:boe/common/counter_button.dart';
import 'package:boe/poll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:boe/poll_list_items.dart';

class DisplayPollItems extends StatefulWidget {
  List<DocumentSnapshot> documents;
  List<String> lstDocumentIds;
  String selectedDocumentId;

  DisplayPollItems(
      {Key key, this.selectedDocumentId}) //this.documents, this.lstPollItems})
      : super(key: key);

  @override
  _DisplayPollItemsState createState() => _DisplayPollItemsState();
}

class _DisplayPollItemsState extends State<DisplayPollItems> {
  String myText;
  StreamSubscription<DocumentSnapshot> subscription;
  Future<List<PollItem>> lstPollItems;
  CollectionReference collectionReference;
  int inc;
  int dec;
  String docId;
  String pollItemName;
  DocumentSnapshot docSnapshot;
  Animation<Color> _animateColor;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  bool isOpened = false;
  final pollItemController = TextEditingController();

  @override
  void dispose() {
    pollItemController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final formKey = GlobalKey<FormState>();

//
//  Future<QuerySnapshot> _fetchPollList() async {
//    return await documentReference.collection('Items').getDocuments();
//  }
//
//  Future<bool> doesNameAlreadyExist(String name) async {
//    final QuerySnapshot result = await documentReference
//        .collection('Items')
//        .where('name', isEqualTo: name)
//        .limit(1)
//        .getDocuments();
//    final List<DocumentSnapshot> documents = result.documents;
//    return documents.length == 1;
//  }
//
//  _fetch() async {
//    await Firestore.instance.collection('Polls').getDocuments().then((docs) {
//      list = docs.documents.map((DocumentSnapshot docSnapshot) {
//        if (docSnapshot.exists) {
////          print(
////              "------------------------------------------------------------- #### JK 1 #### -------------------${docSnapshot.data['title']}");
//          lstDocumentIds.add(docSnapshot.documentID);
////          print(
////              "------------------------------------------------------------- #### JK 2 #### -------------------${docSnapshot.documentID}");
//          return docSnapshot.data;
//          //lstPolls.lstPollItems = new List<PollItem>(docSnapshot.data);
//        } else
//          return null;
//      }).toList();
//    });
//
////    list.forEach((childSnapshot) {
////      List<String> lstDocNames = childSnapshot.keys.toList();
////    });
//
////    documentReference.collection('Items').getDocuments().then((querySnapshot) {
////      if (querySnapshot != null) {
////        list = querySnapshot.documents.map((DocumentSnapshot docSnapshot) {
////          if (docSnapshot.exists)
////            return docSnapshot.data;
////          else
////            return null;
////        }).toList();
////
////        list.forEach((childSnapshot) {
////          List<String> lstKeys = childSnapshot.keys.toList();
////          List<String> lstValue = childSnapshot.values.toList();
////          PollItem pollItem = new PollItem(
////              "0",
////              lstValue[lstKeys.indexOf("name")],
////              int.parse(lstValue[lstKeys.indexOf("inc")]),
////              int.parse(lstValue[lstKeys.indexOf("dec")]));
////          lstPolls.lstPollItems.add(pollItem);
////        });
////      }
////    });
////
////    collectionReference.getDocuments().then((querySnapshot) {
////      if (querySnapshot != null) {
////        list = querySnapshot.documents.map((DocumentSnapshot docSnapshot) {
////          if (docSnapshot.exists)
////            return docSnapshot.data;
////          else
////            return null;
////        }).toList();
////
//////        list.forEach((pollDoc) {
//////          Firestore.instance
//////              .collection(pollDoc)
//////              .getDocuments()
//////              .then((querySnapshot) {
//////            lstPolls.title = "";
//////            querySnapshot.documents.map((DocumentSnapshot docSnapshot) {
//////              foreach(key in docSnapshot.data.keys){
//////                lstPolls.lstPollItems
//////                    .add(key, docSnapshot.data.values[0]);
//////              }
//////            });
//////          });
//////        });
////      }
////    });
//  }

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
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    subscription?.cancel();
//  }
//
//  void _add() {
//    Map<String, String> data = <String, String>{
//      "name": "Jitesh K",
//      "desc": "Flutter Developer"
//    };
//    documentReference.setData(data).whenComplete(() {
//      print("Document Added");
//    }).catchError((e) => print(e));
//  }

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

  onDecrementCounter(DocumentSnapshot docSnapshot, String documentID) {
    setState(() {
      dec--;
    });
    collectionReference =
        Firestore.instance.collection(widget.selectedDocumentId);
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot =
          await transaction.get(collectionReference.document(documentID));
      await transaction.update(snapshot.reference, {'dec': dec}).then((doc) {
        showOverlay(context, '-1', Colors.green);
        print("Decrement counter $dec");
      }).catchError((error) {
        showOverlay(context, '-1', Colors.red);
        print("Decrement Failed $error");
      });
    });
  }

  onIncrementCounter(DocumentSnapshot docSnapshot, String documentID) {
    setState(() {
      inc++;
    });
    collectionReference =
        Firestore.instance.collection(widget.selectedDocumentId);
    Firestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot =
          await transaction.get(collectionReference.document(documentID));
      await transaction.update(snapshot.reference, {'inc': inc}).then((doc) {
        showOverlay(context, '+1', Colors.green);
        print("Increment counter $inc");
      }).catchError((error) {
        showOverlay(context, '+1', Colors.red);
        print("Increment Failed $error");
      });
    });
  }

  onAddPollItem() {
    collectionReference =
        Firestore.instance.collection(widget.selectedDocumentId);
    Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.set(
          collectionReference.document(pollItemName.replaceAll(' ', '')),
          {'name': pollItemName, 'inc': 0, 'dec': 0}).then((doc) {
        showOverlay(context, 'Added', Colors.green);
        print("PollItem added $pollItemName");
      }).catchError((error) {
        showOverlay(context, '+1', Colors.red);
        print("Poll adding Failed $error");
      });
    });
  }

  showOverlay(BuildContext context, String msg, Color color) async {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
              top: 40.0,
              right: 10.0,
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: color,
                foregroundColor: Colors.black,
                child: Text(msg),
              ),
            ));
    overlayState.insert(overlayEntry);

    await Future.delayed(Duration(seconds: 4));

    overlayEntry.remove();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: new AnimatedListState(), duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

//  Widget _getPollItems(BuildContext context, DocumentSnapshot snapshot) {
//    print(
//        "------------------------------------------------------------- #### JK 2 #### -------------------");
////    return ListTile(
////      title: Text(snapshot.data['name']),
////      leading: CircleAvatar(
////          backgroundColor: Colors.deepOrange,
////          child: new Text(snapshot.data['name'].substring(0, 1))),
////      subtitle: Text("Jitesh"),
////      trailing: new ButtonBar(
////        mainAxisSize: MainAxisSize.min,
////        children: [
////          IconButton(
////            icon: Icon(Icons.thumb_up, size: 20.0),
////            onPressed: () {},
////          ),
////          IconButton(
////              icon: Icon(Icons.thumb_down, size: 20.0), onPressed: () {}),
////        ],
////      ),
////    );
////  }
////    return PollElement(
////        pollItem: new PollItem(
////            widget.selectedDocumentId,
////            snapshot.documentID,
////            snapshot.data['name'],
////            snapshot.data['inc'],
////            snapshot.data['dec'],
////            snapshot));
////    return ListTile(
////      leading: CircleAvatar(
////          backgroundColor: Colors.deepOrange,
////          child: new Text(snapshot['name'].substring(0, 1))),
//////      title: Row(
//////        children: [
//////          Expanded(
//////          child: Text(snapshot['name']),),],),
//////
////    );
////      print(
////          "------------------------------------------------------------- #### JK 3 #### -------------------");
////      docs.documents.forEach((DocumentSnapshot docSnapshot) {
////        pollItems = new List<PollItem>();
////        if (docSnapshot.exists) {
////          print(
////              "------------------------------------------------------------- #### JK 4 #### -------------------");
////          pollItems.add(new PollItem(
////              widget.selectedDocumentId,
////              docSnapshot.documentID,
////              docSnapshot.data['name'],
////              docSnapshot.data['inc'],
////              docSnapshot.data['dec'],
////              docSnapshot));
////        }
////      });
////    });
////    print(
////        "------------------------------------------------------------- #### JK 5 #### -------------------");
//  }
  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return new Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget input() {
    return new Container(
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Add',
        child: TextFormField(
          decoration: new InputDecoration(labelText: "Email "),
          validator: (value) =>
              value.isEmpty ? "Email value cannot be empty" : null,
          //onSaved: (value) => _email = value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        "-${widget.selectedDocumentId}----------------- #### -2- #### -------------------");
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[200],
      ),
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(widget.selectedDocumentId),
//          leading: IconButton(
//              icon: Icon(Icons.arrow_back, size: 20.0),
//              onPressed: () {
//                Navigator.of(context).pop();
//              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: StreamBuilder<QuerySnapshot>(
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
//                  return Row(
//                    children: <Widget>[
//                      Column(
//                        textDirection: TextDirection.rtl,
//                        children: [
//                          ButtonBar(
//                            children: <Widget>[
//                              Column(
//                                children: [
//                                  new Text(
//                                    docSnapshot['name'],
//                                  ),
//                                ],
//                              ),
//                              Column(
//                                textDirection: TextDirection.rtl,
//                                children: [
//                                  CounterActionButton(
//                                      onPressed: () {
//                                        setState(() {
//                                          inc = int.parse(
//                                              docSnapshot['inc'].toString());
//                                          docId = docSnapshot['name'];
//                                        });
//                                        onIncrementCounter(docSnapshot,
//                                            docSnapshot.documentID);
//                                      },
//                                      iconType: new Icon(
//                                        Icons.thumb_up,
//                                        color: Colors.white,
//                                        size: 18.0,
//                                      ),
//                                      tag: "Inc",
//                                      counterNo: new Text(
//                                          '${docSnapshot['inc'].toString()}',
//                                          style: Theme
//                                              .of(context)
//                                              .textTheme
//                                              .body1)),
//                                ],
//                              ),
//                              Column(
//                                textDirection: TextDirection.rtl,
//                                children: [
//                                  CounterActionButton(
//                                      onPressed: () {
//                                        setState(() {
//                                          dec = int.parse(
//                                              docSnapshot['dec'].toString());
//                                          docId = docSnapshot['name'];
//                                        });
//                                        onDecrementCounter(docSnapshot,
//                                            docSnapshot.documentID);
//                                      },
//                                      iconType: new Icon(
//                                        Icons.thumb_down,
//                                        color: Colors.red,
//                                        size: 18.0,
//                                      ),
//                                      tag: "Dec",
//                                      counterNo: new Text(
//                                          '${docSnapshot['dec'].toString()}',
//                                          style: Theme
//                                              .of(context)
//                                              .textTheme
//                                              .body1)),
//                                ],
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ],
//                  );
                  return new ListTile(
                    leading: Text(
                      docSnapshot['name'],
                    ),
                    trailing: ButtonBar(
                      children: <Widget>[
                        Column(
                          textDirection: TextDirection.rtl,
                          children: [
                            CounterActionButton(
                                onPressed: () {
                                  setState(() {
                                    inc = int.parse(
                                        docSnapshot['inc'].toString());
                                    docId = docSnapshot['name'];
                                  });
                                  onIncrementCounter(
                                      docSnapshot, docSnapshot.documentID);
                                },
                                iconType: new Icon(
                                  Icons.thumb_up,
                                  color: Colors.white,
                                  size: 15.0,
                                ),
                                tag: "Inc",
                                counterNo: new Text(
                                    '${docSnapshot['inc'].toString()}',
                                    style:
                                        Theme.of(context).textTheme.headline)),
                          ],
                        ),
                        Column(
                          children: [
                            CounterActionButton(
                                onPressed: () {
                                  setState(() {
                                    dec = int.parse(
                                        docSnapshot['dec'].toString());
                                    docId = docSnapshot['name'];
                                  });
                                  onDecrementCounter(
                                      docSnapshot, docSnapshot.documentID);
                                },
                                iconType: new Icon(
                                  Icons.thumb_down,
                                  color: Colors.red,
                                  size: 15.0,
                                ),
                                tag: "Dec",
                                counterNo: new Text(
                                    '${docSnapshot['dec'].toString()}',
                                    style:
                                        Theme.of(context).textTheme.headline)),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete, size: 20.0),
                              onPressed: () {
                                DocumentReference docReference = Firestore
                                    .instance
                                    .collection(widget.selectedDocumentId)
                                    .document(docSnapshot.documentID);
                                Firestore.instance.runTransaction(
                                    (Transaction transaction) async {
                                  await transaction
                                      .delete(docReference)
                                      .then((doc) {})
                                      .catchError((onError) {
                                    print(
                                        "-${docReference.toString()}----------------- #### -Error - #### -------------------");
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 4.0,
          icon: const Icon(Icons.add),
          label: const Text('Add item'),
          onPressed: _showDialog,
        ),
//        floatingActionButton: FloatingActionButton(
//          backgroundColor: _animateColor.value,
//          //onPressed: animate,
//          onPressed: _showDialog,
//          tooltip: 'Toggle',
////          child: TextField(
////            controller: pollItemController,
////          ),
////          child: FancyFab(onPressed: () {}, tooltip: ""),
//          child: AnimatedIcon(
//            icon: AnimatedIcons.menu_close,
//            progress: _animateIcon,
//          ),
//        ),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: pollItemController,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Add Poll Item',
                    hintText: 'eg. your Favourite gadget'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                pollItemController.text = "";
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  pollItemName = pollItemController.text;
                  print(
                      "-${pollItemController.text}----------------- #### -6- #### -------------------");
                });
                onAddPollItem();
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
