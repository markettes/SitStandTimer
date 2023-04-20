import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage(times) {
    this.times = times;
  }

  var times;

  @override
  _SettingsPageState createState() => _SettingsPageState(times);
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController? _textController;
  var times;

  @override
  initState() {
    _textController = TextEditingController(text: 'Recomended: 20 min');
  }

  _SettingsPageState(times) {
    this.times = times;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Sit time',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(
                child: NumberPicker(
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 30,
                  value: times[0],
                  onChanged: (value) {
                    setState(() {
                      times[0] = value;
                    });
                  },
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  haptics: true,
                  itemWidth: 40,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Stand time',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(
                child: NumberPicker(
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 30,
                  value: times[1],
                  onChanged: (value) {
                    setState(() {
                      times[1] = value;
                    });
                  },
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  haptics: true,
                  itemWidth: 40,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  'Move time',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Flexible(
                child: NumberPicker(
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: 30,
                  value: times[2],
                  onChanged: (value) {
                    setState(() {
                      times[2] = value;
                    });
                  },
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  haptics: true,
                  itemWidth: 40,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
