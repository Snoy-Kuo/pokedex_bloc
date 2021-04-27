import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_state.dart';
import 'package:pokedex_bloc/widgets/customWidget.dart';

class About extends StatefulWidget {
  const About();

  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isExpanded = false;

  Widget _aboutSection() {
    final state = BlocProvider.of<PokeDetailBloc>(context, listen: false).state;
    if (!(state is PokeDetailLoaded)) return Container();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _description(),
            Container(
              height: getFontSize(context, 70),
              margin: EdgeInsets.only(bottom: getFontSize(context, 10)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.grey.withOpacity(.2),
                      offset: Offset(0, 5),
                    )
                  ]),
              padding: EdgeInsets.symmetric(
                  horizontal: 30, vertical: getFontSize(context, 10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Weight',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Circular-bold',
                            fontSize: getFontSize(context, 14)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      customText(
                        '${state.pokemonDetail?.weight} kg',
                        style: TextStyle(fontSize: getFontSize(context, 14)),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Height',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Circular-bold',
                            fontSize: getFontSize(context, 14)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${state.pokemonDetail?.height} cm',
                        style: TextStyle(fontSize: getFontSize(context, 14)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Breeding',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getFontSize(context, 14)),
            ),
            SizedBox(height: 10),
            _eggGroup(),
            SizedBox(height: 14),
            Text(
              'Training',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getFontSize(context, 15)),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Base EXP',
                  style: TextStyle(
                      fontSize: getFontSize(context, 14),
                      color: Colors.black45),
                ),
                SizedBox(
                  width: 50,
                ),
                customText(
                  state.pokemonDetail?.baseExperience.toString(),
                  style: TextStyle(
                      fontSize: getFontSize(context, 14),
                      color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    final state = BlocProvider.of<PokeDetailBloc>(context, listen: false).state;
    if (!(state is PokeDetailLoaded)) return Container();
    if (state.pokemonSpecies == null ||
        state.pokemonSpecies!.flavorTextEntries.length == 0) {
      return Container();
    }
    var list = state.pokemonSpecies!.flavorTextEntries
        .where((x) => x.language.name == 'zh-Hant')
        .toSet()
        .toList();
    list = list.toSet().toList();
    list.forEach((x) => x.flavorText..replaceAll("\n", " "));
    String desc = '';
    StringBuffer description = new StringBuffer();

    for (int i = 0; i < list.length; i++) {
      var it = list[i].flavorText.replaceAll("\n", " ");
      if (!desc.toString().toLowerCase().contains(it.toLowerCase())) {
        description.write(it + ' ');
        desc += it + ' ';
      }
    }

    var wid =
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
      ConstrainedBox(
        constraints:
            isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 58.0),
        child: Text(
          description.toString().replaceAll("\n", " "),
          softWrap: true,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: getFontSize(context, 14),
          ),
          textAlign: TextAlign.justify,
        ),
      ),
      TextButton(
          child: Text(
            !isExpanded ? 'more...' : 'Less...',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () => setState(() => isExpanded = !isExpanded))
    ]);

    return wid;
  }

  Widget _eggGroup() {
    final state = BlocProvider.of<PokeDetailBloc>(context, listen: false).state;
    if (!(state is PokeDetailLoaded)) return Container();
    if (state.pokemonSpecies == null ||
        state.pokemonSpecies!.eggGroups.length == 0) {
      return Container();
    }
    var list = state.pokemonSpecies!.eggGroups;
    return Container(
        width: fullWidth(context),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text('Egg Groups',
                  style: TextStyle(
                      fontSize: getFontSize(context, 14),
                      color: Colors.black45)),
            ),
            Expanded(
              flex: 2,
              child: Wrap(
                children: list.map((x) {
                  return Container(
                      child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: customText(x.name,
                              style: TextStyle(
                                  fontSize: getFontSize(context, 14),
                                  color: Colors.black87))));
                }).toList(),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _aboutSection();
  }
}
