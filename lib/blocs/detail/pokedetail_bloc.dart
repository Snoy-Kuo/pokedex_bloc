import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_event.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_state.dart';
import 'package:pokedex_bloc/common/model/model.dart';
import 'package:pokedex_bloc/common/repository/abstract_repository.dart';

class PokeDetailBloc extends Bloc<PokeDetailEvent, PokeDetailState> {
  final Repository repository;

  PokeDetailBloc({required this.repository}) : super(PokeDetailLoading());

  @override
  Stream<PokeDetailState> mapEventToState(PokeDetailEvent event) async* {
    if (event is LoadPokeDetail) {
      yield* _mapLoadPokeDetailToState(event.name);
    }
  }

  Stream<PokeDetailState> _mapLoadPokeDetailToState(String name) async* {
    try {
      yield PokeDetailLoading();

      final PokeDetailState? detail = (await loadDetailAndSpecies(name));
      yield detail ?? PokeDetailNotLoaded();
    } catch (error) {
      log('_mapLoadPokeDetailToState error=$error');
      yield PokeDetailNotLoaded();
    }
  }

  Future<PokeDetailState> loadDetailAndSpecies(String name) async {
    return await Future.wait(
      [
        repository.loadDetail(name),
        repository.loadSpecies(name),
      ],
    ).then((list) {
      return PokeDetailLoaded(
        pokemonDetail: list[0] as PokemonDetail?,
        pokemonSpecies: list[1] as PokemonSpecies?,
      );
    });
  }
}
