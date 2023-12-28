import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plus_promo/util/color.dart';
import 'package:plus_promo/util/dimensiones.dart';
import 'package:plus_promo/util/icons.dart';
import 'package:plus_promo/util/textos.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: icon_home,label: bottom_navigator_inicio),
            BottomNavigationBarItem(icon: icon_work,label: bottom_navigator_cupones),
            BottomNavigationBarItem(icon: icon_profiile,label: bottom_navigator_perfil)
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color_primary,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radioContainer),
                      bottomRight: Radius.circular(radioContainer))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Container(
              margin: EdgeInsets.only(
                  top: marginMediumSmall,
                  left: marginSmall,
                  right: marginSmall),
              child: _getBody(),
            )
          ],
        ));
  }

  Widget _getBody() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  saluda_toolbar,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: color_secondary,
                      fontSize: textBig,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  sub_saluda_toolbar,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: color_secondary,
                      fontSize: textMedium,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
        SizedBox(height: marginSmall),
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: color_secondary,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radioSearch),
                      borderSide: BorderSide(color: color_secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_secondary)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_secondary)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color_secondary))),
            )),
            SizedBox(
              width: marginSmallSmall,
            ),
            CircleAvatar(
                backgroundColor: color_secondary,
                child: Icon(Iconsax.search_normal))
          ],
        ),
        SizedBox(
          height: marginSmallSmall,
        ),
        Card(
          margin: EdgeInsets.all(0),
          surfaceTintColor: color_secondary,
          color: color_secondary,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(txt_unete_ahorra),
                  SizedBox(
                    height: marginSmallSmall,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color_primary,
                      ),
                      child: Text(
                        txt_ir,
                        style: TextStyle(color: color_secondary),
                      ))
                ],
              )),
              Container(
                child: Image.asset('./assets/banner.png'),
              )
            ],
          ),
        ),
        SizedBox(height: marginMediumSmall),
        Text(
          txt_categorias,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: textBig),
        ),
        SizedBox(height: marginMediumSmall),
        ListView(
          shrinkWrap: true,
          children: [
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias(),
            _getCategorias()
          ],
        )
      ],
    );
  }

  Widget _getCategorias() {
    return Card(
        child: Container(
      padding: EdgeInsets.all(marginSmallSmall),
      child: Row(
        children: [
          Expanded(child: Image.asset('./assets/categoria.png')),
          const Expanded(
              child: Column(
            children: [
              Text(
                card_categoria,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                card_detalle_categoria,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ],
      ),
    ));
  }
}
