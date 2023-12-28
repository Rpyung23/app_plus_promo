import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/textos.dart';

class CarruselPage extends StatelessWidget {
  CarruselPage({Key? key}) : super(key: key);

  // Variables
  late bool darkMode;
  Color colorFondo = Colors.deepPurple, colorAccent = Colors.deepPurple;
  late Size
      screenSize; // Obtenemos las vavriables de la dimension de la pantalla

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.only(
                right: marginSmallSmall,
                left: marginSmallSmall,
                bottom: marginSmallSmall),
            child: body(context: context)));
  }

  /// WIDGETS
  Widget body({required BuildContext context}) {
    return Column(
      children: [
        Flexible(child: OnboardingIntroduction(colorAccent: colorAccent)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            button(
                text: txt_cliente,
                colorButton: color_primary,
                colorText: color_secondary,
            context: context,
            tipo_registro: 'c'),
            button(
                text: txt_vender,
                colorButton: color_secondary,
                colorText: color_primary,
                context: context,
                tipo_registro: 'v'),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ],
    );
  }

  // WIDGETS COMPONENT
  Widget button(
      {required String text,
      Color colorText = Colors.white,
      Color colorButton = Colors.purple,
      double padding = 12,
       required BuildContext context,required String tipo_registro}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: colorButton,
          padding: const EdgeInsets.all(16.0),
          shadowColor: colorButton,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: colorButton)),
          side: BorderSide(color: colorButton),
        ),
        child: Text(text.toUpperCase(),
            style: TextStyle(
                color: colorText, fontSize: 18.0, fontWeight: FontWeight.bold)),
        onPressed: () {
          Navigator.of(context).pushNamed('/registro_page',arguments: {
            tipo_registro: tipo_registro
          });
        },
      ),
    );
  }

  Widget buttonRoundAppBar(
          {required void Function() onPressed,
          required BuildContext context,
          Widget? child,
          required IconData icon,
          required EdgeInsets edgeInsets}) =>
      Material(
          color: Colors.transparent,
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Ink(
                      decoration: ShapeDecoration(
                          color: Brightness.dark == Theme.of(context).brightness
                              ? Colors.black
                              : Colors.white,
                          shape: const CircleBorder()),
                      child: child == null
                          ? IconButton(
                              icon: Icon(icon),
                              color: Brightness.dark ==
                                      Theme.of(context).brightness
                                  ? Colors.white
                                  : Colors.black,
                              onPressed: onPressed)
                          : child))));
}

class OnboardingIntroduction extends StatefulWidget {
  OnboardingIntroduction({this.colorAccent = Colors.deepPurple, Key? key})
      : super(key: key);

  late Color colorAccent;

  @override
  State<OnboardingIntroduction> createState() => _OnboardingIntroductionState();
}

class _OnboardingIntroductionState extends State<OnboardingIntroduction> {
  // var
  late bool darkMode;
  late Size screenSize;
  double indicatorProgressItem01 = 0.0;
  double indicatorProgressItem02 = 0.0;
  double indicatorProgressItem03 = 0.0;
  late Timer timer;
  int index = 0;
  late List<Widget> widgets;

  // fuction  : maneja el evento de toque IZQUIERDO que cambian los valores de los indicadores de progreso
  void leftTouch() {
    // primer item
    if (indicatorProgressItem01 >= 0.0 &&
        indicatorProgressItem02 == 0.0 &&
        indicatorProgressItem03 == 0.0) {
      indicatorProgressItem01 = 0.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 0; // siguiente vista
    }
    // segundo item
    else if (indicatorProgressItem01 == 1.0 &&
        indicatorProgressItem02 >= 0.0 &&
        indicatorProgressItem03 == 0.0) {
      indicatorProgressItem01 = 0.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 0; //  siguiente vista
    }
    // tercer item
    else if (indicatorProgressItem02 == 1.0 && indicatorProgressItem01 == 1.0) {
      indicatorProgressItem01 = 1.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 2; //  siguiente vista
    }
    // vuelve a la vista al princio
    else {
      indicatorProgressItem01 = 0.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 0;
    }
  }

  // fuction  : maneja el evento de toque DERECHO que cambian los valores de los indicadores de progreso
  void rightTouch() {
    // primer item
    if (indicatorProgressItem01 <= 1.00 &&
        indicatorProgressItem02 == 0.0 &&
        indicatorProgressItem03 == 0.0) {
      indicatorProgressItem01 = 1.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 1; // siguiente vista
    }
    // segundo item
    else if (indicatorProgressItem02 <= 1.00 &&
        indicatorProgressItem01 > 0.0 &&
        indicatorProgressItem03 == 0.0) {
      indicatorProgressItem01 = 1.0;
      indicatorProgressItem02 = 1.0;
      indicatorProgressItem03 = 0.0;
      index = 2; // siguiente vista
    }
    // tercer item
    else if (indicatorProgressItem01 == 1.0 && indicatorProgressItem02 == 1.0) {
      indicatorProgressItem01 = 0.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 0; // siguiente vista
    }
    // vuelve a la vista al principio
    else {
      indicatorProgressItem01 = 0.0;
      indicatorProgressItem02 = 0.0;
      indicatorProgressItem03 = 0.0;
      index = 0;
    }
  }

  void positionIndicatorLogic() {
    // logica de los indicadores de posicion que cambiar cada sierto tiempo
    timer = Timer.periodic(const Duration(microseconds: 50000), (timer) {
      setState(() {
        if (indicatorProgressItem01 < 1) {
          if (indicatorProgressItem01 >= 0.1 &&
              indicatorProgressItem01 <= 0.8) {
            indicatorProgressItem01 += 0.02;
          } else {
            indicatorProgressItem01 += 0.01;
          }
          index = 0;
        }
        if (indicatorProgressItem02 < 1 && indicatorProgressItem01 >= 1) {
          if (indicatorProgressItem02 >= 0.1 &&
              indicatorProgressItem02 <= 0.8) {
            indicatorProgressItem02 += 0.02;
          } else {
            indicatorProgressItem02 += 0.01;
          }
          index = 1;
        }
        if (indicatorProgressItem03 < 1 && indicatorProgressItem02 >= 1) {
          if (indicatorProgressItem03 >= 0.1 &&
              indicatorProgressItem03 <= 0.8) {
            indicatorProgressItem03 += 0.02;
          } else {
            indicatorProgressItem03 += 0.01;
          }
          index = 2;
        }
        if (indicatorProgressItem01 >= 1 &&
            indicatorProgressItem02 >= 1 &&
            indicatorProgressItem03 >= 1) {
          indicatorProgressItem01 = 0.0;
          indicatorProgressItem02 = 0.0;
          indicatorProgressItem03 = 0.0;
        }
      });
    });
  }

  @override
  void initState() {
    // logicas de los indicadores de posicion
    positionIndicatorLogic();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos los valores
    darkMode = Theme.of(context).brightness == Brightness.dark;
    screenSize = MediaQuery.of(context).size;

    // lista de widgets con las vistas
    widgets = [
      pageView(
          context: context,
          colorContent: Colors.transparent,
          textColor: darkMode ? Colors.white : Colors.black,
          colorIcon: darkMode ? Colors.white : Colors.black,
          iconData: Icons.phone_android,
          titulo: "Somos un banco en una app",
          subtitulo:
              "Abrí tu cuenta simple y rápida.\nNo pagás mantenimiento, ni resúmenes, ni gastos de apertura,ni movimientos en cajeros automáticos."),
      pageView(
          context: context,
          colorContent: Colors.transparent,
          textColor: darkMode ? Colors.white : Colors.black,
          colorIcon: darkMode ? Colors.white : Colors.black,
          iconData: Icons.monetization_on,
          titulo: "Controlá tu plata.",
          subtitulo:
              "Podés analizar tus compras y tranferencias en categorías para saber exactamente como estás usando tu plata."),
      pageView(
          context: context,
          colorContent: Colors.transparent,
          textColor: darkMode ? Colors.white : Colors.black,
          colorIcon: darkMode ? Colors.white : Colors.black,
          iconData: Icons.notifications_active,
          titulo: "Todo pasa en tu celu.",
          subtitulo:
              "Cada vez que haya un movimiento en tu cuenta vas a recibir una notificación.\nNada va a quedar fuera de tu control."),
    ];

    //  description : vista principal
    return Stack(
      children: [
        Column(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //  indicador de vista :  item 1
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                              minHeight: 5,
                              color: widget.colorAccent,
                              backgroundColor:
                                  darkMode ? Colors.white12 : Colors.black12,
                              value: indicatorProgressItem01),
                        ),
                      ),
                    ),
                    //  indicador de vista :  item 2
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            color: widget.colorAccent,
                            backgroundColor:
                                darkMode ? Colors.white12 : Colors.black12,
                            value: indicatorProgressItem02,
                          ),
                        ),
                      ),
                    ),
                    //  indicador de vista :  item 3
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: LinearProgressIndicator(
                            minHeight: 5,
                            color: widget.colorAccent,
                            backgroundColor:
                                darkMode ? Colors.white12 : Colors.black12,
                            value: indicatorProgressItem03,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(child: widgets[index]),
          ],
        ),
        // controlamos los toques del usuario
        Row(
          children: [
            // toque izquierdo
            Flexible(
                child: InkWell(
                    onTap: leftTouch,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent)),
            //  toque derecho
            Flexible(
                child: InkWell(
                    onTap: rightTouch,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent)),
            //  touch
          ],
        ),
      ],
    );
  }

  //
  Widget pageView(
      {required BuildContext context,
      Color? colorContent,
      Color textColor = Colors.black,
      AssetImage? assetImage,
      IconData? iconData,
      Color? colorIcon,
      String titulo = "",
      String subtitulo = ""}) {
    // Definimos los estilos
    colorContent ??= Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;
    colorIcon ??= colorContent;
    final estiloTitulo = TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: textColor);
    final estiloSubTitulo =
        TextStyle(fontSize: 20.0, color: textColor.withOpacity(0.5));

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const Spacer(),
          assetImage != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image(
                      image: assetImage,
                      width: screenSize.width / 2,
                      height: screenSize.height / 2,
                      fit: BoxFit.contain),
                )
              : Container(),
          iconData != null
              ? Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(iconData,
                          size: screenSize.height * 0.10, color: colorIcon))
                  .animate(key: Key(subtitulo))
                  .move()
              : Container(),
          Text(titulo, style: estiloTitulo, textAlign: TextAlign.center),
          const SizedBox(height: 12.0),
          Text(subtitulo, style: estiloSubTitulo, textAlign: TextAlign.center),
          const SizedBox(height: 12.0),
          const Spacer(),
        ],
      ),
    ));
  }
}
