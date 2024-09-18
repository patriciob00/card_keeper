import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/repositories/pokemon_card_search_cache.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/storage/pokemon-card-storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PokemonCardsControler {
  final WidgetRef ref;
  const PokemonCardsControler({required this.ref});

  static final PokemonCardStorage _pkmnStorage = PokemonCardStorage();

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

      if(pokemonCard.pokemonCardSet?.logo != null) {
        pokemonCard.pokemonCardSet!.logo = '${pokemonCard.pokemonCardSet?.logo}.webp';
      }
      ref.read(pokemonCardsSearchProvider.notifier).addCard(pokemonCard);
      return pokemonCard;  
    }

    return null;
  }

  Future<void> saveCard(PokemonCard pokemonCard) async {
    await ref.read(pokemonCardsRepositoryProvider.notifier).addCard(pokemonCard);

    await _pkmnStorage.savePokemon(pokemonCard);
  }

  Future<void> removeCard(PokemonCard pokemon) async {
    await ref.read(pokemonCardsRepositoryProvider.notifier).removeCard(pokemon);

    await _pkmnStorage.removePokemon(pokemon);
  }

  Future<void> updateCard(PokemonCard pokemonCard) async {
    await ref.read(pokemonCardsRepositoryProvider.notifier).updateCard(pokemonCard);

    await _pkmnStorage.updatePokemon(pokemonCard);
  }

  bool pokemonIsAlreadyOnList(String cardId) {
    return ref.read(pokemonCardsRepositoryProvider.notifier).searchCard(cardId) != null;
  }

  List<PokemonCard> getCardsList() {
    return ref.watch<List<PokemonCard>>(pokemonCardsRepositoryProvider).toList();
  }

  Future<void> initializeCardsListFromDb() async {
    List<PokemonCard> cards = await _pkmnStorage.getPokemonCardList();

    await ref.read(pokemonCardsRepositoryProvider.notifier).addList(cards);
  }
}
