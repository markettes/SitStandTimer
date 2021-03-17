import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:sitstandtimer/main.dart';
import 'package:sitstandtimer/models/tips.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.times);

  var times;

  @override
  _TimerPageState createState() => _TimerPageState(times);
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  TimerController _timerController;
  var current;
  int pointer;
  int tipPointer;
  String _buttonText;
  var times;
  Timer timer;

  AnimationController _controller;

  Animation _animation;

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
    tipPointer = Random().nextInt(Tips.tips.length);
    current[pointer] = true;
    timer = Timer.periodic(Duration(minutes: 5), (timer) => _changeText());

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: FadeTransition(
              opacity: _animation,
              child: Text(
                Tips.tips[tipPointer],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
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

  _changeText() async {
    await _controller.animateTo(0, duration: Duration(milliseconds: 500));
    setState(() {
      tipPointer = Random().nextInt(Tips.tips.length);
    });
    await _controller.animateTo(1, duration: Duration(milliseconds: 500));
  }

  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play("bell.mp3");
  }
}
