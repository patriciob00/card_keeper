import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:flutter/material.dart';

class PokemonCardsProvider extends ValueNotifier<List<PokemonCard>> {
  PokemonCardsProvider(super.value);

  addCard(PokemonCard pokemonCard) {
    value.add(pokemonCard);
  }

  removeCard(String id) {
    value.removeWhere((card)=> card.id == id);
  }

  int get getTotalOfCards {
    return value.length;
  }
  
}