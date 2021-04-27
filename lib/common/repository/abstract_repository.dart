import 'dart:async';
import 'dart:core';
import '../model/model.dart';

abstract class Repository {
  Future<Pokedex?> loadDex();

  Future<PokemonDetail?> loadDetail(String name);

  Future<PokemonSpecies?> loadSpecies(String name);
}
