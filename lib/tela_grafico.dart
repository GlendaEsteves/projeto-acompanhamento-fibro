import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TelaGrafico extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool? animate;
  const TelaGrafico(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: charts.BarChart(
        seriesList,
        animate: animate,
        vertical: false,
        barRendererDecorator: charts.BarLabelDecorator<String>(),
        domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    );
  }
}
