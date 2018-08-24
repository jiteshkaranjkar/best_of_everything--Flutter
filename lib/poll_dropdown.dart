import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PollDropDown extends StatefulWidget {
  final VoidCallback onPressed;
  List<String> lstDocumentIds;
  List<DocumentSnapshot> docSnapshot;

  String pollDocumentId;
  PollDropDown(
      {Key key,
      this.lstDocumentIds,
      this.pollDocumentId,
      this.docSnapshot,
      this.onPressed})
      : super(key: key);

  @override
  _PollDropDownState createState() => _PollDropDownState();
}

class _PollDropDownState extends State<PollDropDown> {
  String _value = null;

  @override
  void initState() {
    _value = widget.pollDocumentId;

    if (widget.docSnapshot != null) {
      widget.docSnapshot.map((DocumentSnapshot docSnapshot) {
        if (docSnapshot.exists) {
          widget.lstDocumentIds.add(docSnapshot.documentID);
        }
      }).toList();
    }
    setState(() {
      _value = widget.lstDocumentIds.elementAt(0);
    });
    super.initState();
  }

  _onChanged(value) {
    setState(() {
      _value = value;
    });
    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.lstDocumentIds == null) return CircularProgressIndicator();
    return Container(
      child: DropdownButton<String>(
        value: _value,
        items: widget.lstDocumentIds.map((String value) {
          return new DropdownMenuItem(
            value: value,
            child: Row(
              children: <Widget>[Icon(Icons.home), Text(" ${value} ")],
            ),
          );
        }).toList(),
        onChanged: (String value) {
          _onChanged(value);
        },
      ),
    );
  }
}
