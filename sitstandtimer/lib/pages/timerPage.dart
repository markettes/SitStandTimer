import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  TimerController _timerController;

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SimpleTimer(
              duration: Duration(seconds: 10),
              controller: _timerController,
              backgroundColor: Colors.transparent,
              progressIndicatorColor: Colors.lightBlue,
              progressTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          CupertinoButton.filled(
            child: Text('Start'),
            onPressed: () => _timerController.start(),
          )
        ],
      ),
    );
  }
}
