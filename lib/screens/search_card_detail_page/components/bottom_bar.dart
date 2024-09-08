import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.size,
    required this.animate,
    required this.isAlreadyOnList,
    required this.saveNewPokemon,
    required this.removePokemon,
    this.pokemon,
  });

  final Size size;
  final bool animate;
  final bool isAlreadyOnList;
  final Function saveNewPokemon;
  final Function removePokemon;
  final PokemonCard? pokemon;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int cardQuantity = 1;

  void increaseQuantity() {
    setState(() {
      cardQuantity = ++cardQuantity;
    });
  }

  void decreaseQuantity() {
    if (cardQuantity > 1) {
      setState(() {
        cardQuantity = --cardQuantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const iconfavorite = Icon(Icons.favorite, color: Colors.red, size: 15);
    const iconDelete = Icon(Icons.delete, color: Colors.white, size: 20);

    List<Widget> addedCardRow = [
      OutlinedButton(
          onPressed: () {
            widget.removePokemon();
          },
          child: const Row(children: [
            Padding(padding: EdgeInsets.only(right: 6), child: iconDelete),
            Text('Remover', style: TextStyle(color: Colors.white)),
          ])),
      Badge.count(
        count: widget.pokemon?.cardQuantity ?? 0,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        padding: EdgeInsets.zero,
        offset: const Offset(-3, 6),
        child: SvgPicture.asset(
          'assets/svg/cards.svg',
          width: 40,
          semanticsLabel: 'card',
          colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        ),
      ),
      Badge.count(
        count: 0,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        padding: EdgeInsets.zero,
        offset: const Offset(-3, 6),
        child: SvgPicture.asset(
          'assets/svg/deck_icon.svg',
          width: 40,
          semanticsLabel: 'card deck icon',
          colorFilter: const ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        ),
      ),
      SvgPicture.asset(
          'assets/svg/sale_icon.svg',
          width: 40,
          semanticsLabel: 'available for sale',
          colorFilter: ColorFilter.mode( widget.pokemon?.isAvailableForSale == true ? Colors.green.withOpacity(0.54) : Colors.redAccent.withOpacity(0.54), BlendMode.srcIn),
        ),
      SvgPicture.asset(
          'assets/svg/trading_icon.svg',
          width: 40,
          semanticsLabel: 'available for trading',
          colorFilter: ColorFilter.mode( widget.pokemon?.isAvailableForExchange == true ? Colors.green.withOpacity(0.54) : Colors.redAccent.withOpacity(0.54), BlendMode.srcIn),
        ),
    ];

    List<Widget> notAddedCardRow = [
      OutlinedButton(
          onPressed: () {
            widget.saveNewPokemon(cardQuantity);
          },
          child: const Row(children: [
            Padding(padding: EdgeInsets.only(right: 6), child: iconfavorite),
            Text('Adicionar', style: TextStyle(color: Colors.white)),
          ])),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.grey.withOpacity(0.8), width: 0.8),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                increaseQuantity();
              },
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
            SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  cardQuantity.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: cardQuantity < 1
                  ? null
                  : () {
                      decreaseQuantity();
                    },
              child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
          ],
        ),
      )
    ];

    return Positioned(
      bottom: 10.0,
      width: widget.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: AnimatedOpacity(
          opacity: widget.animate ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
                  widget.isAlreadyOnList ? addedCardRow : notAddedCardRow),
        ),
      ),
    );
  }
}
