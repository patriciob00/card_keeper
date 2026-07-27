import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/card_variant.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/search_card_detail_screen/components/flip_card.dart';
import 'package:card_keeper/widgets/add_or_edit_card_modal.dart';
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
  List<PokemonCard?> pokemonVariants = [];

  late PokemonCardsController _detailController;

  bool _isOnList = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _detailController = PokemonCardsController(ref: ref);

    getCurrentPokemon();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setIsOnListValue(CardVariant? cardVariant) {
    final cardId = widget.card.id ?? '';
    final variant = cardVariant ?? currentPokemon?.variant ?? CardVariant.normal;

    setState(() {
      _isOnList =
          _detailController.pokemonIsAlreadyOnList(cardId, variant);
    });
  }

  void getCurrentPokemon() async {
    List<PokemonCard?> pkmList;
    pkmList = await _detailController.getCardAllVariants(widget.card.id ?? '');

    if (pkmList.isNotEmpty) {
      setState(() {
        pokemonVariants = pkmList;
        currentPokemon = pkmList.first as PokemonCard;
      });
      
      setIsOnListValue(pkmList.first!.variant);
    } else {
      setIsOnListValue(null);
    }
  }

  void setLoadingState(bool isLoading) {
    setState(() {
      isLoading = isLoading;
    });
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
          return AddOrEditCardModal(
            isAlreadyOnList: _isOnList, 
            card: currentPokemon as PokemonCard, 
            saveCallback: getCurrentPokemon,
            removeCallback: getCurrentPokemon,
            onListenerFinishRemoveCard: () => setLoadingState(false),
            onListenerFinishSaveCard: () => setLoadingState(false),
            onListenerStartRemoveCard: () => setLoadingState(true),
            onListenerStartSaveCard: () => setLoadingState(true),
            variants: pokemonVariants,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isLoading ? null : FloatingActionButton(
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
                decoration: BoxDecoration(
                    color: Colors.black,
                    gradient: RadialGradient(
                        radius: 4.0,
                        center: Alignment.center,
                        // begin: FractionalOffset.topCenter,
                        // end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.black.withValues(alpha: 0.7),
                        ],
                        stops: const [
                          0.5,
                          0.0,
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
