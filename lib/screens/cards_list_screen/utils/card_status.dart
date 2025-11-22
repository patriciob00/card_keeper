import 'package:card_keeper/data/models/card_variant.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/filter_functions.dart';

class CardsStats {
  final int total;
  final Map<CardKind, int> perKind;
  final Map<String, int> perColection;
  final Map<String, int> pokemonPerType;
  final Map<CardVariant, int> perVariant;
  CardsStats({
    required this.total,
    required this.perKind,
    required this.perColection,
    required this.pokemonPerType,
    required this.perVariant,
  });
}