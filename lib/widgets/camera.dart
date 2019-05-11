import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../parts/sidemenu.dart';

class Camera extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  File _image;

  void getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image == null) {
      return;
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Icon(Icons.no_sim)
                : Image.file(
                    _image,
                    height: 200.0,
                    width: 200.0,
                  ),
            RaisedButton(
              child: Text('use camera'),
              onPressed: () {
                getImage(ImageSource.camera);
              },
            ),
            RaisedButton(
              child: Text('from library'),
              onPressed: () {
                getImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      drawer: SideMenu.drawer(context),
    );
  }
}
