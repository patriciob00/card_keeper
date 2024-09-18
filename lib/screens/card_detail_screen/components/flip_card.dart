import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:card_keeper/screens/card_detail_screen/components/card_widget.dart';
import 'package:card_keeper/screens/card_detail_screen/main.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class FlipCard extends StatefulWidget {
  const FlipCard({super.key, required this.widget, this.currentPokemon, this.isAlreadyOnList = false });

  final PokemonCard? currentPokemon;

  final SearchCardDetailPage widget;

  final bool isAlreadyOnList;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future flipCard() async {
    isFront = !isFront;

    if (isFront) {
      await controller.forward();
    } else {
      await controller.reverse();
    }
  }

  bool isFrontImage(double angle) {
    const degrees90 = pi / 2;
    const degrees270 = 3 * pi / 2;

    return angle <= degrees90 || angle >= degrees270;
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final size = MediaQuery.of(context).size;
        final angle = controller.value * -pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFrontImage(angle.abs())
              ? CardWidget(
                  onTap: () => flipCard(),
                  size: size,
                  widget: widget.widget,
                )
              : Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(pi),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Container(
                            width: size.width * 0.90,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    image: AssetImage(
                                      'assets/images/card-back.png',
                                    ))),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                            )),
                      ),
                      CardBackInfo(
                        currentCard: widget.currentPokemon,
                        isAlreadyOnList: widget.isAlreadyOnList,
                      ),
                      Positioned.fill(
                          child: Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              color: Colors.transparent,
                              child: InkWell(
                                  splashColor: Colors.white24,
                                  onTap: () => flipCard()))),
                    ],
                  ),
                ),
        );
      });
}

class CardBackInfo extends StatelessWidget {
  const CardBackInfo({super.key, this.currentCard, this.isAlreadyOnList = false });

  final bool isAlreadyOnList;

  final PokemonCard? currentCard;

  Widget typeIcon(String typeName) {
    PokemonTypesIcon? iconBadge = PokemonTypesIcon.values
        .where((t) => t.typeName == typeName)
        .firstOrNull;

    if (iconBadge != null) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          fit: BoxFit.contain,
          iconBadge.iconSrc,
          width: 40,
          height: 40,
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
    final size = MediaQuery.of(context).size;

    final isExpandedAllowed = currentCard?.legal?.expanded == true;
    final isStandardAllowed = currentCard?.legal?.standard == true;

    return Positioned(
      child: Container(
        width: size.width * 0.90,
        height: (size.width  * 0.9) * 1.39,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.black.withOpacity(0.7)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
          child: SizedBox(
            width: size.width * 0.90,
            height: size.height * 0.4,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentCard?.name ?? '',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
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
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                shadows: [
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
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: typesList(currentCard?.types),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if(currentCard!.pokemonCardSet!.logo != null) Padding(
                  padding:
                      const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Coleção: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CachedNetworkImage(
                            imageUrl: currentCard!.pokemonCardSet!.logo ?? '',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            width: 100,
                            height: 100,
                          ))
                    ],
                  ),
                ),
                if(currentCard?.pokemonCardSet?.logo == null) const Padding(
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 5),
                  child: SizedBox(height: 100.0, width: 100.0,),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Padrão: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(isStandardAllowed ? Symbols.check : Symbols.block_sharp, color: isStandardAllowed ? Colors.green : Colors.red,))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Expandido: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(isExpandedAllowed ? Symbols.check : Symbols.block_sharp, color: isExpandedAllowed ? Colors.green : Colors.red,))
                    ],
                  ),
                ),
                if (isAlreadyOnList) const Padding(
                  padding: EdgeInsets.symmetric( horizontal: 30.0, vertical: 20.0),
                  child: Divider(),
                ),
                if(isAlreadyOnList) Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Disponível para venda?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(currentCard!.isAvailableForSale == true ? Symbols.check : Symbols.block_sharp, color: currentCard!.isAvailableForSale == true ? Colors.green : Colors.red,))
                    ],
                  ),
                ),
                if(isAlreadyOnList) Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Disponível para troca?',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(currentCard!.isAvailableForExchange == true ? Symbols.check : Symbols.block_sharp, color: currentCard!.isAvailableForExchange == true ? Colors.green : Colors.red,))
                    ],
                  ),
                ),
                if(isAlreadyOnList) Padding(
                  padding:
                      const EdgeInsets.only(top: 5, left: 30, right: 30, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Quantidade de cartas:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),
                      ),
                      Text(currentCard!.cardQuantity.toString(), style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(3.0, 1.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(60, 251, 251, 251),
                            ),
                          ],
                        ),),
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
