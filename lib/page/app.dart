import 'package:flutter/material.dart';
import 'package:plus_promo/page/carrusel_page.dart';
import 'package:plus_promo/page/home_page.dart';
import 'package:plus_promo/page/home_vendedor.dart';
import 'package:plus_promo/page/profile_client_page.dart';
import 'package:plus_promo/page/qr_cupon_page.dart';
import 'package:plus_promo/page/registro_page.dart';
import 'package:plus_promo/page/scanner_qr.dart';
import 'categoria_cupon_page.dart';
import 'create_cupon.dart';
import 'cupones_list_page.dart';
import 'login_page.dart';
import 'session_page.dart';
import 'stadistics_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '+ PROMO',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'ES'), // Español
      ],
      debugShowCheckedModeBanner: false,
      routes: {
        '/carrusel_page': (_) => CarruselPage(),
        '/registro_page': (_) => RegsitroPage(tipo_registro: 'c'),
        '/home_page': (_) => HomePage(),
        '/categoria_cupon': (_) => CategoriaCuponPage(),
        '/cupones_list': (_) => CuponesListPage(),
        '/qr_cupon_page': (_) => QrCuponPage(
              oDatoCuponLista: null,
              email_user: null,
            ),
        '/qr_scanner_page': (_) => ScannerQR(),
        '/home_vendedor': (_) => HomeVendedor(),
        '/session_page': (_) => SessionPage(),
        '/create_cupon_page': (_) => CreateCuponPage(
              update_create_cupon: 0,
              oDatoCuponLista: null,
            ),
        '/': (_) => LoginPage(),
        '/profile_cliente_page': (_) => ProfileClientPage(),
        '/statistical_page': (_) => StaticsPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
    );
  }
}
