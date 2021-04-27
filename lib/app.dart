import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/screens/detail/pokemonDetailPage.dart';
import 'package:pokedex_bloc/screens/list/pokemon_list.dart';

import 'blocs/detail/pokedetail_bloc.dart';
import 'blocs/detail/pokedetail_event.dart';
import 'blocs/list/pokelist_bloc.dart';
import 'blocs/list/pokelist_event.dart';
import 'common/repository/repository.dart';
import 'common/route/routes.dart';
import 'common/theme/theme.dart';

class App extends StatelessWidget {
  final Repository repository;

  App({required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      title: 'Pokedex Provider',
      routes: {
        AppRoutes.home: (context) => BlocProvider<PokeListBloc>(
              create: (context) =>
                  PokeListBloc(repository: repository)..add(LoadPokeList()),
              child: PokemonListScreen(),
            ),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name!.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'detail') {
          var name = pathElements[2];
          return MaterialPageRoute<bool>(
            builder: (context) => BlocProvider<PokeDetailBloc>(
              create: (context) => PokeDetailBloc(repository: repository)..add(LoadPokeDetail(name: name.toLowerCase().split(' ')[0])),
              child: PokemonDetailPage(name: name),
            ),
          );
        }
        return null;
      },
    );
  }
}
