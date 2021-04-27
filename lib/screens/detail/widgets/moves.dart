import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_bloc.dart';
import 'package:pokedex_bloc/blocs/detail/pokedetail_state.dart';
import 'package:pokedex_bloc/utils/colorTheme.dart';
import 'package:pokedex_bloc/widgets/customWidget.dart';

class Moves extends StatelessWidget {
  final String? type;

  const Moves({this.type});

  @override
  Widget build(BuildContext context) {
    return _moves(context);
  }

  Widget _moves(BuildContext context) {
    final state = BlocProvider.of<PokeDetailBloc>(context, listen: false).state;
    if (!(state is PokeDetailLoaded)) return Container();
    if (state.pokemonDetail == null || state.pokemonDetail!.moves.length == 0) {
      return Container(
        child: Center(
          child: Text('No information available'),
        ),
      );
    }
    List<Widget> moves = state.pokemonDetail!.moves
        .map((f) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: setPrimaryColor(type).withAlpha(150),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 5,
                      offset: Offset(0, 2),
                      color: setPrimaryColor(type).withAlpha(150),
                      spreadRadius: 0),
                ],
              ),
              child: Text(
                f.move.name,
                style: TextStyle(
                    fontSize: getFontSize(context, 15),
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ))
        .toList();

    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Wrap(alignment: WrapAlignment.spaceBetween, children: moves)),
    );
  }
}
