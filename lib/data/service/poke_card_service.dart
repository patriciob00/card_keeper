import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/providers/poke_card_api.dart';

class PokeCardService {
  final _api = PokeCardApi();

  Future<List<CardListItem>?> searchCard(String searchTerm) async {
    return _api.searchCard(searchTerm);
  }
}