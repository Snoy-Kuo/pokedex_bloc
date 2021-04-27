import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_state.dart';
import 'package:pokedex_bloc/common/model/pokemonDetail.dart';
import 'package:pokedex_bloc/common/model/pokemonSpecies.dart';
import 'package:pokedex_bloc/screens/detail/widgets/about.dart';
import 'package:pokedex_bloc/screens/detail/widgets/baseState.dart';
import 'package:pokedex_bloc/screens/detail/widgets/moves.dart';
import 'package:pokedex_bloc/utils/colorTheme.dart';
import 'package:pokedex_bloc/widgets/customWidget.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonDetailPage extends StatefulWidget {
  PokemonDetailPage({required this.name});

  final String name;

  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  PokemonSpecies? pokemonSpecies;
  PokemonDetail? pokemonDetail;
  double opacity = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero, () async {
    //   BlocProvider.of<PokeDetailBloc>(context)
    //       .add(LoadPokeDetail(name: widget.name.toLowerCase().split(' ')[0]));
    // });
    super.initState();
  }

  Widget _pokemonInfo() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Text(
                (pokemonSpecies != null)
                    ? pokemonSpecies!.names
                        .firstWhere((x) => x.language.name == 'zh-Hant',
                            orElse: () => Name(
                                language: NameLinkModel(name: 'en', url: ''),
                                name: pokemonSpecies!.name))
                        .name
                    : '',
                style: TextStyle(
                    fontSize: getFontSize(context, 30),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: customText(
                '#' +
                    (pokemonSpecies == null
                        ? ''
                        : pokemonSpecies!.id.toString().padLeft(3, '0')),
                style: TextStyle(
                    fontSize: getFontSize(context, 20),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            _pokemonCategoryChip(pokemonDetail?.getPrimaryType() ?? null),
            SizedBox(width: 10),
            _pokemonCategoryChip(pokemonDetail?.getSecondaryType() ?? null),
          ],
        )
      ],
    );
  }

  Widget _pokemonCategoryChip(String? type) {
    if (type == null || type.isEmpty) {
      return Container();
    }
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 30,
        decoration: BoxDecoration(
            color: setSecondaryColor(type),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: <Widget>[
            Text(
              type,
              style: TextStyle(
                  color: Colors.white, fontSize: getFontSize(context, 16)),
            ),
            Image.asset(getTypeImage(type))
          ],
        ));
  }

  Widget _pokemonType() {
    if (pokemonSpecies != null &&
        pokemonSpecies!.genera != null &&
        pokemonSpecies!.genera!.length > 0) {
      var type = pokemonSpecies!.genera!
          .firstWhere((x) => x.language.name == 'zh-Hant')
          .genus;
      return customText(
        type,
        style: TextStyle(
            color: Colors.white60, fontSize: getFontSize(context, 18)),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeDetailBloc, PokeDetailState>(
      builder: (
        BuildContext context,
        PokeDetailState state,
      ) {
        if (state is PokeDetailLoaded) {
          pokemonSpecies = state.pokemonSpecies;
          pokemonDetail = state.pokemonDetail;
        }
        return Scaffold(
          backgroundColor: setPrimaryColor(
              (null == pokemonDetail) ? null : pokemonDetail!.getPrimaryType()),
          body: (state is PokeDetailLoading)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: getDimension(context, 60),
                      right: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          BackButton(color: Colors.white60),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 120,
                        left: 20,
                        width: MediaQuery.of(context).size.width - 40,
                        child: _pokemonInfo()),
                    Positioned(top: 160, right: 20, child: _pokemonType()),
                    SlidingUpPanel(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      onPanelSlide: (slide) {
                        setState(() {
                          opacity = slide;
                        });
                      },
                      minHeight: MediaQuery.of(context).size.height -
                          getDimension(context, 430),
                      maxHeight: MediaQuery.of(context).size.height -
                          getDimension(context, 200),
                      panel: Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(top: getFontSize(context, (20))),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        child: DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            backgroundColor: Colors.white,
                            appBar: TabBar(
                              indicatorColor: setPrimaryColor(
                                  pokemonDetail?.getPrimaryType() ?? null),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.black54,
                              indicatorPadding: EdgeInsets.symmetric(
                                  horizontal: getFontSize(context, 20)),
                              tabs: [
                                Tab(
                                  child: Text(
                                    'About',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: getFontSize(context, 13),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Base State',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: getFontSize(context, 13)),
                                  ),
                                ),
                                Tab(
                                  child: Text('Moves',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: getFontSize(context, 13),
                                      )),
                                ),
                              ],
                            ),
                            body: TabBarView(
                              children: [
                                About(),
                                BaseState(),
                                Moves(type: null),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: getDimension(context, 260),
                        height: getDimension(context, 200 * (1 - opacity)),
                        child: Opacity(
                          opacity: 1 - opacity,
                          child: Image(
                            image: customAdvanceNetworkImage(
                              pokemonSpecies?.getImgUrl() ?? '',
                            ),
                            fit: BoxFit.contain,
                          ),
                        )),
                  ],
                ),
        );
      },
    );
  }
}
