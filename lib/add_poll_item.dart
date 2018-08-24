import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPollItem extends StatefulWidget {
  //final VoidCallback handleAdd;
//  String addItemName;
//  final String pollDocumentId;

  AddPollItem({Key key}) : super(key: key);

  @override
  _AddPollItemState createState() {
    return new _AddPollItemState();
  }
}

enum FormType { addItem, addPoll }

class _AddPollItemState extends State<AddPollItem> {
  final formKey = GlobalKey<FormState>();
  String poll;

  bool validate() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void onAddItem() async {
    try {
      validate();
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('Polls');

        await reference.add({
          "title": poll,
          "name": poll,
          "createdOn": DateTime.now(),
          "createdBy": "JK",
          "category": poll,
          "subcategory": poll,
        });
      });
      setState(() {
        poll = "";
      });
      print('Logged in successfully');
    } catch (err) {
      print('Login falied with error - $err');
    }
  }

  @override
  void initState() {
    poll = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: new Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: [
              TextFormField(
                decoration:
                    new InputDecoration(labelText: 'Add an entry to Poll'),
//                initialValue: "ForgetIt",
                validator: (value) =>
                    value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) {
                  setState(() {
                    poll = value;
                  });
                },
//                onSubmitted: _handleSubmitted,
              ),
            ],
          ),
          Column(
//          textDirection: TextDirection.rtl,
            children: [
              FloatingActionButton(
                onPressed: onAddItem,
                tooltip: 'Increment',
                child: new Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
