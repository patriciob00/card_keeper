import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_keeper/data/models/deck_model.dart';
import 'package:collection/collection.dart';


class DeckRepository extends StateNotifier<List<DeckModel>> {
  DeckRepository() : super([]);

  void addList(List<DeckModel> decks) {
    state = [...decks];
  }

  DeckModel? searchDeck(String id) {
    return state.firstWhereOrNull((deck) => deck.id == id);
  }

  Future<void> addDeck(DeckModel deck) async {
    state = [...state, deck];
  }

  Future<void> removeDeck(String deckId) async {
    state = state.where((deck) => deck.id != deckId).toList();
  }

  Future<void> updateDeck(DeckModel deck) async {
    int index = state.indexWhere((d) => d.id == deck.id);
    if (index != -1) {
      List<DeckModel> updated = [...state];
      updated[index] = deck;
      state = updated;
    }
  }

  Future<void> addDeckList(List<DeckModel> decks) async {
    state = [...state, ...decks];
  }

  DeckModel? getDeckById(String id) {
    return state.firstWhereOrNull((deck) => deck.id == id);
  }
}

final deckRepositoryProvider = StateNotifierProvider<DeckRepository, List<DeckModel>>(
  (ref) => DeckRepository(),
);