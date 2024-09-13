import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PokemonCardStorage {
  final SharedPreferencesAsync pref = SharedPreferencesAsync();

  static var pokemonCardListId = 'pokemon_card_list';

  Future<void> savePokemon(PokemonCard pkmn) async {
    List<PokemonCard> cardList = await getPokemonCardList();

    cardList = [...cardList, pkmn];

    await savePokemonCardList(cardList);
  }

  Future<void> removePokemon(PokemonCard pkmn) async {
    List<PokemonCard> cardList = await getPokemonCardList();

    cardList.removeWhere((card) => card.id == pkmn.id);

    await savePokemonCardList(cardList);
  }

  Future<void> savePokemonCardList(List<PokemonCard> cards) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        cards.map((card) => pokemonCardToJson(card)).toList();
    
    await prefs.setStringList(pokemonCardListId, jsonStringList);
  }

  Future<List<PokemonCard>> getPokemonCardList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(pokemonCardListId);

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => pokemonCardFromJson(jsonString))
          .toList();
    }
    return [];
  }
}
