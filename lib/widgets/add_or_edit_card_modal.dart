import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/card_variant.dart';

import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:card_keeper/widgets/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class AddOrEditCardModal extends ConsumerStatefulWidget {
  final PokemonCard? card;
  final List<PokemonCard?> variants;
  final bool isAlreadyOnList;
  final bool? hideVariantsOption;
  final void Function()? saveCallback;
  final void Function()? removeCallback;
  final void Function()? onListenerStartSaveCard;
  final void Function()? onListenerFinishSaveCard;
  final void Function()? onListenerStartRemoveCard;
  final void Function()? onListenerFinishRemoveCard;

  const AddOrEditCardModal(
      {super.key,
      this.card,
      required this.variants,
      this.isAlreadyOnList = false,
      this.hideVariantsOption = false,
      this.onListenerFinishRemoveCard,
      this.onListenerFinishSaveCard,
      this.onListenerStartRemoveCard,
      this.onListenerStartSaveCard,
      this.removeCallback,
      this.saveCallback});

  @override
  ConsumerState<AddOrEditCardModal> createState() => _AddOrEditCardModalState();
}

class _AddOrEditCardModalState extends ConsumerState<AddOrEditCardModal> {
  late PokemonCardsController _pkmnCardsController;

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
  bool isHolo = false;
  bool isReverse = false;
  CardVariant currentVariant = CardVariant.normal;
  PokemonCard? currentCard;
  bool currentIsAlreadyOnList = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _pkmnCardsController = PokemonCardsController(ref: ref);
    if (widget.card != null && widget.isAlreadyOnList) {
      setState(() {
        currentCard = widget.card;
        cardQuantity = widget.card?.cardQuantity ?? 1;
        isAvailableForSale = widget.card!.isAvailableForSale as bool;
        isAvailableForTrade = widget.card!.isAvailableForExchange as bool;
        currentIsAlreadyOnList = widget.isAlreadyOnList;

        currentVariant = widget.card?.variant ?? CardVariant.normal;

        // set holo and reverse switches
        isHolo = currentVariant.isHolo;
        isReverse = currentVariant.isReverse;
      });
    }
  }

  void _setVariant(CardVariant variant) {
    final existing = widget.variants
        .whereType<PokemonCard>()
        .where((c) => c.id == widget.card?.id && c.variant == variant)
        .toList()
        .firstOrNull;

    setState(() {
      currentVariant = variant;

      if (variant == CardVariant.holo) {
        isHolo = true;
        isReverse = false;
      } else if (variant == CardVariant.reverse) {
        isReverse = true;
        isHolo = false;
      } else {
        isHolo = false;
        isReverse = false;
      }

      if (existing != null) {
        currentCard = existing;
        cardQuantity = existing.cardQuantity ?? 1;
        isAvailableForSale = existing.isAvailableForSale ?? false;
        isAvailableForTrade = existing.isAvailableForExchange ?? false;
        currentIsAlreadyOnList = true;
      } else {
        final base = (widget.variants.whereType<PokemonCard>().firstOrNull) ??
            widget.card!;

        final newCard = PokemonCard.fromJson(base.toJson());
        newCard.variant = variant;
        newCard.cardQuantity = 1;
        newCard.isAvailableForSale = false;
        newCard.isAvailableForExchange = false;

        currentCard = newCard;
        cardQuantity = 1;
        isAvailableForSale = false;
        isAvailableForTrade = false;
        currentIsAlreadyOnList = false;
      }
    });
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

  void onChangeIsHolo(bool value) {
    if (value) {
      _setVariant(CardVariant.holo);
    } else {
      if (isReverse) {
        _setVariant(CardVariant.reverse);
      } else {
        _setVariant(CardVariant.normal);
      }
    }
  }

  void onChangeIsReverse(bool value) {
    if (value) {
      _setVariant(CardVariant.reverse);
    } else {
      if (isHolo) {
        _setVariant(CardVariant.holo);
      } else {
        _setVariant(CardVariant.normal);
      }
    }
  }

  void _saveCard(PokemonCard card) {
    if (widget.onListenerStartSaveCard != null) {
      widget.onListenerStartSaveCard!();
    }

    setState(() {
      isLoading = !isLoading;
    });

    PokemonCard newCard = PokemonCard.fromJson(card.toJson());

    newCard.cardQuantity = cardQuantity;
    newCard.isAvailableForSale = isAvailableForSale;
    newCard.isAvailableForExchange = isAvailableForTrade;
    newCard.variant = currentVariant;

    final bool variantAlreadyOnList =
        _pkmnCardsController.pokemonIsAlreadyOnList(
      card.id ?? '',
      currentVariant,
    );

    if (variantAlreadyOnList) {
      _pkmnCardsController.updateCard(newCard);
    } else {
      newCard.addedAt = DateTime.now();
      _pkmnCardsController.saveCard(newCard);
    }

    SnackBar snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(variantAlreadyOnList
            ? 'O Card foi atualizado!'
            : 'O Card foi adicionado a sua lista de cards!'));

    if (widget.saveCallback != null) {
      widget.saveCallback!();
    }

    setState(() {
      isLoading = !isLoading;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((reason) {});

    if (widget.onListenerFinishSaveCard != null) {
      widget.onListenerFinishSaveCard!();
    }
  }

  void _removeCard(PokemonCard card) {
    if (widget.onListenerStartRemoveCard != null) {
      widget.onListenerStartRemoveCard!();
    }
    setState(() {
      isLoading = !isLoading;
    });

    final PokemonCard cardToBeDeleted =
        widget.variants.whereType<PokemonCard>().firstWhere(
              (c) => c.variant == currentVariant,
              orElse: () => card,
            );

    _pkmnCardsController.removeCard(cardToBeDeleted);

    if (widget.removeCallback != null) {
      widget.removeCallback!();
    }

    setState(() {
      isLoading = !isLoading;
    });

    const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        content: Text('O Card foi removido da sua lista de cards!'));

    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((reason) {});

    if (widget.onListenerFinishRemoveCard != null) {
      widget.onListenerFinishRemoveCard!();
    }
  }

  @override
  Widget build(BuildContext context) {
    PokemonCard? card = currentCard ?? widget.card;
    final bool hasHoloOption = card?.variants?.holo == true;
    final bool hasReverseOption = card?.variants?.reverse == true;
    final bool isOnList = currentIsAlreadyOnList;
    final bool? hideVariants = widget.hideVariantsOption;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        child: Wrap(
          children: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: Column(
                    children: [
                      CardQuantityOption(
                        quantity: cardQuantity,
                        remove: () => removeQuantity(),
                        add: () => addQuantity(),
                      ),
                      CustomSwitch(
                          icon: const Icon(Symbols.attach_money_sharp,
                              color: Colors.green),
                          title: 'Disponível para venda?',
                          isActive: isAvailableForSale,
                          setIsActive: onChangeIsAvailableForSale),
                      CustomSwitch(
                        icon: const Icon(Symbols.sync_alt_sharp,
                            color: Colors.orange),
                        title: 'Disponível para troca?',
                        setIsActive: onChangeIsAvailableForTrade,
                        isActive: isAvailableForTrade,
                      ),
                      if (hasHoloOption && hideVariants != true)
                        CustomSwitch(
                          icon: const Icon(Symbols.fullscreen_portrait_sharp,
                              color: Colors.deepPurple),
                          title: 'É uma carta Holo?',
                          setIsActive: onChangeIsHolo,
                          isActive: isHolo,
                        ),
                      if (hasReverseOption && hideVariants != true)
                        CustomSwitch(
                          icon: const Icon(Symbols.fullscreen_portrait_sharp,
                              color: Colors.deepOrange),
                          title: 'É uma carta Reverse Holo?',
                          setIsActive: onChangeIsReverse,
                          isActive: isReverse,
                        ),
                      ActionsRow(
                        isOnList: isOnList,
                        saveAction: () => _saveCard(card!),
                        removeAction: () => _removeCard(card!),
                      )
                    ],
                  ),
                )
              ],
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

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    super.key,
    required this.isOnList,
    this.saveAction,
    this.removeAction,
  });

  final bool isOnList;
  final void Function()? saveAction;
  final void Function()? removeAction;

  @override
  Widget build(BuildContext context) {
    final bool isOnListInner = isOnList;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
              ),
              onPressed: () {
                    if (saveAction != null) {
                      saveAction!();
                    }
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
                      'Salvar aqui',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
          const Spacer(),
          isOnListInner
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    if (removeAction != null) {
                      removeAction!();
                    }
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
