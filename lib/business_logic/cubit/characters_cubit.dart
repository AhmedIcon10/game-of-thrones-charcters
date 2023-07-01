import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/repository/characters_repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  final CharactersRepository charactersRepository;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

   List<dynamic> characters = [];
   late Character characterObj;
  List<dynamic> getAllCharacters ()
  {
    charactersRepository.getAllCharacters().then((characters) {
    emit(CharactersLoaded(characters));
    this.characters = characters;
    });
    return characters;
  }
}
