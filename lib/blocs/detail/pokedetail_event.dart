import 'package:equatable/equatable.dart';

abstract class PokeDetailEvent extends Equatable {
  const PokeDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadPokeDetail extends PokeDetailEvent {
  final String name;

  LoadPokeDetail({required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'LoadPokeDetail { name: $name}';
}
