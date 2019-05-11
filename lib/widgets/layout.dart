import 'package:flutter/material.dart';
import '../classes/util.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Util.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Layout'),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Icon(Icons.timer),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Icon(Icons.place),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Icon(Icons.motorcycle),
                  ),
                ),
              ),
            ],
          ),
          Card(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: const Icon(Icons.album),
                  title: const Text('The Enchanted Nightingale'),
                  subtitle: const Text(
                      'Music by Julie Gable. Lyrics by Sidney Stein.'),
                ),
                new ButtonTheme.bar(
                  // make buttons use the appropriate styles for cards
                  child: new ButtonBar(
                    children: <Widget>[
                      new FlatButton(
                        child: const Text('BUY TICKETS'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      new FlatButton(
                        child: const Text('LISTEN'),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      drawer: Util.drawer(context),
    );
  }
}
