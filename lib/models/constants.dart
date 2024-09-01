import 'package:flutter/material.dart';

enum PokemonTypes {
  dark,
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  fairy,
  unknown,
  shadow,
}

Map<String, List<Color>> typesGradient = {
  'fire': [
    const Color(0xffEBA746),
    const Color(0xffA16A31),
    const Color(0xff694C33)
  ],
  'water': [],
  'dark': [],
  'normal': [],
  'fighting': [],
  'flying': [],
  'poison': [],
  'ground': [],
  'rock': [],
  'bug': [],
  'ghost': [],
  'steel': [],
  'grass': [],
  'electric': [],
  'psychic': [],
  'ice': [
    const Color(0xff9FE0DA),
    const Color(0xff5E9790),
    const Color(0xff425F5D)
  ],
  'dragon': [],
  'fairy': [],
  'unknown': [],
  'shadow': [],

};