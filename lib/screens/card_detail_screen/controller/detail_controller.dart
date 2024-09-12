import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/repositories/pokemon_card_search_cache.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailControler {
  final WidgetRef ref;
  const DetailControler({required this.ref});

  Future<PokemonCard?> getCard(String cardId) async {
    final foundOnList =
        ref.read(pokemonCardsRepositoryProvider.notifier).searchCard(cardId);

    if(foundOnList != null) return foundOnList;

    final foundOnSearchCache = ref.read(pokemonCardsSearchProvider.notifier).searchCard(cardId);

    if(foundOnSearchCache != null) return foundOnSearchCache;

    late PokemonCard? pokemonCard;
    final pokeCardService = PokeCardService();
    pokemonCard = await pokeCardService.getCardById(cardId);

    if (pokemonCard != null) { 
      pokemonCard.image = '${pokemonCard.image}/high.webp';
      ref.read(pokemonCardsSearchProvider.notifier).addCard(pokemonCard);
      return pokemonCard;  
    }

    return null;
  }

  Future<void> saveCard(PokemonCard pokemonCard, int quantity) async {
    pokemonCard.cardQuantity = quantity;
    await ref.read(pokemonCardsRepositoryProvider.notifier).addCard(pokemonCard);
  }

  Future<void> removeCard(PokemonCard pokemon) async {
    await ref.read(pokemonCardsRepositoryProvider.notifier).removeCard(pokemon);
  }

  bool pokemonIsAlreadyOnList(String cardId) {
    return ref.read(pokemonCardsRepositoryProvider.notifier).searchCard(cardId) != null;
  }
}
