import 'dart:developer';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:sitstandtimer/main.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.times);

  var times;

  @override
  _TimerPageState createState() => _TimerPageState(times);
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  TimerController _timerController;
  var current;
  int pointer;
  String _buttonText;
  var times;

  _TimerPageState(times) {
    this.times = times;
  }

  @override
  void initState() {
    super.initState();
    _timerController = TimerController(this);
    _buttonText = 'Start';
    current = [false, false, false];
    pointer = 0;
    current[pointer] = true;
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
              duration: Duration(minutes: times[pointer]),
              controller: _timerController,
              backgroundColor: Colors.transparent,
              progressIndicatorColor: Colors.lightBlue,
              progressTextStyle: TextStyle(color: Colors.white),
              onEnd: () {
                setState(() {
                  current[pointer] = false;
                  pointer = (pointer + 1) % 3;
                  current[pointer] = true;
                  _timerController.duration = Duration(
                    minutes: times[pointer],
                  );
                });
                playLocalAsset();
                _timerController.reset();
                _timerController.start();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton(
                  child: Text(
                    'Sit',
                    style: TextStyle(
                        color: !current[0] ? Colors.grey : Colors.white),
                  ),
                  onPressed: () => _changePhase(0),
                ),
                CupertinoButton(
                  child: Text(
                    'Stand',
                    style: TextStyle(
                        color: !current[1] ? Colors.grey : Colors.white),
                  ),
                  onPressed: () => _changePhase(1),
                ),
                CupertinoButton(
                  child: Text(
                    'Move',
                    style: TextStyle(
                        color: !current[2] ? Colors.grey : Colors.white),
                  ),
                  onPressed: () => _changePhase(2),
                ),
              ],
            ),
          ),
          CupertinoButton.filled(
            child: Text(_buttonText),
            onPressed: () => _timerButtonAction(),
          )
        ],
      ),
    );
  }

  _timerButtonAction() {
    if (_buttonText.compareTo('Start') == 0) {
      _timerController.start();
      setState(() {
        _buttonText = 'Stop';
      });
    } else {
      _timerController.stop();
      setState(() {
        _buttonText = 'Start';
      });
    }
  }

  _changePhase(int to) {
    if (pointer != to) {
      setState(() {
        current[pointer] = false;
        pointer = to;
        current[pointer] = true;
        _timerController.reset();
        _timerController.duration = Duration(
          minutes: times[pointer],
        );
        _buttonText = 'Start';
      });
    }
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play("bell.mp3");
  }
}
