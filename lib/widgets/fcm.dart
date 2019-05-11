import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../parts/sidemenu.dart';

class Fcm extends StatefulWidget {
  @override
  FcmState createState() => FcmState();
}

class FcmState extends State<Fcm> {
  final _fbm = FirebaseMessaging();
  String _token = 'unknown';
  Map<String, bool> _subscriptions = {
    'all': false,
    'male': false,
    'female': false,
  };

  @override
  void initState() {
    super.initState();

    for (String topic in _subscriptions.keys) {
      _getSubscribe(topic).then((val) {
        setState(() {
          _subscriptions[topic] = val;
        });
      });
    }

    _fbm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onMessage] $message");
        _buildDialog(context, "${message['notification']['title']}", "${message['notification']['body']}");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onLaunch: $message");
        _buildDialog(context, "${message['notification']['title']}", "${message['notification']['body']}");
      },
      onResume: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onResume: $message");
        _buildDialog(context, "${message['notification']['title']}", "${message['notification']['body']}");
      },
    );
    _fbm.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fbm.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
      print("@@@@@@@@@@@@@@@@@ Settings registered: $settings");
    });
    _fbm.getToken().then((String token) {
      print("@@@@@@@@@@@@@@@@@ Push Messaging token: $token");
      setState(() {
        _token = token;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase messaging'),
      ),
      body: _build(context),
      drawer: SideMenu.drawer(context),
    );
  }

  Widget _build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: Text(
                'Token',
                style: TextStyle(fontSize: 20.0, color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(_token),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0),),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
              child: Text(
                'Topics',
                style: TextStyle(fontSize: 20.0, color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
            Card(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildSwitch('all'),
            ),),
            Card(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildSwitch('male'),
            ),),
            Card(child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: _buildSwitch('female'),
            ),),
          ],
        ),
      )
    );
  }

  Widget _buildSwitch(String topic) {
    return Row(
      children: <Widget>[
        Switch(
          onChanged: (bool val) {
            _saveSubscribe(topic, val);
            if (val) {
              _fbm.subscribeToTopic(topic);
              print('subscribed $topic');
            } else {
              _fbm.unsubscribeFromTopic(topic);
              print('unsubscribed $topic');
            }
            setState(() {
              _subscriptions[topic] = val;
            });
          },
          value: _subscriptions[topic],
        ),
        Padding(padding: EdgeInsets.only(left: 10.0),),
        Text(
          topic,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  void _buildDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('$title'),
          content: Text("$message"),
          actions: <Widget>[
            FlatButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            new FlatButton(
              child: const Text('SHOW'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  void _saveSubscribe(String topic, bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(topic, value);
  }

  Future<bool> _getSubscribe(String topic) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var result = sp.getBool(topic);
    return result == null ? false : result;
  }
}
