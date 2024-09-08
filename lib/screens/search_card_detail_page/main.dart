import 'dart:ui';

import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/search_card_detail_page/components/bottom_bar.dart';
import 'package:card_keeper/screens/search_card_detail_page/components/card_widget.dart';
import 'package:card_keeper/screens/search_card_detail_page/components/modal_bottom_sheet.dart';
import 'package:card_keeper/screens/search_card_detail_page/components/top_bar.dart';
import 'package:card_keeper/screens/search_card_detail_page/controller/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Color commonBgColor = Color(0xff17203A);

class SearchCardDetailPage extends ConsumerStatefulWidget {
  final CardListItem card;

  const SearchCardDetailPage({super.key, required this.card});

  @override
  ConsumerState<SearchCardDetailPage> createState() =>
      SearchCardDetailPageState();
}

class SearchCardDetailPageState extends ConsumerState<SearchCardDetailPage> {
  PokemonCard? currentPokemon;

  late DetailControler _detailController;

  bool _isOnList = false;

  bool _animate = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _animate = true;

    _detailController = DetailControler(ref: ref);

    setFavoriteValue();
    getCurrentPokemon();
  }

  @override
  void dispose() {
    _animate = false;
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

  void saveCardOnList(int quantity) {
    setState(() {
      isLoading = !isLoading;
    });

    _detailController.saveCard(currentPokemon as PokemonCard, quantity);

    setFavoriteValue();

    setState(() {
      isLoading = !isLoading;
    });

    const snackBar = SnackBar(
        duration: Duration(seconds: 3),
        content: Text('O Card foi adicionado a sua lista de cards!'));

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
        backgroundColor: const Color.fromARGB(255, 51, 51, 52),
        clipBehavior: Clip.hardEdge,
        context: context,
        showDragHandle: true,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return ModalBottomSheet(card: currentPokemon as PokemonCard);
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () => {
          setState(() {
            _animate = !_animate;
          })
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.card.image ?? ''))),
            width: double.infinity,
            height: double.infinity,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                ),
                child: SafeArea(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TopBar(
                          disableMoreOptions: !_isOnList,
                          animate: _animate,
                          size: size,
                          moreOptionsFn: showBottomSheet),
                      CardWidget(
                        isExpanded: _animate,
                        size: size,
                        widget: widget,
                      ),
                      BottomBar(
                        size: size,
                        pokemon: currentPokemon,
                        animate: _animate,
                        isAlreadyOnList: _isOnList,
                        saveNewPokemon: saveCardOnList,
                        removePokemon: removeCardFromList,
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
