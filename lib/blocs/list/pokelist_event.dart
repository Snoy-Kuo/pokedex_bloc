import 'package:equatable/equatable.dart';

abstract class PokeListEvent extends Equatable {
  const PokeListEvent();

  @override
  List<Object> get props => [];
}

class LoadPokeList extends PokeListEvent {}
