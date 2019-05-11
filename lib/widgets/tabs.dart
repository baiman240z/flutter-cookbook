import 'package:flutter/material.dart';
import '../parts/sidemenu.dart';

class _Page {
  const _Page({this.icon, this.text});

  final IconData icon;
  final String text;
}

const List<_Page> _allPages = <_Page>[
  _Page(icon: Icons.grade, text: 'TRIUMPH'),
  _Page(icon: Icons.playlist_add, text: 'NOTE'),
  _Page(icon: Icons.check_circle, text: 'SUCCESS'),
  _Page(icon: Icons.question_answer, text: 'OVERSTATE'),
  _Page(icon: Icons.sentiment_very_satisfied, text: 'SATISFACTION'),
  _Page(icon: Icons.camera, text: 'APERTURE'),
  _Page(icon: Icons.assignment_late, text: 'WE MUST'),
  _Page(icon: Icons.assignment_turned_in, text: 'WE CAN'),
  _Page(icon: Icons.group, text: 'ALL'),
  _Page(icon: Icons.block, text: 'EXCEPT'),
  _Page(icon: Icons.sentiment_very_dissatisfied, text: 'CRYING'),
  _Page(icon: Icons.error, text: 'MISTAKE'),
  _Page(icon: Icons.loop, text: 'TRYING'),
  _Page(icon: Icons.cake, text: 'CAKE'),
];

class Tabs extends StatefulWidget {
  @override
  TabsState createState() => TabsState();
}

class TabsState extends State<Tabs> with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _allPages.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Theme.of(context).accentColor;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _controller,
            isScrollable: true,
            tabs: _allPages.map<Tab>((_Page page) {
              return Tab(text: page.text, icon: Icon(page.icon));
            }).toList(),
          ),
          title: Text('Tabs'),
        ),
        body: TabBarView(
          controller: _controller,
          children: _allPages.map((_Page page) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Container(
                key: ObjectKey(page.icon),
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  child: Center(
                    child: Icon(
                      page.icon,
                      color: iconColor,
                      size: 128.0,
                      semanticLabel: 'Placeholder for ${page.text} tab',
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        drawer: SideMenu.drawer(context),
      ),
    );
  }
}
