import 'package:equatable/equatable.dart';
import 'package:pokedex_bloc/common/model/pokemonDetail.dart';
import 'package:pokedex_bloc/common/model/pokemonSpecies.dart';

abstract class PokeDetailState extends Equatable {
  const PokeDetailState();

  @override
  List<Object> get props => [];
}

class PokeDetailLoading extends PokeDetailState {}

class PokeDetailLoaded extends PokeDetailState {
  final PokemonDetail? pokemonDetail;

  final PokemonSpecies? pokemonSpecies;

  const PokeDetailLoaded(
      {required this.pokemonDetail, required this.pokemonSpecies});

  @override
  List<Object> get props => [
        (pokemonDetail == null),
        (pokemonDetail == null) ? -1 : pokemonDetail!.id
      ];

  @override
  String toString() =>
      'PokeDetailLoaded { pokemonDetail: $pokemonDetail,  pokemonSpecies: $pokemonSpecies}';
}

class PokeDetailNotLoaded extends PokeDetailState {}
