import 'package:card_keeper/data/models/deck.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DecksRepository extends StateNotifier<List<Deck>> {
  
  DecksRepository() : super([]);

  Deck? searchDeck(String id) {
    return state.where((dk) => dk.id == id).firstOrNull;
  }

  addDeck(Deck deck) {
    state = [...state, deck];
  }

  removeDeck(Deck deck) {
    state.remove(deck);

    state.removeWhere((dk) => dk.id == deck.id);
  }

  updateDeck(Deck deck) {
    List<Deck> newState = [...state];
    int index = newState.indexWhere((p) => p.id == deck.id);
    newState[index] = deck;
    state = newState;
  }
}