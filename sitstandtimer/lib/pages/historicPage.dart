import 'dart:collection';

import 'package:flutter/widgets.dart';

class HistoricPage extends StatefulWidget {
  HistoricPage() {
    this.times = HashMap();
  }

  Map<String, String>? times;

  @override
  State<HistoricPage> createState() => _HistoricPageState(times);
}

class _HistoricPageState extends State<HistoricPage> {
  Map<String, String>? times;

  _HistoricPageState(times) {
    this.times = times;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
