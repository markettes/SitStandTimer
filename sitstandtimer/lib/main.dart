import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sitstandtimer/pages/settingsPage.dart';
import 'package:sitstandtimer/pages/timerPage.dart';
import 'package:window_size/window_size.dart';

const Color primaryColor = Color(0x0455BF);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    setWindowTitle('Sit Stand Move');
    setWindowMinSize(const Size(400, 650));
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SitStandTimer',
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static var times;

  @override
  initState() {
    times = [20, 8, 2];
  }

  static List<Widget> _widgetOptions = <Widget>[
    TimerPage(times),
    SettingsPage(times),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 4, 85, 191),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.alarm),
            label: 'Timer',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.dial),
            label: 'Edit',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
