import 'package:flutter/material.dart';
import '../parts/sidemenu.dart';

enum _DialogActionType {
  ok,
  cancel,
}

class Alert extends StatefulWidget {
  @override
  AlertState createState() => AlertState();
}

class AlertState extends State<Alert> {

  void _open(BuildContext context, String message) {
    AlertDialog dialog = AlertDialog(
        title: Text(message),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('ok pressed.'),
              ));
              Navigator.pop(context, _DialogActionType.ok);
            },
            child: const Text('OK'),
          ),
          RaisedButton(
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('cancel pressed.'),
              ));
              Navigator.pop(context, _DialogActionType.cancel);
            },
            child: const Text('Cancel'),
          ),
        ]);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        }).then((value) {
      switch (value) {
        case _DialogActionType.ok:
          print('ok pressed');
          break;
        case _DialogActionType.cancel:
          print('cancel pressed');
          break;
      }
    });

  }

  Widget bulildBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: const Text('Show Alert'),
            onPressed: () {
              _open(context, 'Now loading');
            },
          ),
          RaisedButton(
            child: const Text('Show Snackbar'),
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('hello snackbar.'),
              ));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alert'),
      ),
      body: Builder(
        builder: bulildBody, // builder: for Scaffold.of(context)
      ),
      drawer: SideMenu.drawer(context),
    );
  }
}
