import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/blocs/list/pokelist_bloc.dart';
import 'package:pokedex_bloc/blocs/list/pokelist_state.dart';

import '../../widgets/customWidget.dart';
import 'widgets/pokemonCard.dart';

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              brightness: Brightness.dark,
              floating: false,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Pokedex',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline2!.color,
                    fontSize: getFontSize(context, 25),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            _PokemonList()
          ],
        ),
      ),
    );
  }
}

class _PokemonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokeListBloc, PokeListState>(builder: (
      BuildContext context,
      PokeListState state,
    ) {
      if (state is PokeListLoading) {
        return SliverGrid.count(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          children: [
            Center(child: CircularProgressIndicator()),
          ],
        );
      } else if (state is PokeListLoaded) {
        return SliverGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.4,
          children: state.pokeList == null
              ? []
              : state.pokeList!
                  .map(
                    (x) => PokemonCard(
                      model: x,
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/detail/${x.pokemonSpecies.name}');
                      },
                    ),
                  )
                  .toList(),
        );
      } else {
        return SliverGrid.count(
          crossAxisCount: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          children: [
            Center(child: Text('Something wrong..')),
          ],
        );
      }
    });
  }
}
