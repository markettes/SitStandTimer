import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sitstandtimer/widgets/barChart.dart';

class HistoricPage extends StatelessWidget {
  HistoricPage() {
    this.times = HashMap();
  }

  Map<String, String>? times;

  @override
  Widget build(BuildContext context) {
    var _controller = PageController(
      initialPage: 0,
    );
    return Container(
      margin: EdgeInsets.all(75),
      child: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          BarChartTime(),
          BarChartTime(),
          BarChartTime(),
        ],
      ),
      alignment: Alignment.center,
    );
  }
}
