import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plus_promo/model/profileclientmodel.dart';
import 'package:plus_promo/provider/ProviderClient.dart';
import 'package:plus_promo/provider/ProviderVendedor.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';

import '../util/secure_data.dart';

class ProfileClientPage extends StatefulWidget {
  TextEditingController oTextEditingControllerUser = TextEditingController();
  TextEditingController oTextEditingControllerEmail = TextEditingController();
  ProfileClientModel? oProfileClientModel;

  ProfileClientPage({super.key});

  @override
  State<ProfileClientPage> createState() => _ProfileClientPageState();
}

class _ProfileClientPageState extends State<ProfileClientPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: color_secondary),
        backgroundColor: color_primary,
        title: Text(
          "PERFIL DE USUARIO",
          style: TextStyle(color: color_secondary),
        ),
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    return Container(
      margin: EdgeInsets.all(marginSmall),
      child: ListView(
        children: [
          SizedBox(
            height: marginSmallSmall,
          ),
          _getFoto(),
          SizedBox(
            height: marginSmall,
          ),
          TextField(
            enabled: false,
            controller: widget.oTextEditingControllerUser,
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.user),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent))),
          ),
          SizedBox(
            height: marginMedium,
          ),
          TextField(
            enabled: false,
            controller: widget.oTextEditingControllerEmail,
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: color_accent))),
          ),
          SizedBox(
            height: marginMedium,
          ),
          ElevatedButton(
            onPressed: () {
              _logout();
            },
            child: Text(
              "CERRAR SESSION",
              style: TextStyle(color: color_secondary, fontSize: textMedium),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: color_danger,
                minimumSize: Size(double.infinity, altoMedium)),
          )
        ],
      ),
    );
  }

  _getFoto() {
    return Center(
      child: Container(
          height: 180,
          width: 180,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
          child: widget.oProfileClientModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Image.network(
                  widget.oProfileClientModel!.datos!.fotoCliente!,
                  fit: BoxFit.cover,
                )),
    );
  }

  _readProfile() async {
    String email = await SecureData.getStoragePreference();

    String type = await SecureData.getStorageTipoUserPreference();

    widget.oProfileClientModel = type == 'u'
        ? await ProviderClient.profilenClient(email)
        : await ProviderVendedor.profilenVendedor(email);

    widget.oTextEditingControllerUser.text =
        widget.oProfileClientModel!.datos!.nameCliente!;
    widget.oTextEditingControllerEmail.text =
        widget.oProfileClientModel!.datos!.uidCliente!;

    setState(() {});
  }

  _logout() async {
    Navigator.of(context).pushNamed('/');
    SecureData.saveStoragePreference(null);
    SecureData.saveStorageTipoUserPreference(null);
  }
}
