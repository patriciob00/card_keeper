import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ModalBottomSheet extends StatefulWidget {
  final PokemonCard? card;
  final Function(
      int quantity, bool isAvailableForSale, bool isAvailableForTrade) saveCard;
  final Function removeCard;
  final bool isAlreadyOnList;

  const ModalBottomSheet(
      {super.key,
      this.card,
      required this.saveCard,
      this.isAlreadyOnList = false,
      required this.removeCard});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
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

  bool isAvailableForSale = false;
  bool isAvailableForTrade = false;
  int cardQuantity = 1;

  @override
  void initState() {
    super.initState();
    if (widget.card != null && widget.isAlreadyOnList) {
      setState(() {
        cardQuantity = widget.card?.cardQuantity ?? 1;
        isAvailableForSale = widget.card!.isAvailableForSale as bool;
        isAvailableForTrade = widget.card!.isAvailableForExchange as bool;
      });
    }
  }

  void addQuantity() {
    setState(() {
      cardQuantity = ++cardQuantity;
    });
  }

  void removeQuantity() {
    setState(() {
      cardQuantity = --cardQuantity;
    });
  }

  void onChangeIsAvailableForSale(bool value) {
    setState(() {
      isAvailableForSale = value;
    });
  }

  void onChangeIsAvailableForTrade(bool value) {
    setState(() {
      isAvailableForTrade = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 20),
      child: SizedBox(
        width: size.width,
        height: size.height * 0.24,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Column(
                children: [
                  CardQuantityOption(
                    quantity: cardQuantity,
                    remove: () => removeQuantity(),
                    add: () => addQuantity(),
                  ),
                  AvailableForSaleInfo(
                    setIsAvailable: onChangeIsAvailableForSale,
                    isAvailable: isAvailableForSale,
                  ),
                  AvailableForTrade(
                    isAvailable: isAvailableForTrade,
                    setIsAvailable: onChangeIsAvailableForTrade,
                  ),
                  ActionsRow(
                      widget: widget,
                      cardQuantity: cardQuantity,
                      isAvailableForSale: isAvailableForSale,
                      isAvailableForTrade: isAvailableForTrade)
                ],
              ),
            )
          ],
        ),
      ),
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
        const Row(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Symbols.stacks,
                  color: Colors.black,
                )),
            Text(
              'Decks em uso',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: const Text(
            '2',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CardQuantityOption extends StatelessWidget {
  const CardQuantityOption({
    super.key,
    required this.quantity,
    required this.add,
    required this.remove,
  });

  final int quantity;
  final Function add;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Symbols.fullscreen_portrait_sharp,
                  color: Colors.black,
                ),
              ),
              Text(
                'Quantidade',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => add(),
                child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.add,
                      color: Colors.lightGreen,
                      size: 20,
                    )),
              ),
              SizedBox(
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    quantity.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => quantity == 1 ? null : remove(),
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
      ),
    );
  }
}

class AvailableForTrade extends StatelessWidget {
  const AvailableForTrade({
    super.key,
    required this.isAvailable,
    required this.setIsAvailable,
  });

  final bool isAvailable;
  final Function(bool value) setIsAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Symbols.currency_exchange_sharp,
                  color: Colors.black,
                ),
              ),
              Text(
                'Disponível para troca?',
                style: TextStyle(
                    color: Colors.black,
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
                activeColor: Colors.green,
                value: isAvailable,
                onChanged: setIsAvailable,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AvailableForSaleInfo extends StatelessWidget {
  const AvailableForSaleInfo({
    super.key,
    required this.isAvailable,
    required this.setIsAvailable,
  });

  final bool isAvailable;
  final Function(bool value) setIsAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: Icon(
                  Symbols.paid_sharp,
                  color: Colors.black,
                ),
              ),
              Text(
                'Disponível para venda?',
                style: TextStyle(
                    color: Colors.black,
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
                value: isAvailable,
                activeColor: Colors.green,
                onChanged: setIsAvailable,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    super.key,
    required this.widget,
    required this.cardQuantity,
    required this.isAvailableForSale,
    required this.isAvailableForTrade,
  });

  final ModalBottomSheet widget;
  final int cardQuantity;
  final bool isAvailableForSale;
  final bool isAvailableForTrade;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              onPressed: () {
                widget.saveCard(
                    cardQuantity, isAvailableForSale, isAvailableForTrade);
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Symbols.save_sharp,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
              const Spacer(),
          widget.isAlreadyOnList
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    widget.removeCard();
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Symbols.delete,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Remover',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
