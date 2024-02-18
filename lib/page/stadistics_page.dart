import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';

import '../model/static_cupon.dart';
import '../provider/ProviderCupon.dart';
import '../util/textos.dart';

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
              Card(
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
                height: marginMediumSmall,
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
}
