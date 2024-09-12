import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ModalBottomSheet extends StatelessWidget {
  final PokemonCard? card;

  const ModalBottomSheet({super.key, this.card});

  Widget typeIcon(String typeName) {
    PokemonTypesIcon? iconBadge = PokemonTypesIcon.values
        .where((t) => t.typeName == typeName)
        .firstOrNull;

    if (iconBadge != null) {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(
          iconBadge.iconSrc,
          width: 30,
          height: 30,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.09,
                    child: Image.network(card?.image ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card?.name ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          card?.rarity ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
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
                      children: typesList(card?.types),
                    ),
                  ))
                ],
              ),
            ),
            Divider(color: Colors.black.withOpacity(0.3)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Column(
                children: [
                  const DecksOnUseInfo(),
                  const CardQuantityOption(),
                  const AvailableForSaleInfo(),
                  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: SvgPicture.asset(
                  'assets/svg/trading_icon.svg',
                  width: 40,
                  semanticsLabel: 'sales icon',
                  colorFilter: const ColorFilter.mode(
                      Colors.white, BlendMode.srcIn),
                ),
              ),
              const Text(
                'Disponível para troca?',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            width: 50,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Switch(
                value: card?.isAvailableForExchange ?? false,
                inactiveThumbColor: Colors.red,
                activeColor: Colors.green,
                onChanged: (bool value) {},
              ),
            ),
          ),
        ],
      ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AvailableForSaleInfo extends StatelessWidget {
  const AvailableForSaleInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/svg/sale_icon.svg',
                width: 40,
                semanticsLabel: 'sales icon',
                colorFilter: const ColorFilter.mode(
                    Colors.white, BlendMode.srcIn),
              ),
            ),
            const Text(
              'Disponível para venda?',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        SizedBox(
          width: 50,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Switch(
              value: false,
              inactiveThumbColor: Colors.red,
              activeColor: Colors.green,
              onChanged: (bool value) {},
            ),
          ),
        ),
      ],
    );
  }
}

class DecksOnUseInfo extends StatelessWidget {
  const DecksOnUseInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/svg/deck_icon.svg',
                width: 40,
                semanticsLabel: 'card',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const Text(
              'Decks em uso',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: const Text(
            '2',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CardQuantityOption extends StatelessWidget {
  const CardQuantityOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/svg/cards.svg',
                width: 40,
                semanticsLabel: 'card',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const Text(
              'Cartas na lista',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.add,
                    color: Colors.lightGreen,
                    size: 20,
                  )),
            ),
            const SizedBox(
              width: 50,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.remove,
                    color: Colors.redAccent,
                    size: 20,
                  )),
            ),
          ],
        )
      ],
    );
  }
}
