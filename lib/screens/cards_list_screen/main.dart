import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/screens/cards_list_screen/cards_categorized_list_view.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/stats_modal.dart';
import 'package:card_keeper/widgets/card_with_ripple_and_flip_v2.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/filter_functions.dart';
import 'dart:core' as core;


class CardsStats {
    final core.int total;
    final core.Map<CardKind, core.int> perKind;
    final core.Map<core.String, core.int> perColection;
    final core.Map<core.String, core.int> pokemonPerType;
    CardsStats({
      required this.total,
      required this.perKind,
      required this.perColection,
      required this.pokemonPerType,
    });
  }

class CardListScreen extends ConsumerStatefulWidget {
  const CardListScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final core.int currentIdx;
  final Function(core.int idx) onTap;

  @core.override
  ConsumerState<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends ConsumerState<CardListScreen> {
  final core.Set<CardKind> _selectedKinds = {};                // vazio = todos
  final core.Set<core.String> _selectedPokemonTypes = {};            // vazio = todos

  // âncora do botão de filtro pra abrir o menu no lugar certo
  final GlobalKey _filterIconKey = GlobalKey();

  // Cards após aplicar filtro
  core.List<PokemonCard> get _filteredCards {
    final cards = ref.watch<core.List<PokemonCard>>(pokemonCardsRepositoryProvider);
    return cards.where((c) {
      final kind = kindOf(c);
      final okKind = _selectedKinds.isEmpty || _selectedKinds.contains(kind);

      // só aplica filtro de tipo de Pokémon quando a carta é Pokémon
      final types = c.types ?? const [];
      final okPokeType = _selectedPokemonTypes.isEmpty ||
          (kind == CardKind.pokemon && types.any(_selectedPokemonTypes.contains));

      return okKind && okPokeType;
    }).toList();
  }
  
  CardsStats _computeStats(core.List<PokemonCard> cards) {
    final perKind = <CardKind, core.int>{};
    final perCollection = <core.String, core.int>{};
    final pokemonPerType = <core.String, core.int>{};

    for (final c in cards) {
      final k = kindOf(c);
      perKind[k] = (perKind[k] ?? 0) + 1;

      final setName = c.pokemonCardSet?.name ?? '—';
      perCollection[setName] = (perCollection[setName] ?? 0) + 1;

      if (k == CardKind.pokemon) {
        for (final t in c.types ?? const []) {
          pokemonPerType[t] = (pokemonPerType[t] ?? 0) + 1;
        }
      }
    }

    return CardsStats(
      total: cards.length,
      perKind: perKind,
      perColection: perCollection,
      pokemonPerType: pokemonPerType,
    );
  }

  core.bool get isWeb => kIsWeb;

  late PokemonCardsControler _pkmnCardsController;

  core.bool showListGrid = true;

  @core.override
  void initState() {
    super.initState();
    _pkmnCardsController = PokemonCardsControler(ref: ref);
  }

  void changeListViewType() {
    setState(() {
      showListGrid = !showListGrid;
    });
  }

  void deleteCard(PokemonCard card) {
    _pkmnCardsController.removeCard(card);
    Navigator.pop(context);
  }

  core.List<Widget> getBadges(PokemonCard card) {
    core.List<Widget> list = [];

    list.add(BadgeCustom(
        child: Text(
      card.cardQuantity.toString(),
      style: const TextStyle(
          fontSize: 12.0, color: Colors.black, fontWeight: FontWeight.bold),
    )));

    if (card.isAvailableForSale!) {
      list.add(const BadgeCustom(
        child: Icon(
          Symbols.attach_money_sharp,
          color: Colors.green,
          size: 12.0,
        ),
      ));
    }

    if (card.isAvailableForExchange!) {
      list.add(const BadgeCustom(
        child: Icon(
          Symbols.sync_alt_sharp,
          color: Colors.orange,
          size: 12.0,
        ),
      ));
    }
    return list;
  }

  core.Future<void> cardLongPressDialog(PokemonCard card) async {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: core.double.infinity,
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width * 0.70,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: HeroWidget(
                          tag: card.image ?? '',
                          child: ImageCached(imageURL: card.image ?? '', showHoloEffect: true,)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton.filled(
                            iconSize: 28.0,
                            onPressed: () {
                              deleteCard(card);
                            },
                            icon: const Icon(Symbols.delete),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @core.override
  Widget build(BuildContext context) {
    core.double appBarheight = Scaffold.of(context).appBarMaxHeight ?? 60;
    core.double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    final cardsList =
        ref.watch<core.List<PokemonCard>>(pokemonCardsRepositoryProvider);

    return ContainerWithBg(
      child: Scaffold(
        appBar: TopBar(
          centerWidget: const Text(
            'Cards',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26.0),
          ),
          actionsWidget: [
            IconButton(onPressed: () {
              changeListViewType();
            }, icon:  Icon(showListGrid ? Symbols.view_cozy_rounded : Symbols.lists_rounded, color: Colors.white,)),
            if (cardsList.isNotEmpty) 
              IconButton(
                onPressed: () => showStatsModal(ref.read(pokemonCardsRepositoryProvider), _computeStats(cardsList), context),
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ))
          ],
        ),
        floatingActionButton: cardsList.isEmpty ? null : Padding(
          padding: const EdgeInsets.only(bottom:85),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            focusElevation: 10.0,
            child: const Icon(Symbols.filter_list, color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: cardsList.isEmpty
                ? SizedBox(
                    height: core.double.infinity,
                    width: core.double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/pokeballs.png'),
                        const Text(
                          'Lista vazia!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const Text(
                          'Adicione alguns cards para encontrar aqui.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))
                : showListGrid ? GridView.builder(
                    padding: EdgeInsets.only(
                        top: appBarheight + 10.0, bottom: bottomTabHeight + 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 2.8,
                    ),
                    itemCount: cardsList.length,
                    itemBuilder: (BuildContext context, core.int index) {
                      return Stack(clipBehavior: Clip.none, children: [
                        CardWithRippleAndFlipV2(
                          isAlreadyOnList: true,
                          currentPokemon: cardsList[index],
                          tag: cardsList[index].image ?? '', 
                          imageURL: cardsList[index].image ?? '',
                          onLongPress: () =>
                              cardLongPressDialog(cardsList[index]),
                        ),
                        Positioned(
                            top: -12,
                            right: 3,
                            child: Row(
                              textDirection: TextDirection.rtl,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getBadges(cardsList[index]),
                            ))
                      ]);
                    },
                  ) : 
                  Padding(
                      padding: EdgeInsets.only(
                        top: appBarheight + 10.0,
                        bottom: bottomTabHeight + 10,
                      ),
                      child: CardsCategorizedListView(
                        cards: cardsList,
                        onLongPress: (card) => cardLongPressDialog(card),
                        // Injeta seu overlay de badges pra manter consistência
                        buildBadgeOverlay: (card) => Row(
                          textDirection: TextDirection.rtl,
                          children: getBadges(card),
                        ),
                      ),
                    )),
          ),
        ),
      );
  }
}

class BadgeCustom extends StatelessWidget {
  const BadgeCustom({
    super.key,
    this.backgroundColor = Colors.white,
    required this.child,
  });

  final Color backgroundColor;
  final Widget child;

  @core.override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: child,
    );
  }
}
