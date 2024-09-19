import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/card_detail_screen/components/flip_card.dart';
import 'package:card_keeper/screens/card_detail_screen/components/modal_bottom_sheet.dart';
import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchCardDetailPage extends ConsumerStatefulWidget {
  final CardListItem card;

  const SearchCardDetailPage({super.key, required this.card});

  @override
  ConsumerState<SearchCardDetailPage> createState() =>
      SearchCardDetailPageState();
}

class SearchCardDetailPageState extends ConsumerState<SearchCardDetailPage> {
  PokemonCard? currentPokemon;

  late PokemonCardsControler _detailController;

  bool _isOnList = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _detailController = PokemonCardsControler(ref: ref);

    setFavoriteValue();
    getCurrentPokemon();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setFavoriteValue() {
    setState(() {
      _isOnList =
          _detailController.pokemonIsAlreadyOnList(widget.card.id ?? '');
    });
  }

  void getCurrentPokemon() async {
    PokemonCard? pkm;
    pkm = await _detailController.getCard(widget.card.id ?? '');

    if (pkm != null) {
      setState(() {
        currentPokemon = pkm as PokemonCard;
      });
    }
  }

  void saveCardOnList(int quantity, bool isAvailableForSale, bool isAvailableForTrade) {
    setState(() {
      isLoading = !isLoading;
    });

    PokemonCard newCard = PokemonCard.fromJson(currentPokemon!.toJson());

    newCard.cardQuantity = quantity;
    newCard.isAvailableForSale = isAvailableForSale;
    newCard.isAvailableForExchange = isAvailableForTrade;

    if(_isOnList) {
      _detailController.updateCard(newCard);
    } else {
      newCard.addedAt = DateTime.now();
      _detailController.saveCard(newCard);
    }

    SnackBar snackBar = SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(_isOnList ? 'O Card foi atualizado!' : 'O Card foi adicionado a sua lista de cards!'));

    getCurrentPokemon();


    setFavoriteValue();

    setState(() {
      isLoading = !isLoading;
    });


    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((reason) {});
  }

  void removeCardFromList() async {
    setState(() {
      isLoading = !isLoading;
    });

    await _detailController.removeCard(currentPokemon as PokemonCard);

    setFavoriteValue();

    setState(() {
      isLoading = !isLoading;
    });

    const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        content: Text('O Card foi removido da sua lista de cards!'));

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((reason) {});
  }

  void showBottomSheet() {
    showModalBottomSheet(
        useSafeArea: true,
        backgroundColor: Colors.white,
        clipBehavior: Clip.hardEdge,
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return ModalBottomSheet(isAlreadyOnList: _isOnList, card: currentPokemon as PokemonCard, saveCard: saveCardOnList, removeCard: () {},);
        });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 5.0,
          backgroundColor: Colors.black,
          onPressed: () {
            showBottomSheet();
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          focusElevation: 10.0,
          child: SafeArea(
            maintainBottomViewPadding: true,
            bottom: true,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),),
              child: !_isOnList ? const Icon(
                Symbols.save_rounded,
                color: Colors.white,
                size: 30,
              ) : const Icon(Symbols.edit_sharp, color: Colors.white,),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              style: IconButton.styleFrom(
                  iconSize: 40.0, fixedSize: const Size(40.0, 40.0)),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30.0,
              )),
          leadingWidth: 30.0,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: widget.card.image ?? '',
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black,
                        ],
                        stops: [
                          0.2,
                          0.0
                        ])),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Align(
                    alignment: Alignment.center,
                    child: FlipCard(widget: widget, currentPokemon: currentPokemon, isAlreadyOnList: _isOnList,),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
