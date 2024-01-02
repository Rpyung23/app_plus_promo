import 'package:flutter/material.dart';
import 'package:plus_promo/page/carrusel_page.dart';
import 'package:plus_promo/page/home_page.dart';
import 'package:plus_promo/page/home_vendedor.dart';
import 'package:plus_promo/page/qr_cupon_page.dart';
import 'package:plus_promo/page/registro_page.dart';
import 'categoria_cupon_page.dart';
import 'cupones_list_page.dart';
import 'login_page.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+ PROMO',
      debugShowCheckedModeBanner: false,
      routes: {
        '/carrusel_page': (_) => CarruselPage(),
        '/registro_page': (_) => RegsitroPage(tipo_registro: 'c'),
        '/home_page': (_) => HomePage(),
        '/categoria_cupon': (_) => CategoriaCuponPage(),
        '/cupones_list': (_) => CuponesListPage(),
        '/qr_cupon_page': (_) => QrCuponPage(),
        '/home_vendedor': (_) => HomeVendedor(),
        '/': (_) => LoginPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
