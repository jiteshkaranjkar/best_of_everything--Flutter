import 'dart:async';

import 'package:boe/display_poll_items.dart';
import 'package:boe/poll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:boe/pollcard.dart';

//import 'package:boe/poll_list_element.dart';

class PollContainer extends StatefulWidget {
  List<String> lstPollImages;
  List<String> lstDocumentIds;
  List<PollItem> lstPollItems;
  List<Polls> lstPolls;

  PollContainer(
      {Key key,
      this.lstPollImages,
      this.lstDocumentIds,
      //this.lstPollItems,
      this.lstPolls})
      : super(key: key);
  static const String routeName = '/material/search';

  @override
  _PollContainerState createState() => new _PollContainerState();
}

class _PollContainerState extends State<PollContainer> {
  final _SearchBarSearchDelegate _delegate = new _SearchBarSearchDelegate();
//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final pollController = TextEditingController();
  CollectionReference collectionReference;
  String categoryselected;
  List<String> lstPollImages = new List<String>();
  List<String> lstCategory = [
    'Software',
    'Banks',
    'Countries',
    'Holiday places',
    'Movie',
    'Music',
    'Poem',
    'Book',
    'Beverages',
    'Insurance',
    'Suburb',
    'Brand',
    'Laptop',
  ];
  List<String> lstSubCategory = [
    'Software',
    'Mortgage',
    'Countries',
    'Holiday places',
    'Movie',
    'Poem',
    'Book',
    'Beverages',
    'Insurance',
    'Suburb',
    'Brand',
    'Laptop',
  ];
  Polls polls;

  String pollDocumentId;

  int _lastIntegerSelected;

//  _fetchPollImges() async {
//    await Firestore.instance.collection('Polls').getDocuments().then((docs) {
//      docs.documents.forEach((DocumentSnapshot docSnapshot) {
//        if (!lstPollImages.contains(docSnapshot.data['image']))
//          lstPollImages.add(docSnapshot.data['image']);
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background:
                    Image.asset('res/images/HomeImage.jpeg', fit: BoxFit.cover),
              ),
//              leading: new IconButton(
//                tooltip: 'Navigation menu',
//                icon: new AnimatedIcon(
//                  icon: AnimatedIcons.menu_arrow,
//                  size: 20.0,
//                  color: Colors.white,
//                  progress: _delegate.transitionAnimation,
//                ),
//                onPressed: () {
//                  _scaffoldKey.currentState.openDrawer();
//                },
//              ),
              title: const Text(
                'the best of EVERYTHING',
                //style: Theme.of(context).primaryColor.red,
              ),
              actions: <Widget>[
                new IconButton(
                  tooltip: 'Search',
                  icon: const Icon(
                    Icons.search,
                    size: 20.0,
                  ),
                  onPressed: () async {
                    final int selected = await showSearch<int>(
                      context: context,
                      delegate: _delegate,
                    );
                    if (selected != null && selected != _lastIntegerSelected) {
                      setState(() {
                        _lastIntegerSelected = selected;
                      });
                    }
                  },
                ),
                new IconButton(
                  tooltip: 'More (not implemented)',
                  icon: const Icon(
                    Icons.more_vert,
                    size: 18.0,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            new SliverGrid(
              gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250.0,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (context, index) {
                  return new Container(
                    height: 100.0,
                    width: 50.0,
                    alignment: Alignment.center,
                    color: Colors.teal[100 * (index % 9)],
                    child: new Column(
                      children: <Widget>[
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage(widget.lstPollImages[index]),
                              //backgroundColor: Colors.deepOrange,
//                                child: new Text(widget.lstDocumentIds[index]
//                                    .substring(0, 1)),
                            ), //Icon(Icons.album),
                            title: Text(widget.lstDocumentIds[index]),

                            subtitle: Text(widget.lstDocumentIds[index]),
                            onTap: () {
                              //onLongPress: () {
                              Navigator.of(context).push(
                                new PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      new DisplayPollItems(
                                          selectedDocumentId:
                                              widget.lstDocumentIds[index]),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          //child: new Text('grid item $index'),
                          child: new ButtonBar(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, size: 20.0),
                                onPressed: () {},
                              ),
                              IconButton(
                                  icon: Icon(Icons.delete, size: 20.0),
                                  onPressed: () {}),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: widget
                    .lstDocumentIds.length, //widget.lstDocumentIds.length,
              ),
            ),
          ];
        },
        body: Text(""),
//        body: Padding(
//          padding: const EdgeInsets.all(10.0),
//          child: DisplayPolls(
//            //documents: widget.documents,
//            lstDocumentIds: widget.lstDocumentIds,
//          ),
//        ),
      ),

//      body: Padding(
//        padding: const EdgeInsets.all(10.0),
//        child: DisplayPolls(
//          //documents: widget.documents,
//          lstDocumentIds: widget.lstDocumentIds,
//        ),
//      ),
//      drawer: new Drawer(
//        child: new Column(
//          children: <Widget>[
//            const UserAccountsDrawerHeader(
//              accountName: const Text('Zach Widget'),
//              accountEmail: const Text('zach.widget@example.com'),
//              currentAccountPicture: const CircleAvatar(
//                backgroundImage: const AssetImage(
//                  'shrine/vendors/zach.jpg',
//                  package: 'flutter_gallery_assets',
//                ),
//              ),
//              margin: EdgeInsets.zero,
//            ),
//            new MediaQuery.removePadding(
//              context: context,
//              // DrawerHeader consumes top MediaQuery padding.
//              removeTop: true,
//              child: const ListTile(
//                leading: const Icon(Icons.payment),
//                title: const Text('Placeholder'),
//              ),
//            ),
//          ],
//        ),
//      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.add),
        label: const Text('Add Poll'),
        onPressed: () {}, //_showDialog,
      ),

//      bottomNavigationBar: BottomNavigationBar(
////          currentIndex: currentTab,
//        onTap: (int index) {
//          setState(() {
////              currentTab = index;
////              currentPage = pages[index];
//          });
//        },
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.home),
//            title: Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.settings),
//            title: Text("Settings"),
//          ),
//        ],
//      ),
    );
  }

  @override
  void dispose() {
    pollController.dispose();
    super.dispose();
  }

  void _handleSearchBegin() {
//    Map<String, String> mapCounter = <String, String>{"Inc": "2", "Dec": "-5"};
//    Map<String, Map<String, String>> mapPoll = <String, Map<String, String>>{
//      "Shake": mapCounter
//    };
//
//    collectionReference.add(mapPoll).whenComplete(() {
//      print("Poll collectionReference");
//    }).catchError((err) => print("CR Error - $err"));
  }

  @override
  void initState() {
    super.initState();
  }

//  onPollchnaged() {
//    widget.documents.map((DocumentSnapshot docSnapshot) {
//      if (docSnapshot.exists) {
//        widget.lstDocumentIds.add(docSnapshot.documentID);
//      }
//    }).toList();
//  }

  _navigateAndDisplayDropDown(BuildContext context) async {
//    final result = await Navigator.push(
//      context,
//      // We'll create the SelectionScreen in the next step!
//      MaterialPageRoute(
//          builder: (context) => PollDropDown(
//              lstDocumentIds: widget.lstDocumentIds,
//              pollDocumentId: pollDocumentId,
//              docSnapshot: widget.documents,
//              onPressed: onPollchnaged)),
//    );
//
//    print("Result $result");
//    _fetchSelectedPollItems(result);
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Column(
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    controller: pollController,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Add Poll Item', hintText: 'add an Item'),
                  ),
                )
              ],
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: DropdownButton<String>(
                    value: categoryselected,
                    items: lstCategory.map((String value) {
                      return new DropdownMenuItem(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.home),
                            Text(" ${value} ")
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        categoryselected = value;
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                pollController.text = "";
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Add'),
              onPressed: () {
                setState(() {
                  polls = new Polls("", "", "", "");
                  print(
                      "-${pollController.text}----------------- #### -6- #### -------------------");
                });
                onAddPoll();
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  onAddPoll() {
    CollectionReference collReference =
        Firestore.instance.collection(pollController.text);
    CollectionReference pollCollReference =
        Firestore.instance.collection('Polls');

    Firestore.instance.runTransaction((Transaction transaction) async {
      await transaction.set(
          pollCollReference.document(pollController.text.replaceAll(' ', '')), {
        'name': pollController.text,
        'pollId': pollController.text.replaceAll(' ', ''),
        'category': ''
      }).then((doc) {
        showOverlay(context, 'Added', Colors.green);
        print("Poll added ${pollController.text}");
      }).catchError((error) {
        showOverlay(context, '+1', Colors.red);
        print("Poll adding Failed ${error}");
      });

//      await transaction.set(
//          collReference.document(pollController.text), pollController.text)
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
}

class _SearchBarSearchDelegate extends SearchDelegate<int> {
  List<String> history;
  List<String> lstDocumentIds;

  final List<int> _data =
      new List<int>.generate(100001, (int i) => i).reversed.toList();

  @override
  Widget buildLeading(BuildContext context) {
    print("Search Hello");
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 0);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<int> suggestions = query.isEmpty
        ? history
        : _data.where((int i) => '$i'.startsWith(query));

    return new _SuggestionList(
      query: query,
      suggestions: suggestions.map((int i) => '$i').toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final int searched = int.tryParse(query);
    if (searched == null || !_data.contains(searched)) {
      return new Center(
        child: new Text(
          '"$query"\n is not a valid integer between 0 and 100,000.\nTry again.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
        new _ResultCard(
          title: 'This integer',
          integer: searched,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Next integer',
          integer: searched + 1,
          searchDelegate: this,
        ),
        new _ResultCard(
          title: 'Previous integer',
          integer: searched - 1,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.integer, this.title, this.searchDelegate});

  final int integer;
  final String title;
  final SearchDelegate<int> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, integer);
      },
      child: new Card(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Text(title),
              new Text(
                '$integer',
                style: theme.textTheme.headline.copyWith(fontSize: 72.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return new ListTile(
          leading: query.isEmpty
              ? const Icon(Icons.history)
              : const Icon(Icons.history),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
