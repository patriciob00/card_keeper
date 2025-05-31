
import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/repositories/deck_repository.dart';
import 'package:card_keeper/storage/deck_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckController {
  final WidgetRef ref;
  const DeckController({required this.ref});

  static final DeckStorage _deckStorage = DeckStorage();

  Future<void> saveDeck(DeckModel deck) async {
    await ref.read(deckRepositoryProvider.notifier).addDeck(deck);
    await _deckStorage.saveDeck(deck);
  }

  Future<void> removeDeck(DeckModel deck) async {
    await ref.read(deckRepositoryProvider.notifier).removeDeck(deck.id);
    await _deckStorage.removeDeck(deck.id);
  }

  Future<void> updateDeck(DeckModel deck) async {
    await ref.read(deckRepositoryProvider.notifier).updateDeck(deck);
    await _deckStorage.updateDeck(deck);
  }

  List<DeckModel> getDecksList() {
    return ref.watch<List<DeckModel>>(deckRepositoryProvider).toList();
  }

  Future<void> initializeDeckListFromDb() async {
    List<DeckModel> decks = await _deckStorage.getDeckList();
    ref.read(deckRepositoryProvider.notifier).addList(decks);
  }

  DeckModel? getDeckById(String id) {
    return ref.read(deckRepositoryProvider.notifier).searchDeck(id);
  }
}
