import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/common/repository/abstract_repository.dart';
import 'pokelist_event.dart';
import 'pokelist_state.dart';

class PokeListBloc extends Bloc<PokeListEvent, PokeListState> {
  final Repository repository;

  PokeListBloc({required this.repository}) : super(PokeListLoading());

  @override
  Stream<PokeListState> mapEventToState(PokeListEvent event) async* {
    if (event is LoadPokeList) {
      yield* _mapLoadPokeListToState();
    }
  }

  Stream<PokeListState> _mapLoadPokeListToState() async* {
    try {
      final pokedex = await repository.loadDex();
      yield PokeListLoaded(
        pokedex!.pokemonEntries,
      );
    } catch (_) {
      yield PokeListNotLoaded();
    }
  }
}
