import 'package:flutter/material.dart';
import '../classes/util.dart';
import 'package:english_words/english_words.dart';

class ListScreen extends StatelessWidget {
  final _list = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    Util.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('English words'),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        }

        int dataIndex = index ~/ 2;

        if (dataIndex >= _list.length) {
          _list.addAll(generateWordPairs().take(10));
        }

        return ListTile(
          title: Text(_list[dataIndex].asPascalCase),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(word: _list[dataIndex]),
              ),
            );
          },
        );
      }),
      drawer: Util.drawer(context),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final WordPair word;

  DetailScreen({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${word.asUpperCase}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('${word.asPascalCase}\nHash code is ${word.hashCode}'),
      ),
    );
  }
}
