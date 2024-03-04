import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_promo/util/color.dart';
import 'package:intl/intl.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/profileclientmodel.dart';
import '../model/static_cupon.dart';
import '../model/usuario_vendedor/data_login_usuario_model.dart';
import '../provider/ProviderCupon.dart';
import '../provider/ProviderVendedor.dart';
import '../util/secure_data.dart';
import '../util/textos.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class StaticsPage extends StatefulWidget {
  ModelStaticCupon? oModelStaticCupon;

  ProfileClientModel? oProfileClientModel;

  StaticsPage({super.key});

  @override
  State<StaticsPage> createState() => _StaticsPageState();
}

class _StaticsPageState extends State<StaticsPage> {
  @override
  void initState() {
    // TODO: implement initState
    _consumirApi();
    _initReadDataVendedor();
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

  obtenerFechaYHoraActual() {
    // Obtener la fecha y hora actual
    DateTime now = DateTime.now();
    // Formatear la fecha y la hora
    return DateFormat('yyyy-MM-dd HH:mm').format(now);
  }

  _getBody() {
    return widget.oModelStaticCupon == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView(
            shrinkWrap: false,
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.all(marginSmallSmall),
                  child: Row(
                    children: [
                      widget.oProfileClientModel == null
                          ? CircleAvatar(
                              child: Text("."),
                            )
                          : Container(
                              height: 70,
                              width: 70,
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                widget.oProfileClientModel!.datos!.fotoCliente!,
                                fit: BoxFit.cover,
                              ),
                              decoration: BoxDecoration(shape: BoxShape.circle),
                            ),
                      SizedBox(
                        width: marginSmallSmall,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.oProfileClientModel == null
                                ? "SIN NOMBRE"
                                : widget
                                    .oProfileClientModel!.datos!.nameCliente!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: textMedium),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(widget.oProfileClientModel == null
                              ? "SIN EMAIL"
                              : widget.oProfileClientModel!.datos!.uidCliente!)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: marginSmallSmall,
              ),
              Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _getDiagrama1(),
                  Container(
                    child: Text("Fecha Reporte : " + obtenerFechaYHoraActual()),
                    padding: EdgeInsets.all(marginSmallSmall),
                  )
                ],
              )),
              SizedBox(
                height: marginSmallSmall,
              ),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _getDiagrama2(),
                    Container(
                        child: Text(
                            "Fecha Reporte : " + obtenerFechaYHoraActual()),
                        padding: EdgeInsets.all(marginSmallSmall))
                  ],
                ),
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
        title: ChartTitle(
            text: 'EXPIRADOS / NO CANJEADOS',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: chartData,
              explode: true,
              explodeIndex: 0,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: textMedium)))
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
        title: ChartTitle(
            text: 'EXPIRADOS / NO CANJEADOS',
            textStyle: TextStyle(fontWeight: FontWeight.bold)),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<ChartData, String>(
              dataSource: chartData,
              explode: true,
              explodeIndex: 0,
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: textMedium)))
        ]);
  }

  _initReadDataVendedor() async {
    //widget.oDataLoginClienteVendedorModel =
    String email = await SecureData.getStoragePreference();
    widget.oProfileClientModel = await ProviderVendedor.profilenVendedor(email);
    setState(() {});
  }
}
