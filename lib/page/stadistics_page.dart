import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/static_cupon.dart';
import '../provider/ProviderCupon.dart';
import '../util/textos.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class StaticsPage extends StatefulWidget {
  ModelStaticCupon? oModelStaticCupon;

  StaticsPage({super.key});

  @override
  State<StaticsPage> createState() => _StaticsPageState();
}

class _StaticsPageState extends State<StaticsPage> {
  @override
  void initState() {
    // TODO: implement initState
    _consumirApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color_secondary),
        backgroundColor: color_primary,
        title: Text(
          panel_statics,
          style: TextStyle(color: color_secondary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: marginSmallSmall,
            left: marginSmallSmall,
            right: marginSmallSmall),
        child: _getBody(),
      ),
    );
  }

  _getBody() {
    return widget.oModelStaticCupon == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            shrinkWrap: false,
            children: [
              Card(child: _getDiagrama1()),
              SizedBox(
                height: marginSmallSmall,
              ),
              Card(
                child: _getDiagrama2(),
              ),
              /*Card(
                child: Container(
                  padding: EdgeInsets.all(marginSmallSmall),
                  height: 500,
                  width: 400,
                  child: PieChart(
                    PieChartData(
                        sections: _getSections(
                            "NO OCUPADOS",
                            "VENCIDOS",
                            widget.oModelStaticCupon!.disponibleCuponVn,
                            widget.oModelStaticCupon!.cantCuponVn)),
                    swapAnimationCurve: Curves.bounceIn,
                  ),
                ),
              ),
              SizedBox(
                height: marginSmallSmall,
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(marginSmallSmall),
                  height: 500,
                  width: 400,
                  child: PieChart(
                    PieChartData(
                        sections: _getSections(
                            "DISPONIBLES",
                            "OCUPADOS",
                            widget.oModelStaticCupon!.disponibleCuponOcp,
                            widget.oModelStaticCupon!.cantCuponOcp)),
                    swapAnimationCurve: Curves.bounceIn,
                  ),
                ),
              ),*/
              SizedBox(
                height: marginSmallSmall,
              )
            ],
          );
  }

  _getSections(titulo1, titulo2, valor1, valor2) {
    return [
      PieChartSectionData(
          radius: 70,
          value: valor1,
          title: titulo1 + " " + valor1.toString() + " %",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          color: color_success),
      PieChartSectionData(
          radius: 50,
          value: valor2,
          title: titulo2 + " " + valor2.toString() + " %",
          titleStyle: TextStyle(fontWeight: FontWeight.bold),
          color: color_danger)
    ];
  }

  _consumirApi() async {
    widget.oModelStaticCupon = await ProviderCreateCupon.consumirPanelCupon();
    if (widget.oModelStaticCupon!.statusCode == 400) {
      Fluttertoast.showToast(
          msg: widget.oModelStaticCupon!.msm!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }

  _getDiagrama1() {
    if (widget.oModelStaticCupon == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    List<ChartData> chartData = [
      ChartData('NO CANJEADOS', widget.oModelStaticCupon!.disponibleCuponVn!,
          color_primary),
      ChartData(
          'EXPIRADOS', widget.oModelStaticCupon!.cantCuponVn!, color_warning),
    ];

    return SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        title: ChartTitle(text: 'EXPIRADOS / NO CANJEADOS'),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]);
  }

  _getDiagrama2() {
    if (widget.oModelStaticCupon == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    List<ChartData> chartData = [
      ChartData('DISPONIBLES', widget.oModelStaticCupon!.disponibleCuponOcp!,
          color_success),
      ChartData(
          'CANJEADOS', widget.oModelStaticCupon!.cantCuponOcp!, color_danger),
    ];

    return SfCircularChart(
        tooltipBehavior: TooltipBehavior(enable: true),
        title: ChartTitle(text: 'EXPIRADOS / NO CANJEADOS'),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ]);
  }
}
