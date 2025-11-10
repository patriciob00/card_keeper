enum CardVariant {
  normal('normal'),
  holo('holo'),
  reverse('reverse');

  final String code;
  const CardVariant(this.code);
  
  static CardVariant fromCode(String? code) {
    switch (code) {
      case 'holo':
        return CardVariant.holo;
      case 'reverse':
        return CardVariant.reverse;
      
      default:
        return CardVariant.normal;
    }
  }

  String get label {
    switch (this) {
      case CardVariant.holo:
        return 'Holo';
      case CardVariant.reverse:
        return 'Reverse Holo';
      default:
        return 'Normal';
    }
  }

  bool get isNormal => this == CardVariant.normal;
  bool get isHolo => this == CardVariant.holo;
  bool get isReverse => this == CardVariant.reverse;
}