import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:flutter/material.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/widgets/card_with_ripple.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardWithRippleAndFlipV2 extends StatefulWidget {
  const CardWithRippleAndFlipV2({
    super.key,
    required this.tag,
    required this.imageURL,
    required this.currentPokemon,
    this.onTap,
    this.onLongPress,
    this.isAlreadyOnList = false,
    this.width,
    this.aspectRatio = 63 / 88,
  });

  final String tag;
  final String imageURL;

  final PokemonCard currentPokemon;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isAlreadyOnList;

  final double? width;
  final double aspectRatio;

  @override
  State<CardWithRippleAndFlipV2> createState() => _CardWithRippleAndFlipState();
}

class _CardWithRippleAndFlipState extends State<CardWithRippleAndFlipV2>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _flip() async {
    setState(() => _isFront = !_isFront);
    if (_isFront) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width;
    final cardW = widget.width ?? screenW * 0.6;
    final cardH = cardW / widget.aspectRatio;

    Matrix4 base(double radians) => Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(radians);

    return SizedBox(
      width: cardW,
      height: cardH,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          final angle = _controller.value * pi; // 0 -> π
          final frontVisible = angle <= (pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform: base(angle),
            child: frontVisible
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox.expand(
                      child: CardWithRipple(
                        tag: widget.tag,
                        imageURL: widget.imageURL,
                        onTap: widget.onTap ?? _flip,
                        onLongPress: widget.onLongPress,
                      ),
                    ),
                  )
                : Transform(
                    alignment: Alignment.center,
                    transform: base(-pi),
                    child: _CardBackFace(
                      size: size,
                      onTap: widget.onTap ?? _flip,
                      isAlreadyOnList: widget.isAlreadyOnList,
                      currentCard: widget.currentPokemon,
                    ),
                  ),
          );
        },
      ),
    );
  }
}

/// Face de trás da carta: imagem do verso + overlay informativo (opcional).
class _CardBackFace extends StatelessWidget {
  const _CardBackFace({
    required this.onTap,
    required this.isAlreadyOnList,
    required this.currentCard,
    this.borderRadius = 20,
    required this.size,
  });

  final Function? onTap;
  final bool isAlreadyOnList;
  final PokemonCard currentCard;
  final double? borderRadius;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final cardSize = Size(constraints.maxWidth, constraints.maxHeight);
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius!),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/card-back.png'),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
                CardBackInfo(
                  size: cardSize,
                  currentCard: currentCard,
                  isAlreadyOnList: isAlreadyOnList,
                ),
                Positioned.fill(
                  child: Material(
                    borderRadius: BorderRadius.circular(borderRadius!),
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => onTap != null ? onTap!() : null,
                      splashColor: Colors.white24,
                      borderRadius: BorderRadius.circular(borderRadius!),
                    )
                  )
                ),
              ],
            ),
        );
      },
    );
  }
}

class CardBackInfo extends StatelessWidget {
  const CardBackInfo(
      {super.key,
      this.currentCard,
      this.isAlreadyOnList = false,
      required this.size});

  final bool isAlreadyOnList;
  final PokemonCard? currentCard;
  final Size size;

  Widget typeIcon(String typeName) {
    PokemonTypesIcon? iconBadge = PokemonTypesIcon.values
        .where((t) => t.typeName == typeName)
        .firstOrNull;

    if (iconBadge != null) {
      return Padding(
        padding: EdgeInsets.all(size.width * 0.009),
        child: Image.asset(
          fit: BoxFit.contain,
          iconBadge.iconSrc,
          width: size.width * 0.18,
        ),
      );
    }

    return const SizedBox(
      width: double.minPositive,
      height: double.minPositive,
    );
  }

  List<Widget> typesList(List<String>? list) {
    if (list == null) return [];

    return list.map((e) => typeIcon(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isExpandedAllowed = currentCard?.legal?.expanded == true;
    final isStandardAllowed = currentCard?.legal?.standard == true;

    final infoPadding = EdgeInsets.only(
        top: size.height * 0.03,
        left: size.height * 0.05,
        right: size.height * 0.03,
        bottom: size.height * 0.005);

    return Positioned(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withValues(alpha: 0.7)),
        child: Padding(
          padding: EdgeInsets.only(
              bottom: size.height * 0.03, top: size.height * 0.01),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.height * 0.025,
                      vertical: size.width * 0.045),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentCard?.name ?? '',
                              style: TextStyle(
                                fontSize: size.height * 0.045,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(3.0, 1.0),
                                    blurRadius: 4.0,
                                    color: Color.fromARGB(60, 251, 251, 251),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              currentCard?.rarity ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: size.height * 0.04,
                                shadows: const [
                                  Shadow(
                                    offset: Offset(3.0, 1.0),
                                    blurRadius: 4.0,
                                    color: Color.fromARGB(60, 251, 251, 251),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: typesList(currentCard?.types),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (currentCard!.pokemonCardSet!.logo != null)
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.03,
                        left: size.height * 0.05,
                        right: size.height * 0.03,
                        bottom: size.height * 0.015),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Coleção: ',
                          style: TextStyle(
                            fontSize: size.height * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(3.0, 1.0),
                                blurRadius: 4.0,
                                color: Color.fromARGB(60, 251, 251, 251),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.01,
                                right: size.width * 0.035),
                            child: CachedNetworkImage(
                              imageUrl: currentCard!.pokemonCardSet!.logo ?? '',
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              width: size.width * 0.25,
                            ))
                      ],
                    ),
                  ),
                if (currentCard?.pokemonCardSet?.logo == null)
                  Padding(
                    padding: infoPadding,
                    child: SizedBox(
                      height: size.height * 0.10,
                    ),
                  ),
                Padding(
                  padding: infoPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Padrão: ',
                        style: TextStyle(
                          fontSize: size.height * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.035),
                          child: Icon(
                            isStandardAllowed
                                ? Symbols.check
                                : Symbols.block_sharp,
                            size: size.width * 0.06,
                            color:
                                isStandardAllowed ? Colors.green : Colors.red,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: infoPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Expandido: ',
                        style: TextStyle(
                          fontSize: size.height * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.035),
                          child: Icon(
                            isExpandedAllowed
                                ? Symbols.check
                                : Symbols.block_sharp,
                            size: size.width * 0.06,
                            color:
                                isExpandedAllowed ? Colors.green : Colors.red,
                          ))
                    ],
                  ),
                ),
                if (isAlreadyOnList)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.width * 0.04),
                    child: const Divider(),
                  ),
                if (isAlreadyOnList)
                  Padding(
                    padding: infoPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Disponível para venda?',
                          style: TextStyle(
                            fontSize: size.height * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(3.0, 1.0),
                                blurRadius: 4.0,
                                color: Color.fromARGB(60, 251, 251, 251),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.01,
                                right: size.width * 0.035),
                            child: Icon(
                              currentCard!.isAvailableForSale == true
                                  ? Symbols.check
                                  : Symbols.block_sharp,
                              color: currentCard!.isAvailableForSale == true
                                  ? Colors.green
                                  : Colors.red,
                              size: size.width * 0.06,
                            ))
                      ],
                    ),
                  ),
                if (isAlreadyOnList)
                  Padding(
                    padding: infoPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Disponível para troca?',
                          style: TextStyle(
                            fontSize: size.height * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(3.0, 1.0),
                                blurRadius: 4.0,
                                color: Color.fromARGB(60, 251, 251, 251),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.01,
                                right: size.width * 0.035),
                            child: Icon(
                              currentCard!.isAvailableForExchange == true
                                  ? Symbols.check
                                  : Symbols.block_sharp,
                              color: currentCard!.isAvailableForExchange == true
                                  ? Colors.green
                                  : Colors.red,
                              size: size.width * 0.06,
                            ))
                      ],
                    ),
                  ),
                if (isAlreadyOnList)
                  Padding(
                    padding: infoPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Quantidade de cartas:',
                          style: TextStyle(
                            fontSize: size.height * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                offset: Offset(3.0, 1.0),
                                blurRadius: 4.0,
                                color: Color.fromARGB(60, 251, 251, 251),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.01,
                              right: size.width * 0.045),
                          child: Text(
                            currentCard!.cardQuantity.toString(),
                            style: TextStyle(
                              fontSize: size.height * 0.04,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: const [
                                Shadow(
                                  offset: Offset(3.0, 1.0),
                                  blurRadius: 4.0,
                                  color: Color.fromARGB(60, 251, 251, 251),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
