import 'package:flutter/material.dart';
import 'package:cookbook/classes/util.dart';
import 'package:flutter/services.dart';
import 'package:notifications_enabled/notifications_enabled.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OsSetting extends StatefulWidget {
  @override
  OsSettingState createState() => new OsSettingState();
}

class OsSettingState extends State<OsSetting> {
  static final _fcm  = FirebaseMessaging();
  String _notificationsEnabledText = '';

  @override
  void initState() {
    super.initState();

    _loadNoti();

    print('@@@@@@@@@@@ initState');
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true)
    );
    _fcm.onIosSettingsRegistered.listen((IosNotificationSettings setting) {
      print('@@@@@@@ onIosSettingsRegistered');
      print(setting);

      setState(() {
        _notificationsEnabledText = setting.alert ?
        'Notification enabled by dialog' : 'Notification disabled by dialog';
      });
    });
  }

  Future<void> _loadNoti() async {
    String notificationsEnabledText;
    try {
      final areNotificationsEnabled = await NotificationsEnabled.notificationsEnabled;
      if (areNotificationsEnabled.isNotPresent) {
        notificationsEnabledText = 'Notification permission still not requested';
      } else if (areNotificationsEnabled.value) {
        notificationsEnabledText = 'Notification enabled';
      } else {
        notificationsEnabledText = 'Notification disabled';
      }
    } on PlatformException {
      notificationsEnabledText = 'Failed to get notifications enabled.';
    } catch (e) {
      notificationsEnabledText = e.toString();
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _notificationsEnabledText = notificationsEnabledText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OS setting'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                child: Text(
                  'Notification',
                  style: TextStyle(fontSize: 20.0, color: Colors.teal, fontWeight: FontWeight.bold),
                ),
              ),
              Card(
                child: Center(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(_notificationsEnabledText),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Util.drawer(context),
    );
  }
}
