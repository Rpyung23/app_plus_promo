import 'package:flutter/material.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/icons.dart';

import '../model/cupon_lista/cupon_lista.dart';
import '../model/cupon_lista/data_cupon_lista.dart';
import '../provider/ProviderCupon.dart';
import '../util/textos.dart';
import 'create_cupon.dart';

class HomeVendedor extends StatefulWidget {
  ListCuponModel oListCuponModel = ListCuponModel(datos: []);
  HomeVendedor({super.key});

  @override
  State<HomeVendedor> createState() => _HomeVendedorState();
}

class _HomeVendedorState extends State<HomeVendedor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCuponLista();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            bottom_navigator_inicio,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              _getChip(),
              SizedBox(
                height: marginSmallSmall,
              ),
              _getBodyHomeVendedor()
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(left: marginMediumSmall),
              child: FloatingActionButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('/qr_scanner_page');
                },
                backgroundColor: color_primary,
                child: icon_camera,
              ),
            ),
            FloatingActionButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/create_cupon_page');
                _getCuponLista();
              },
              backgroundColor: color_primary,
              child: icon_plus_white,
            )
          ],
        ),
      ),
      onPopInvoked: ((didPop) {}),
    );
  }

  _getChip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Chip(
            backgroundColor: color_primary,
            label: Text(
              title_chip_cupon,
              style: TextStyle(color: color_secondary),
            )),
        Chip(
            backgroundColor: color_primary,
            label: Text(title_chip_cajeados,
                style: TextStyle(color: color_secondary))),
        GestureDetector(
          child: Chip(
              backgroundColor: color_primary,
              label: Text("PERFIL", style: TextStyle(color: color_secondary))),
          onTap: () {
            Navigator.of(context).pushNamed('/profile_cliente_page');
          },
        )
      ],
    );
  }

  _getBodyHomeVendedor() {
    return widget.oListCuponModel.datos!.length == 0
        ? CircularProgressIndicator()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: widget.oListCuponModel.datos!.length,
            itemBuilder: (context, index) {
              return _itemHomeVendedor(widget.oListCuponModel.datos![index]);
            });
  }

  _itemHomeVendedor(DatoCuponLista oD) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.network(
              oD.fotoCupon!,
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat,
              height: 75,
              width: 75,
            ),
            title: Text(
              oD.nombreCupon!,
              style: TextStyle(
                  color: color_accent,
                  fontWeight: FontWeight.w700,
                  fontSize: textBigMedium),
            ),
            subtitle: Text(
              "DISPONIBLE : " + oD!.cantCupon.toString(),
              style: TextStyle(fontSize: textMediumSmall),
            ),
            trailing: IconButton(
                onPressed: () {
                  _updatePage(oD);
                },
                icon: icon_edit_color_primary),
          )
        ],
      ),
    );
  }

  _getCuponLista() async {
    widget.oListCuponModel = ListCuponModel(statusCode: 300, datos: []);
    ;
    setState(() {});
    widget.oListCuponModel = await ProviderCreateCupon.readCuponList();
    setState(() {});
  }

  _updatePage(oD) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CreateCuponPage(
              update_create_cupon: 1,
              oDatoCuponLista: oD,
            )));
    _getCuponLista();
  }
}
