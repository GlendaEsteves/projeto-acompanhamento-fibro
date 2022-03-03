import 'package:acompanhamento_fibro/sintomas.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TelaGrafico extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;
  const TelaGrafico(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
    );
  }
}
