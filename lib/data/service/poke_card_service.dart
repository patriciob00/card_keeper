import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/poke_card_api.dart';

class PokeCardService {
  final _api = PokeCardApi();

  Future<List<CardListItem>?> searchCard(String searchTerm) async {
    return _api.searchCard(searchTerm);
  }

  Future<PokemonCard?> getCardById(String cardId) async {
    return _api.getCardById(cardId);
  }
}