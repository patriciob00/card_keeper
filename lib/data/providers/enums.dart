// ignore_for_file: constant_identifier_names

enum PokemonTypesIcon {
  dragao('Dragão', 'assets/images/types_badge/dragon.png'),
  eletrico('Elétrico', 'assets/images/types_badge/electric.png'),
  normal('Incolor', 'assets/images/types_badge/normal.png'),
  fada('Fada', 'assets/images/types_badge/fairy.png'),
  fogo('Fogo', 'assets/images/types_badge/fire.png'),
  lutador('Lutador', 'assets/images/types_badge/fighting.png'),
  metal('Metal', 'assets/images/types_badge/steel.png'),
  planta('Planta', 'assets/images/types_badge/grass.png'),
  Psiquico('Psíquico', 'assets/images/types_badge/psychic.png'),
  sombrio('Sombrio', 'assets/images/types_badge/dark.png'),
  agua('Água', 'assets/images/types_badge/water.png');

  final String typeName;
  final String iconSrc;

  const PokemonTypesIcon(this.typeName, this.iconSrc);

  getIcon(String type) {
    return PokemonTypesIcon.values.firstWhere((t) => t.typeName == type);
  }
}