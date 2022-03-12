import 'package:flutter/material.dart';

class SimpleAlerDialog extends StatefulWidget {
  final String title;
  SimpleAlerDialog({Key key, this.title});

  @override
  State<SimpleAlerDialog> createState() => _SimpleAlerDialogState();
}

class _SimpleAlerDialogState extends State<SimpleAlerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Alert'),
      content: Text(widget.title),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}