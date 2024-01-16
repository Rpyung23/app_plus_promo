import 'package:flutter/material.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/icons.dart';

import '../util/textos.dart';

class HomeVendedor extends StatefulWidget {
  const HomeVendedor({super.key});

  @override
  State<HomeVendedor> createState() => _HomeVendedorState();
}

class _HomeVendedorState extends State<HomeVendedor> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/create_cupon_page');
          },
          backgroundColor: color_primary,
          child: icon_plus_white,
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
        Chip(
            backgroundColor: color_primary,
            label: Text(title_chip_expirados,
                style: TextStyle(color: color_secondary)))
      ],
    );
  }

  _getBodyHomeVendedor() {
    return ListView(
      shrinkWrap: true,
      children: [
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor(),
        _itemHomeVendedor()
      ],
    );
  }

  _itemHomeVendedor() {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.asset("./assets/logo.png"),
            title: Text(
              "% Descuento",
              style: TextStyle(
                  color: color_accent,
                  fontWeight: FontWeight.w700,
                  fontSize: textBigMedium),
            ),
            subtitle: Text(
              "Cantidad de cupones",
              style: TextStyle(fontSize: textMediumSmall),
            ),
            trailing:
                IconButton(onPressed: () {}, icon: icon_edit_color_primary),
          )
        ],
      ),
    );
  }
}
