// To parse this JSON data, do
//
//     final welcome = pokemonListResponseFromJson(jsonString);

import 'dart:convert';

Pokedex pokedexResponseFromJson(String str) {
  return Pokedex.fromJson(json.decode(str));
}

String pokedexResponse(Pokedex data) => json.encode(data.toJson());

class PokemonSpeciesEntryModel {
  PokemonSpeciesEntryModel({required this.name});

  String name;

  factory PokemonSpeciesEntryModel.fromJson(Map<String, dynamic> json) =>
      PokemonSpeciesEntryModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class PokemonEntryModel {
  PokemonEntryModel({required this.entryNumber, required this.pokemonSpecies});

  int entryNumber;
  PokemonSpeciesEntryModel pokemonSpecies;

  factory PokemonEntryModel.fromJson(Map<String, dynamic> json) =>
      PokemonEntryModel(
        entryNumber: json["entry_number"],
        pokemonSpecies:
            PokemonSpeciesEntryModel.fromJson(json["pokemon_species"]),
      );

  Map<String, dynamic> toJson() => {
        "entry_number": entryNumber,
        "pokemon_species": pokemonSpecies.toJson(),
      };

  String getImgUrl() {
    return 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/${entryNumber.toString().padLeft(3, '0')}.png';
  }
}

class Pokedex {
  List<PokemonEntryModel> pokemonEntries;

  Pokedex({
    required this.pokemonEntries,
  });

  factory Pokedex.fromJson(Map<String, dynamic> json) => Pokedex(
        pokemonEntries: List<PokemonEntryModel>.from(
            json["pokemon_entries"].map((x) => PokemonEntryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pokemon_entries":
            List<dynamic>.from(pokemonEntries.map((x) => x.toJson())),
      };
}
