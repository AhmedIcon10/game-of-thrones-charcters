part of 'characters_cubit.dart';

abstract class CharactersStates {}

class CharactersInitial extends CharactersStates {}

class CharactersLoaded extends CharactersStates {
  final List<dynamic> characters;
  CharactersLoaded(this.characters);
}

class CharactersError extends CharactersStates {
  final String error;
  CharactersError(this.error);
}
