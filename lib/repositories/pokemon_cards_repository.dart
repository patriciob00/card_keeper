import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pokemonCardsRepositoryProvider = StateNotifierProvider<PokemonCardsRepository, List<PokemonCard>>((ref) => PokemonCardsRepository(),); 

class PokemonCardsRepository extends StateNotifier<List<PokemonCard>> {
  
  PokemonCardsRepository() : super([]);

  PokemonCard? searchCard(String id) {
    return state.where((pk) => pk.id == id).firstOrNull;
  }

  PokemonCard? searchByUniqueId(String uniqueId) {
    return state.where((pk) => pk.uniqueId == uniqueId).firstOrNull;
  }

  List<PokemonCard> getVariants(String baseId) {
    return state.where((pk) => pk.id == baseId).toList();
  }

  PokemonCard? getMostOwnedVariant(String baseId) {
    final variants = getVariants(baseId);
    if (variants.isEmpty) return null;
    variants.sort((a, b) =>
        (b.cardQuantity ?? 0).compareTo(a.cardQuantity ?? 0));
    return variants.first;
  }

  addList(List<PokemonCard> cards) {
    state = cards;
  }

  addCard(PokemonCard card) {
    if (state.any((c) => c.uniqueId == card.uniqueId)) {
      updateCard(card);
    } else {
      state = [...state, card];
    }
  }


  removeCard(PokemonCard card) {
    state = state.where((c) => c.uniqueId != card.uniqueId).toList();
  }


  updateCard(PokemonCard pokemonCard) {
    final index = state.indexWhere((c) => c.uniqueId == pokemonCard.uniqueId);
    if (index == -1) {
      addCard(pokemonCard);
    } else {
      final List<PokemonCard> newState = [...state];
      newState[index] = pokemonCard;
      state = newState;
    }
  }

  int get getTotalOfCards => state.length;

  int get totalOfCopies => state.fold(0, (sum, c) => sum + (c.cardQuantity ?? 0));

  int getTotalForBaseId(String baseId) => 
    state.where((c) => c.id == baseId)
    .fold(0, (sum, c) => sum + (c.cardQuantity ?? 0));
  
}