import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonCardsSearchProvider = StateNotifierProvider<PokemonCardsRepository, List<PokemonCard>>((ref) => PokemonCardsRepository(),); 

class PokemonCardsRepository extends StateNotifier<List<PokemonCard>> {
  
  PokemonCardsRepository() : super([]);

  PokemonCard? searchCard(String id) {
    return state.where((pk) => pk.id == id).firstOrNull;
  }

  addCard(PokemonCard pokemonCard) {
    state = [...state, pokemonCard];
  }

  removeCard(PokemonCard pokemonCard) {
    state.remove(pokemonCard);

    state.removeWhere((card) => card.id == pokemonCard.id);
  }

  int get getTotalOfCards {
    return state.length;
  }
  
}