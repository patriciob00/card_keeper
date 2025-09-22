import 'package:card_keeper/data/models/pokemon_card.dart';

enum CardKind { pokemon, energy, trainer }

String kindLabel(CardKind k) {
  switch (k) {
    case CardKind.pokemon: return 'Pokémon';
    case CardKind.energy:  return 'Energia';
    case CardKind.trainer: return 'Treinador';
  }
}

CardKind kindOf(PokemonCard c) {
    final cat = (c.category ?? '').toLowerCase();
    if (cat.contains('pok') || cat == 'pokemon') return CardKind.pokemon;
    if (cat.contains('ener') || cat == 'energy') return CardKind.energy;
    return CardKind.trainer;
  }

