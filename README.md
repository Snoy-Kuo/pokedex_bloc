# pokedex_bloc

Pokedex App using Bloc to manage state.

## References

 - [flutte_pokedex](https://github.com/TheAlphamerc/flutter_pokedex).
 - [flutter_architecture_samples](https://github.com/brianegan/flutter_architecture_samples/tree/master/change_notifier_provider).

## API

 - Visit [PokeApi website](https://pokeapi.co/) for detail.
 - Get pokedex <br/>
   use: `/pokedex/[#]/` , [#]: number of pokedex.
 - Get pokemon types, size, baseExperience, stats, Abilities, Moves <br/>
   use: `/pokemon/[name]`, [name]: name of Pokemon.
 - Get pokemon Name, Id, Description, Genus, Egg Groups, Shape, Habitat, Seen At, Color, Capture Rate <br/>
   use: `/pokemon-species/[name]`, [name]: name of Pokemon.

## Packages

 - [flutter_bloc](https://pub.dev/packages/flutter_bloc)
 - [equatable](https://pub.dev/packages/equatable)
 - [http](https://pub.dev/packages/http)
 - [cached_network_image](https://pub.dev/packages/cached_network_image)
 - [sliding_up_panel](https://pub.dev/packages/sliding_up_panel)

## Dev env

 - macOS 11.2.3 (Big Sur) x64
 - Flutter 2.0.5
 - Dart 2.12.3
 - Android Studio 4.1.3
 - Dart Plugin 201.9380
 - Flutter Plugin 55.1.1
 - Android SDK version 30.0.3
 - Xcode 12.4
 - CocoaPods 1.10.1
 - Chrome 90.0.4430.85

## Try

 - collect all label texts to a localized class.
 - add local storage as cache for next query.
 - add a FAB on list screen, when tap on FAB shows 2 sub buttons: search by name or id, filter by generation.
 - add search input and search result page.
 - add generation selection bottom dialog.
 - add favorite toggle button on detail page. add show favorites/all func in FAB sub button.
 - add unit tests, widget tests, and integration tests.


  The final result is on final_result branch. (not finished yet)