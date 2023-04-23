import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_timer/simple_timer.dart';
import 'package:sitstandtimer/main.dart';
import 'package:sitstandtimer/models/Tips.dart';

class TimerPage extends StatefulWidget {
  TimerPage(this.times);

  var times;

  @override
  _TimerPageState createState() => _TimerPageState(times);
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  TimerController? _timerController;
  late var current;
  int? pointer;
  late int tipPointer;
  late String _buttonText;
  var times;
  Timer? timer;

  late AnimationController _controller;

  late Animation _animation;

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
    timer = Timer.periodic(Duration(seconds: 5), (timer) => _changeText());

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    timer?.cancel();
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
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: FadeTransition(
              opacity: _animation as Animation<double>,
              child: Text(
                Tips.tips[tipPointer],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 0, 70),
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
                  pointer = (pointer! + 1) % 3;
                  current[pointer] = true;
                  _timerController!.duration = Duration(
                    minutes: times[pointer],
                  );
                });
                playLocalAsset();
                _timerController!.reset();
                _timerController!.start();
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
      _timerController!.start();
      setState(() {
        _buttonText = 'Stop';
      });
    } else {
      _timerController!.stop();
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
        _timerController!.reset();
        _timerController!.duration = Duration(
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

  Future<void> playLocalAsset() async {
    final player = AudioPlayer();
    return await player.play(AssetSource("bell.mp3"));
  }
}
