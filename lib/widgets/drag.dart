import 'package:flutter/material.dart';
import '../parts/sidemenu.dart';

class Drag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Drag&Drop'),
    );

    return Scaffold(
      appBar: appBar,
      body: Stack(
        children: <Widget>[
          DragItem(
            text: 'Item1',
            initPos: Offset(0.0, 0.0),
            color: Colors.blue,
            offset: Offset(
                0.0,
                appBar.preferredSize.height +
                    MediaQuery.of(context).padding.top),
          ),
          DragItem(
            text: 'Item2',
            initPos: Offset(100.0, 100.0),
            color: Colors.red,
            offset: Offset(
                0.0,
                appBar.preferredSize.height +
                    MediaQuery.of(context).padding.top),
          ),
        ],
      ),
      drawer: SideMenu.drawer(context),
    );
  }
}

class DragItem extends StatefulWidget {
  Offset initPos;
  String text;
  Offset offset;
  Color color;

  DragItem({
    this.text,
    this.initPos,
    this.offset,
    this.color,
  });

  @override
  DragItemState createState() => new DragItemState();
}

class DragItemState extends State<DragItem> {
  Offset position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Arial',
    );

    Container item = Container(
      width: 100.0,
      height: 100.0,
      color: widget.color,
      child: Center(
          child: Text(
        widget.text,
        style: style,
      )),
    );

    Draggable draggable = Draggable(
      child: item,
      feedback: item,
      childWhenDragging: Opacity(opacity: 0.0, child: item),
      onDraggableCanceled: (velocity, offset) {
        setState(() {
          position = Offset(
              offset.dx - widget.offset.dx, offset.dy - widget.offset.dy);
        });
      },
    );

    return Positioned(left: position.dx, top: position.dy, child: draggable);
  }
}
