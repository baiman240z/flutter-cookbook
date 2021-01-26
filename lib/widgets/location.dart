import 'package:flutter/material.dart';
import '../classes/util.dart';
import 'package:location/location.dart' as geo;
import 'package:flutter/services.dart';

class Location extends StatefulWidget {
  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<Location> {
  geo.Location location;
  String _lat;
  String _lon;
  String _state;

  @override
  void initState() {
    super.initState();
    _lat = "push button below";
    _lon = "push button below";
    _state = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Location'),
      ),
      body: _build(),
      drawer: Util.drawer(context),
    );
  }

  void _updateLocation(geo.LocationData loc) {
    setState(() {
      _lat = loc.latitude.toString();
      _lon = loc.longitude.toString();
      _state = 'success';
    });
  }

  void _getLocation() async {
    if (location == null) {
      location = geo.Location();
    }

    try {
      geo.LocationData _loc = await location.getLocation();
      _updateLocation(_loc);
      location.onLocationChanged().listen((geo.LocationData loc) {
        _updateLocation(loc);
      });
    } on PlatformException catch (e) {
      _state = e.code;
    }
  }

  Widget _build() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: const Text("Lat"),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.green,
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                Expanded(
                  child: Text("$_lat"),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green.withOpacity(0.5),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin:
            const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: const Text("Lon"),
                ),
                Container(
                  height: 30.0,
                  width: 1.0,
                  color: Colors.green,
                  margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                ),
                Expanded(
                  child: Text("$_lon"),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: RaisedButton(
              color: Colors.blueAccent,
              splashColor: Colors.lightBlue,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: const Text(
                  'Get Location',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
              ),
              onPressed: () {
                setState(() {
                  _state = 'loading...';
                });
                _getLocation();
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('$_state'),
          ),
        ],
      ),
    );
  }
}
