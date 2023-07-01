import 'package:breaking_bad/data/models/characters_model.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';

class CharactersRepository
{
   final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

   Future<dynamic> getAllCharacters() async
   {
     final characters = await charactersWebServices.getAllCharacters();
     var mapCharacters = characters.map((character)=> Character.fromJson(character)).toList();
     return mapCharacters;
   }
}