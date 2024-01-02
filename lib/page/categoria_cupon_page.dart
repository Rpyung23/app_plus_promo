import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

import '../util/color.dart';
import '../util/dimensiones.dart';
import '../util/textos.dart';

class CategoriaCuponPage extends StatefulWidget {
  const CategoriaCuponPage({super.key});

  @override
  State<CategoriaCuponPage> createState() => _CategoriaCuponPageState();
}

class _CategoriaCuponPageState extends State<CategoriaCuponPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
        _getBody()
      ],
    );
  }

  Widget _getBody() {
    return Container(
      padding: EdgeInsets.only(
          right: marginSmall, left: marginSmall, top: marginSmall),
      child: ListView(
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
          SizedBox(height: marginSmall),
          Text(
            txt_categorias,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: textBig),
          ),
          SizedBox(height: marginSmall),
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
      ),
    );
  }

  Widget _getCategorias() {
    return Card(
        child: Container(
      padding: EdgeInsets.all(marginSmallSmall),
      child: Row(
        children: [
          Image.asset('./assets/pizza.png'),
          SizedBox(
            width: marginSmallSmall,
          ),
          const Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card_categoria,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                card_detalle_categoria,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ))
        ],
      ),
    ));
  }
}
