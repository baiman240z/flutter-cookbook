import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class Util {
  static FirebaseMessaging _fcm = FirebaseMessaging();

  static Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.web),
            title: Text('Firebase messaging'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/fcm');
            },
          ),
          ListTile(
            leading: const Icon(Icons.web),
            title: Text('Webview'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/web');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_alert),
            title: Text('Alert'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/alert');
            },
          ),
          ListTile(
            leading: const Icon(Icons.tab),
            title: Text('Tabs'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tabs');
            },
          ),
          ListTile(
            leading: const Icon(Icons.child_care),
            title: Text('Child display'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/childscreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.screen_lock_landscape),
            title: Text('Layout'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/layout');
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: Text('Splash'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/splash');
            },
          ),
          ListTile(
            leading: const Icon(Icons.drag_handle),
            title: Text('Drag&Drop'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/drag');
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/camera');
            },
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: Text('Audio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/audio');
            },
          ),
          ListTile(
            leading: const Icon(Icons.http),
            title: Text('HTTP'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/httpconn');
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: Text('Location'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/location');
            },
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.close),
            title: Text('Close'),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    );
  }

  static void build(BuildContext context) {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onMessage] $message");
        _buildDialog(context, message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("@@@@@@@@@@@@@@@@@@@@@ onResume: $message");
        Navigator.pushReplacementNamed(context, message['data']['url']);
      },
    );
    _fcm.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
      print("@@@@@@@@@@@@@@@@@ Settings registered: $settings");
    });
  }

  static void _buildDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
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

}
