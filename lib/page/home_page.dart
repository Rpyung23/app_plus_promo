// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:plus_promo/page/categoria_cupon_page.dart';
import 'package:plus_promo/page/cupones_list_page.dart';
import 'package:plus_promo/util/icons.dart';
import 'package:plus_promo/util/textos.dart';

import 'profile_client_page.dart';

class HomePage extends StatefulWidget {
  int opc_menu = 0;

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: widget.opc_menu,
            onTap: (value) {
              setState(() {
                widget.opc_menu = value;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: icon_home, label: bottom_navigator_inicio),
              BottomNavigationBarItem(
                  icon: icon_work, label: bottom_navigator_cupones),
              BottomNavigationBarItem(
                  icon: icon_profiile, label: bottom_navigator_perfil)
            ],
          ),
          body: _getBodyHomePage()),
      canPop: false,
    );
  }

  _getBodyHomePage() {
    switch (widget.opc_menu) {
      case 0:
        return CategoriaCuponPage();
      case 1:
        return CuponesListPage(
          id_categoria: null,
        );
      case 2:
        return ProfileClientPage();
      default:
        return Center(
          child: Text("DEFAULT NAVIGATOR"),
        );
    }
  }
}
