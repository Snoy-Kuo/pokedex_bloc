// Provides a Mock repository that can be used for testing in place of the real
// thing.

import '../model/model.dart';
import 'repository.dart';

class MockRepository extends Repository {
  final Duration delay;
  Pokedex? fakeDex;
  PokemonDetail? fakeDetail;
  PokemonSpecies? fakeSpecies;

  MockRepository([
    this.fakeDex,
    this.fakeDetail,
    this.fakeSpecies,
    this.delay = Duration.zero,
  ]);

  @override
  Future<Pokedex?> loadDex() async {
    return Future.delayed(delay, () => fakeDex);
  }

  @override
  Future<PokemonDetail?> loadDetail(String name) async {
    return Future.delayed(delay, () => fakeDetail);
  }

  @override
  Future<PokemonSpecies?> loadSpecies(String name) async {
    return Future.delayed(delay, () => fakeSpecies);
  }
}
