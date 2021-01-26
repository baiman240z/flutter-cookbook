import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../classes/util.dart';

class Web extends StatefulWidget {
  @override
  WebState createState() => WebState();
}

class WebState extends State<Web> {
  final TextEditingController _text = TextEditingController();
  static const String initialUrl = 'https://flutter.io';
  WebViewController _web;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web view'),
      ),
      body: _build(context),
      drawer: Util.drawer(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    hintText: "Input URL"
                  ),
                  keyboardType: TextInputType.url,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: RaisedButton(
                  color: Colors.blueAccent,
                  splashColor: Colors.yellow,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Show',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                  onPressed: () {
                    _web.loadUrl(_text.text);
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: WebView(
            initialUrl: initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _web = controller;
              _text.text = initialUrl;
            },
          ),
        ),
      ],
    );
  }
}
