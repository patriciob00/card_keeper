import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonCardsRepositoryProvider = StateNotifierProvider<PokemonCardsRepository, List<PokemonCard>>((ref) => PokemonCardsRepository(),); 

class PokemonCardsRepository extends StateNotifier<List<PokemonCard>> {
  
  PokemonCardsRepository() : super([]);

  PokemonCard? searchCard(String id) {
    return state.where((pk) => pk.id == id).firstOrNull;
  }

  addList(List<PokemonCard> cards) {
    state = cards;
  }

  addCard(PokemonCard pokemonCard) {
    state = [...state, pokemonCard];
  }

  removeCard(PokemonCard pokemonCard) {
    state = state.where((c) => c.id != pokemonCard.id).toList();
  }

  updateCard(PokemonCard pokemonCard) {
    List<PokemonCard> newState = [...state];
    int index = newState.indexWhere((p) => p.id == pokemonCard.id);
    newState[index] = pokemonCard;
    state = newState;
  }

  int get getTotalOfCards {
    return state.length;
  }
  
}