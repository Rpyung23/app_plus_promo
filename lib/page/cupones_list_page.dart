import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../model/cupon_lista/cupon_lista.dart';
import '../model/cupon_lista/data_cupon_lista.dart';
import '../provider/ProviderCupon.dart';
import '../util/color.dart';
import '../util/dimensiones.dart';
import '../util/secure_data.dart';
import '../util/textos.dart';
import 'qr_cupon_page.dart';

class CuponesListPage extends StatefulWidget {
  int? id_categoria;
  ListCuponModel? oListCuponModel;
  CuponesListPage({this.id_categoria});

  @override
  State<CuponesListPage> createState() => _CuponesListPageState();
}

class _CuponesListPageState extends State<CuponesListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCuponList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: color_primary,
        title: Text(
          title_toolbar_cupon_lista,
          style: TextStyle(color: color_secondary),
        ),
      ),
      body: _getBodyCuponesListaPage(),
    );
  }

  _getBodyCuponesListaPage() {
    return Container(
      child: widget.oListCuponModel == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: widget.oListCuponModel == null
                  ? 0
                  : widget.oListCuponModel!.datos!.length > 0
                      ? widget.oListCuponModel!.datos!.length
                      : 0,
              itemBuilder: (_, index) {
                return _getItem(widget.oListCuponModel!.datos![index]);
              },
            ),
    );
  }

  _getItem(DatoCuponLista oDatoCuponLista) {
    return Column(
      children: [
        ListTile(
          leading: Image.network(
            oDatoCuponLista.fotoCupon!,
            fit: BoxFit.cover,
            repeat: ImageRepeat.noRepeat,
            height: 75,
            width: 75,
          ),
          title: Text(
            oDatoCuponLista.nombreCupon!,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: color_accent,
                fontSize: textBigMedium),
          ),
          subtitle: Text(
            oDatoCuponLista.fechaExpiracion!,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: color_accent,
                fontSize: textMediumSmall),
          ),
          onTap: () {
            //Navigator.of(context).pushNamed("/qr_cupon_page");

            _showNavigatorCuponQr(oDatoCuponLista);
          },
        ),
        Divider()
      ],
    );
  }

  _initCuponList() async {
    widget.oListCuponModel = null;
    setState(() {});
    if (widget.id_categoria == null) {
      widget.oListCuponModel = await ProviderCreateCupon.readCuponClientList();
    } else {
      widget.oListCuponModel =
          await ProviderCreateCupon.readCuponClientCategoryList(
              widget.id_categoria);
    }
    setState(() {});
  }

  _showNavigatorCuponQr(DatoCuponLista oDatoCuponLista_) async {
    String user = await SecureData.getStoragePreference();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => QrCuponPage(
              oDatoCuponLista: oDatoCuponLista_,
              email_user: user,
            )));
  }
}
