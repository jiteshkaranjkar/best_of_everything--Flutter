//import 'package:boe/display_poll_items.dart';
import 'package:boe/display_polls.dart';
import 'package:boe/poll.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'package:boe/poll_list_element.dart';

class PollContainer extends StatefulWidget {
  List<DocumentSnapshot> documents;
  List<String> lstDocumentIds;
  List<PollItem> lstPollItems;
  List<Polls> lstPolls;

  PollContainer(
      {Key key,
      //this.documents,
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String pollDocumentId;

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

  onPollchnaged() {
    widget.documents.map((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        widget.lstDocumentIds.add(docSnapshot.documentID);
      }
    }).toList();
  }

//  _fetch() {
////    widget.documents.map((DocumentSnapshot docSnapshot) {
////      if (docSnapshot.exists) {
////        widget.lstDocumentIds.add(docSnapshot.documentID);
////      }
////    }).toList();
////    widget.lstDocumentIds.removeAt(1);
////    widget.lstDocumentIds.removeAt(1);
////    widget.lstDocumentIds.removeAt(1);
////    widget.lstDocumentIds.removeAt(1);
//    Polls polls;
//    if (widget.lstDocumentIds != null) {
//      widget.lstDocumentIds.forEach((docId) {
//        if (pollDocumentId == null) pollDocumentId = docId;
////        print(
////            "------------------------------------------------------------- #### Jabsdkjf K 1 #### -------------------${docId}");
//        Firestore.instance.collection(docId).getDocuments().then((docs) {
//          lstPollItems = new List<PollItem>();
//          docs.documents.forEach((DocumentSnapshot docSnapshot) {
//            if (docSnapshot.exists) {
////              print("--- #### NJK 0 #### -----${docSnapshot.documentID} ");
////              print("--- #### NJK 3 #### -----${docSnapshot.data['name']} " +
////                  " --- " +
////                  "${docSnapshot.data['inc']} " +
////                  " --- " +
////                  "${docSnapshot.data['dec']} ");
//              lstPollItems.add(new PollItem(
//                  docId,
//                  docSnapshot.documentID,
//                  docSnapshot.data['name'],
//                  docSnapshot.data['inc'],
//                  docSnapshot.data['dec'],
//                  docSnapshot));
//
//              polls =
//                  new Polls(docId, docSnapshot.documentID, lstPollItems, docId);
//            }
//          });
//        });
//        lstPolls.add(polls);
//      });
//    }
////    else
////      print(
////          "------------------------------------------------------------- ------------------------------------------------------------- #### NULL #### -------------------------------------------------------------------------------- ");
//  }
//  _fetchSelectedPollItems(String selectedPoll) {
//    print(
//        "------------------------------------------------------------- #### Jabsdkjf K 1 #### -------------------${selectedPoll}");
//    Polls polls;
//    Firestore.instance.collection(selectedPoll).getDocuments().then((docs) {
//      docs.documents.forEach((DocumentSnapshot docSnapshot) {
//        if (docSnapshot.exists) {
//          print("--- #### JVK 0 #### -----${docSnapshot.documentID} ");
//          print("--- #### JVK 3 #### -----${docSnapshot.data['name']} " +
//              " --- " +
//              "${docSnapshot.data['inc']} " +
//              " --- " +
//              "${docSnapshot.data['dec']} ");
//          widget.lstPollItems.add(new PollItem(
//              selectedPoll,
//              docSnapshot.documentID,
//              docSnapshot.data['name'],
//              docSnapshot.data['inc'],
//              docSnapshot.data['dec'],
//              docSnapshot));
//
//          polls = new Polls(selectedPoll, lstPollItems, selectedPoll);
//        }
//      });
//    });
//    lstPolls.add(polls);
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

  int _lastIntegerSelected;

  @override
  Widget build(BuildContext context) {
//    print(
//        "------------------------------------------------------------- #### Jabsdkjf K 123 #### -------------------${widget.lstPolls.elementAt(0).name}");
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          tooltip: 'Navigation menu',
          icon: new AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            size: 20.0,
            color: Colors.white,
            progress: _delegate.transitionAnimation,
          ),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: const Text('Best of Everything'),
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
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 18.0,
            ),
            onPressed: _handleSearchBegin,
            tooltip: 'Search',
          ),
          IconButton(
            tooltip: 'More (not implemented)',
            icon: const Icon(
              Icons.more_vert,
              size: 18.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
//        child: new Column(
//          children: widget.lstPolls
//              .map((doc) => PollListElement(pollDocumentId: doc.name))
//              .toList(),
//        ),

        child: DisplayPolls(
          //documents: widget.documents,
          lstDocumentIds: widget.lstDocumentIds,
        ),
//        child: DisplayPollItems(
//            documents: widget.documents,
//            lstDocumentIds: widget.lstDocumentIds,
//            lstPollItems: widget.lstPollItems),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: const Text('Zach Widget'),
              accountEmail: const Text('zach.widget@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: const AssetImage(
                  'shrine/vendors/zach.jpg',
                  package: 'flutter_gallery_assets',
                ),
              ),
              margin: EdgeInsets.zero,
            ),
            new MediaQuery.removePadding(
              context: context,
              // DrawerHeader consumes top MediaQuery padding.
              removeTop: true,
              child: const ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Placeholder'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
//            _navigateAndDisplayDropDown(context),
//            PollDropDown(
//                lstDocumentIds: widget.lstDocumentIds,
//                pollDocumentId: pollDocumentId,
//                docSnapshot: widget.documents,
//                onPressed: onPollchnaged),
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
    );
  }
}

class _SearchBarSearchDelegate extends SearchDelegate<int> {
  final List<int> _data =
      new List<int>.generate(100001, (int i) => i).reversed.toList();
  final List<int> _history = <int>[42607, 85604, 66374, 44, 174];

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
        ? _history
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
