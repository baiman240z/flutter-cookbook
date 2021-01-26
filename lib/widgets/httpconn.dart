import 'package:flutter/material.dart';
import '../classes/util.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class HttpConn extends StatefulWidget {
  @override
  HttpConnState createState() => HttpConnState();
}

class HttpConnState extends State<HttpConn> {
  Future<http.Response> future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP connection'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              splashColor: Colors.yellow,
              color: Color(0xFF4aa0d5),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Text(
                    "GET",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  future = http.get(
                      "https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip");
                });
              },
            ),
            Padding(padding: EdgeInsets.only(top: 30.0)),
            FutureBuilder(
                future: future,
                builder: (context, AsyncSnapshot<http.Response> snapShop) {
                  String text = "idol";
                  if (snapShop.hasError) {
                    text = "error: ${snapShop.error}";
                  } else if (snapShop.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapShop.hasData) {
                    print(snapShop.data.statusCode);
                    print(snapShop.data.contentLength);
                    text = "${snapShop.data.contentLength} loaded";
                  }

                  return Text(text, style: TextStyle(fontSize: 20.0));
                }),
          ],
        ),
      ),
      drawer: Util.drawer(context),
    );
  }
}
