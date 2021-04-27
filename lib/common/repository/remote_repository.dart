import 'package:http/http.dart';

import '../model/pokedex.dart';
import '../model/pokemonDetail.dart';
import '../model/pokemonSpecies.dart';
import 'abstract_repository.dart';
import 'constants.dart';

class RemoteRepository extends Repository {
  Future<Response?> _getAsync(String uri) async {
    var url = uri;
    print('Get Api Address :- ' + url);
    Response? response = await get(
      Uri.parse(url),
    );
    return response;
  }

  @override
  Future<Pokedex?> loadDex() async {
    try {
      print('loadDex');

      var url = apiBaseUri + apiPokemonList;
      var response = await _getAsync(url);
      if (response != null) {
        if (response.statusCode != 200) {
          print('API Status code error' + response.body);
        }
        print('Api call success');
        return pokedexResponseFromJson(response.body);
      }
    } catch (error) {
      print('ERROR(loadDex) : $error');
      return null;
    }
  }

  @override
  Future<PokemonDetail?> loadDetail(String name) async {
    try {
      print('loadDetail');

      var url = apiBaseUri + apiPokemonDetail + name;
      var response = await _getAsync(url);
      if (response != null) {
        if (response.statusCode != 200) {
          print('API Status code error' + response.body);
        }
        print('Api call success response');
        return pokemonDetailFromJson(response.body);
      }
    } catch (error) {
      print('ERROR(loadDetail) : $error');
      return null;
    }
  }

  @override
  Future<PokemonSpecies?> loadSpecies(String name) async {
    try {
      print('loadSpecies');

      var url = apiBaseUri + apiPokemonSpecies + name;
      var response = await _getAsync(url);
      if (response != null) {
        if (response.statusCode != 200) {
          print('API Status code error' + response.body);
        }
        print('Api call success}');
        return pokemonSpeciesFromJson(response.body);
      }
    } catch (error) {
      print('ERROR(loadDetail) : $error');
      return null;
    }
  }
}
