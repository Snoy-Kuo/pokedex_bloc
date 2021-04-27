import 'package:equatable/equatable.dart';
import 'package:pokedex_bloc/common/model/pokedex.dart';

abstract class PokeListState extends Equatable {
  const PokeListState();

  @override
  List<Object> get props => [];
}

class PokeListLoading extends PokeListState {}

class PokeListLoaded extends PokeListState {
  final List<PokemonEntryModel>? pokeList;

  const PokeListLoaded([this.pokeList = const []]);

  @override
  List<Object> get props =>
      [(pokeList == null), (pokeList == null) ? -1 : pokeList!.length];

  @override
  String toString() => 'PokeListLoaded { pokeList: $pokeList }';
}

class PokeListNotLoaded extends PokeListState {}
