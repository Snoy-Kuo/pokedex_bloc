// To parse this JSON data, do
//
//     final pokemonDetail = pokemonDetailFromJson(jsonString);

import 'dart:convert';

PokemonDetail pokemonDetailFromJson(String str) {
  return PokemonDetail.fromJson(json.decode(str));
}

String pokemonDetailToJson(PokemonDetail data) => json.encode(data.toJson());

class PokemonDetail {
  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List<Ability> abilities;
  List<Species> forms;
  List<GameIndex> gameIndices;
  List<Move> moves;
  Species species;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;

  PokemonDetail({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.abilities,
    required this.forms,
    required this.gameIndices,
    required this.moves,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        id: json["id"],
        name: json["name"],
        baseExperience: json["base_experience"],
        height: json["height"],
        isDefault: json["is_default"],
        order: json["order"],
        weight: json["weight"],
        abilities: List<Ability>.from(
            json["abilities"].map((x) => Ability.fromJson(x))),
        forms:
            List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
        gameIndices: List<GameIndex>.from(
            json["game_indices"].map((x) => GameIndex.fromJson(x))),
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        species: Species.fromJson(json["species"]),
        sprites: Sprites.fromJson(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "base_experience": baseExperience,
        "height": height,
        "is_default": isDefault,
        "order": order,
        "weight": weight,
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
        "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "species": species.toJson(),
        "sprites": sprites.toJson(),
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
      };

  String? getPrimaryType() {
    if (types.isEmpty) {
      return null;
    } else {
      return types[0].type.name;
    }
  }

  String? getSecondaryType() {
    if (types.length < 2) {
      return null;
    } else {
      return types[1].type.name;
    }
  }
}

class Ability {
  bool isHidden;
  int slot;
  Species ability;

  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        isHidden: json["is_hidden"],
        slot: json["slot"],
        ability: Species.fromJson(json["ability"]),
      );

  Map<String, dynamic> toJson() => {
        "is_hidden": isHidden,
        "slot": slot,
        "ability": ability.toJson(),
      };
}

class Species {
  String name;
  String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class GameIndex {
  int gameIndex;
  Species version;

  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
        gameIndex: json["game_index"],
        version: Species.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "game_index": gameIndex,
        "version": version.toJson(),
      };
}

class HeldItem {
  Species item;
  List<HeldItemVersionDetail> versionDetails;

  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  factory HeldItem.fromJson(Map<String, dynamic> json) => HeldItem(
        item: Species.fromJson(json["item"]),
        versionDetails: List<HeldItemVersionDetail>.from(json["version_details"]
            .map((x) => HeldItemVersionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item": item.toJson(),
        "version_details":
            List<dynamic>.from(versionDetails.map((x) => x.toJson())),
      };
}

class HeldItemVersionDetail {
  int rarity;
  Species version;

  HeldItemVersionDetail({
    required this.rarity,
    required this.version,
  });

  factory HeldItemVersionDetail.fromJson(Map<String, dynamic> json) =>
      HeldItemVersionDetail(
        rarity: json["rarity"],
        version: Species.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "rarity": rarity,
        "version": version.toJson(),
      };
}

class LocationAreaEncounter {
  Species locationArea;
  List<LocationAreaEncounterVersionDetail> versionDetails;

  LocationAreaEncounter({
    required this.locationArea,
    required this.versionDetails,
  });

  factory LocationAreaEncounter.fromJson(Map<String, dynamic> json) =>
      LocationAreaEncounter(
        locationArea: Species.fromJson(json["location_area"]),
        versionDetails: List<LocationAreaEncounterVersionDetail>.from(
            json["version_details"]
                .map((x) => LocationAreaEncounterVersionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location_area": locationArea.toJson(),
        "version_details":
            List<dynamic>.from(versionDetails.map((x) => x.toJson())),
      };
}

class LocationAreaEncounterVersionDetail {
  int maxChance;
  List<EncounterDetail> encounterDetails;
  Species version;

  LocationAreaEncounterVersionDetail({
    required this.maxChance,
    required this.encounterDetails,
    required this.version,
  });

  factory LocationAreaEncounterVersionDetail.fromJson(
          Map<String, dynamic> json) =>
      LocationAreaEncounterVersionDetail(
        maxChance: json["max_chance"],
        encounterDetails: List<EncounterDetail>.from(
            json["encounter_details"].map((x) => EncounterDetail.fromJson(x))),
        version: Species.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "max_chance": maxChance,
        "encounter_details":
            List<dynamic>.from(encounterDetails.map((x) => x.toJson())),
        "version": version.toJson(),
      };
}

class EncounterDetail {
  int minLevel;
  int maxLevel;
  List<Species> conditionValues;
  int chance;
  Species method;

  EncounterDetail({
    required this.minLevel,
    required this.maxLevel,
    required this.conditionValues,
    required this.chance,
    required this.method,
  });

  factory EncounterDetail.fromJson(Map<String, dynamic> json) =>
      EncounterDetail(
        minLevel: json["min_level"],
        maxLevel: json["max_level"],
        conditionValues: List<Species>.from(
            json["condition_values"].map((x) => Species.fromJson(x))),
        chance: json["chance"],
        method: Species.fromJson(json["method"]),
      );

  Map<String, dynamic> toJson() => {
        "min_level": minLevel,
        "max_level": maxLevel,
        "condition_values":
            List<dynamic>.from(conditionValues.map((x) => x.toJson())),
        "chance": chance,
        "method": method.toJson(),
      };
}

class Move {
  Species move;
  List<VersionGroupDetail> versionGroupDetails;

  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        move: Species.fromJson(json["move"]),
        versionGroupDetails: List<VersionGroupDetail>.from(
            json["version_group_details"]
                .map((x) => VersionGroupDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
        "version_group_details":
            List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
      };
}

class VersionGroupDetail {
  int levelLearnedAt;
  Species versionGroup;
  Species moveLearnMethod;

  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.versionGroup,
    required this.moveLearnMethod,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      VersionGroupDetail(
        levelLearnedAt: json["level_learned_at"],
        versionGroup: Species.fromJson(json["version_group"]),
        moveLearnMethod: Species.fromJson(json["move_learn_method"]),
      );

  Map<String, dynamic> toJson() => {
        "level_learned_at": levelLearnedAt,
        "version_group": versionGroup.toJson(),
        "move_learn_method": moveLearnMethod.toJson(),
      };
}

class Sprites {
  String backFemale;
  String backShinyFemale;
  String backDefault;
  String frontFemale;
  String frontShinyFemale;
  String backShiny;
  String frontDefault;
  String frontShiny;

  Sprites({
    required this.backFemale,
    required this.backShinyFemale,
    required this.backDefault,
    required this.frontFemale,
    required this.frontShinyFemale,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backFemale: json["back_female"],
        backShinyFemale: json["back_shiny_female"],
        backDefault: json["back_default"],
        frontFemale: json["front_female"],
        frontShinyFemale: json["front_shiny_female"],
        backShiny: json["back_shiny"],
        frontDefault: json["front_default"],
        frontShiny: json["front_shiny"],
      );

  Map<String, dynamic> toJson() => {
        "back_female": backFemale,
        "back_shiny_female": backShinyFemale,
        "back_default": backDefault,
        "front_female": frontFemale,
        "front_shiny_female": frontShinyFemale,
        "back_shiny": backShiny,
        "front_default": frontDefault,
        "front_shiny": frontShiny,
      };
}

class Stat {
  int baseStat;
  int effort;
  Species stat;

  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}

class Type {
  int slot;
  Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromJson(json["type"]),
      );

  Map<String, dynamic> toJson() => {
        "slot": slot,
        "type": type.toJson(),
      };
}
