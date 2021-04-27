import 'package:flutter/material.dart';
import 'package:pokedex_bloc/common/model/pokedex.dart';

import '../../../utils/utils.dart';
import '../../../widgets/customWidget.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({Key? key, required this.model, required this.onPressed})
      : super(key: key);

  final PokemonEntryModel model;
  final Function() onPressed;

  Widget _pokemonTypeWidget(BuildContext context, String? type, Color color) {
    if (null == type || type.isEmpty) {
      return SizedBox();
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Text(
          type,
          style: TextStyle(
              color: Colors.white60,
              fontSize: getFontSize(context, 10),
              fontWeight: FontWeight.w600),
        ),
      );
    }
  }

  String getId(String id) {
    return '#' + id.toString().padLeft(3, '0');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          margin: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
          decoration: BoxDecoration(
              color: setPrimaryColor(null),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              ///[Pokemon ID]
              Positioned(
                bottom: getDimension(context, 10),
                left: getDimension(context, 10),
                child: customText(getId(model.entryNumber.toString()),
                    style: TextStyle(
                        color: setSecondaryColor(null),
                        fontSize: getFontSize(context, 12),
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis),
              ),

              ///[Pokeball]
              Positioned(
                  bottom: 0,
                  right: 0,
                  height: getDimension(context, 80),
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor(null),
                    height: getDimension(context, 150),
                  )),

              /// [Name, Type]
              Positioned(
                  top: getDimension(context, 20),
                  left: getDimension(context, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: fullWidth(context) * .3,
                        child:
                            customText(model.pokemonSpecies.name.capitalize(),
                                context: context,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getFontSize(context, 14),
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start),
                      ),
                      _pokemonTypeWidget(
                          context, null, setSecondaryColor(null)),
                      SizedBox(
                        height: 5,
                      ),
                      _pokemonTypeWidget(
                          context, null, setSecondaryColor(null)),
                    ],
                  )),

              /// [Image]
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Hero(
                    tag: model.entryNumber,
                    child: Image(
                      image: customAdvanceNetworkImage(
                        model.getImgUrl(),
                      ),
                      fit: BoxFit.contain,
                      height: getDimension(context, 70),
                    ),
                  ))
            ],
          )),
    );
  }
}
