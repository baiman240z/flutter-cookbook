import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  int _counter = 0;

  int get counter => _counter;

  static AppModel of(BuildContext context, {
    bool rebuildOnChange = false,
  }) => ScopedModel.of<AppModel>(context, rebuildOnChange: rebuildOnChange);

  void increment() {
    _counter++;
    notifyListeners();
  }
}
