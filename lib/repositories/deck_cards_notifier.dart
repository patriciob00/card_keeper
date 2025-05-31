import 'package:card_keeper/extensions/deck_card_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_keeper/data/models/deck_card.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';

final deckCardsProvider =
    StateNotifierProvider<DeckCardsNotifier, List<DeckCard>>((ref) {
  return DeckCardsNotifier();
});

class DeckCardsNotifier extends StateNotifier<List<DeckCard>> {
  DeckCardsNotifier() : super([]);

  void addCard(PokemonCard card, int quantity) {
    final index = state.indexWhere((c) => c.id == card.id);

    if (index >= 0) {
      // Atualiza a quantidade se já existir
      final updated = [...state];
      updated[index] = updated[index].copyWith(deckRequiredQuantity: quantity);
      state = updated;
    } else {
      // Cria novo DeckCard
      final newCard = DeckCardMapper.fromPokemonCard(card).copyWith(
        deckRequiredQuantity: quantity,
      );
      state = [...state, newCard];
    }
  }

  void removeCard(String cardId) {
    state = state.where((c) => c.id != cardId).toList();
  }

  void clear() {
    state = [];
  }
}