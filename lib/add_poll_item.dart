import 'package:flutter/material.dart';

class AddPollItem extends StatefulWidget {
  final VoidCallback handleAdd;
  String addItemName;
  final String pollDocumentId;

  AddPollItem({Key key, this.handleAdd, this.addItemName, this.pollDocumentId})
      : super(key: key);

  @override
  _AddPollItemState createState() {
    return new _AddPollItemState();
  }
}

enum FormType { addItem, addPoll }

class _AddPollItemState extends State<AddPollItem> {
  final formKey = GlobalKey<FormState>();
//  String _message = "Hello World";
  FormType _formType = FormType.addItem;
//  final TextEditingController _textItemAdd =
//      new TextEditingController(text: "Add a item");

  bool loginSuccess() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid, Item : $widget.addItemName");
      return true;
    }
    return false;
  }

  void onAddItem() async {
    if (loginSuccess()) {
      try {
        if (_formType == FormType.addItem) {
          print("JK trying to Login --------------------$widget.addItemName ");
//          String userId =
//              await widget.auth.signInWithEmailAndPassword(_email, _password);
//          print('$userId: Logged in successfully');
//          _message = '$userId: Logged in successfully';
        }
        widget.handleAdd();
        print("Yeppee Registered!");
      } catch (err) {
//        _message = 'Error - $err';
        print('Login falied with error - $err');
      }
    }
  }

  @override
  void initState() {
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
                initialValue: "ForgetIt",
                validator: (value) =>
                    value.isEmpty ? 'Please enter some text' : null,
                onSaved: (value) => widget.addItemName = value,
//                onSubmitted: _handleSubmitted,
                //autofocus: true,
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
