import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/card_variant.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/screens/cards_list_screen/cards_categorized_list_view.dart';
import 'package:card_keeper/screens/cards_list_screen/cards_grid_view.dart';
import 'package:card_keeper/screens/cards_list_screen/no_cards_view.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/card_status.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/badge_custom.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/cards_filter_menu_content.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/search_fab.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/stats_modal.dart';
import 'package:card_keeper/widgets/card_with_ripple_and_flip.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/filter_functions.dart';

class CardListScreen extends ConsumerStatefulWidget {
  const CardListScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends ConsumerState<CardListScreen> {
  // Filtros
  final _selectedKinds = <CardKind>{};
  final _selectedPokemonTypes = <String>{}; // vazio = todos
  bool _onlyForSale = false;
  bool _onlyForExchange = false;
  final _selectedVariants = <CardVariant>{};
  final _selectedRarities = <String>{};

  String _searchQuery = '';

  // âncora do botão de filtro pra abrir o menu no lugar certo
  final GlobalKey _filterIconKey = GlobalKey();

  CardsStats _computeStats(List<PokemonCard> cards) {
    final perKind = <CardKind, int>{};
    final perCollection = <String, int>{};
    final pokemonPerType = <String, int>{};
    final perVariant = <CardVariant, int>{};

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

      perVariant[c.variant!] = (perVariant[c.variant] ?? 0) + 1;
    }

    return CardsStats(
      total: cards.length,
      perKind: perKind,
      perColection: perCollection,
      pokemonPerType: pokemonPerType,
      perVariant: perVariant,
    );
  }

  bool get isWeb => kIsWeb;

  late PokemonCardsController _pkmnCardsController;

  bool showListGrid = true;

  bool _showSearchBar = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pkmnCardsController = PokemonCardsController(ref: ref);
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

  List<Widget> getBadges(PokemonCard card) {
    List<Widget> list = [];

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

    final variant = card.variant ?? CardVariant.normal;
    if (variant != CardVariant.normal) {
      final bool isHoloVariant = variant == CardVariant.holo;
      list.add(BadgeCustom(
          child: Text(
        isHoloVariant ? 'H' : 'R',
        style: TextStyle(
            fontSize: 12.0,
            color: isHoloVariant ? Colors.deepPurple : Colors.deepOrange,
            fontWeight: FontWeight.bold),
      )));
    }
    return list;
  }

  Future<void> cardLongPressDialog(PokemonCard card) async {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: double.infinity,
                decoration:
                    BoxDecoration(color: Colors.black.withValues(alpha: 0.2)),
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
                          child: ImageCached(
                            imageURL: card.image ?? '',
                            showHoloEffect: card.variant?.isHolo ?? false,
                            showReverseHoloEffect:
                                card.variant?.isReverse ?? false,
                          )),
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

  // Aplica TODOS os filtros
  List<PokemonCard> get _filteredCards {
    final cards = ref.watch<List<PokemonCard>>(pokemonCardsRepositoryProvider);
    final filtered = cards.where((c) {
      final kind = kindOf(c);

      final okKind = _selectedKinds.isEmpty || _selectedKinds.contains(kind);

      final types = c.types ?? const [];
      final okPokeType = _selectedPokemonTypes.isEmpty ||
          (kind == CardKind.pokemon &&
              types.any(_selectedPokemonTypes.contains));

      final okSale = !_onlyForSale || (c.isAvailableForSale == true);
      final okExchange =
          !_onlyForExchange || (c.isAvailableForExchange == true);

      final variant = c.variant ?? CardVariant.normal;
      final okVariant =
          _selectedVariants.isEmpty || _selectedVariants.contains(variant);

      final rarity = (c.rarity ?? '').trim();
      final okRarity = _selectedRarities.isEmpty ||
          _selectedRarities.contains(rarity.isEmpty ? '—' : rarity);

      return okKind &&
          okPokeType &&
          okSale &&
          okExchange &&
          okVariant &&
          okRarity;
    }).toList();

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      return filtered.where((card) {
        final name = (card.name ?? '').toLowerCase();
        return name.contains(q);
      }).toList();
    }

    return filtered;
  }

  Future<void> _openFiltersMenu(GlobalKey anchorKey) async {
    // Pega posição do ícone
    final renderBox =
        anchorKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay =
        Navigator.of(context).overlay?.context.findRenderObject() as RenderBox?;
    if (renderBox == null || overlay == null) return;

    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        renderBox.localToGlobal(Offset.zero, ancestor: overlay),
        renderBox.localToGlobal(renderBox.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    // raridades disponíveis (da lista completa)
    final allCards =
        ref.read<List<PokemonCard>>(pokemonCardsRepositoryProvider);

    final availableRarities = allCards
        .map((c) => (c.rarity ?? '').trim())
        .where((r) => r.isNotEmpty)
        .toSet()
        .toList()
      ..sort();

    await showMenu(
      context: context,
      position: position,
      constraints: const BoxConstraints.tightFor(width: 320),
      items: [
        PopupMenuItem(
            enabled: false, // evita hover/seleção do item inteiro
            padding: EdgeInsets.zero,
            child: CardsFilterMenuContent(
                initialKinds: _selectedKinds,
                initialTypes: _selectedPokemonTypes,
                initialVariants: _selectedVariants,
                initialRarities: _selectedRarities,
                availableRarities: availableRarities,
                initialOnlyForSale: _onlyForSale,
                initialOnlyForExchange: _onlyForExchange,
                onApply:
                    (kinds, types, variants, rarities, onlySale, onlyExchange) {
                  setState(() {
                    _selectedKinds
                      ..clear()
                      ..addAll(kinds);
                    _selectedPokemonTypes
                      ..clear()
                      ..addAll(types);
                    _selectedVariants
                      ..clear()
                      ..addAll(variants);
                    _selectedRarities
                      ..clear()
                      ..addAll(rarities);
                    _onlyForSale = onlySale;
                    _onlyForExchange = onlyExchange;
                  });
                },
                onClear: () {
                  setState(() {
                    _selectedKinds.clear();
                    _selectedPokemonTypes.clear();
                    _selectedVariants.clear();
                    _selectedRarities.clear();
                    _onlyForSale = false;
                    _onlyForExchange = false;
                  });
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double appBarheight = Scaffold.of(context).appBarMaxHeight ?? 60;
    double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    final notFilteredCardList =
        ref.watch<List<PokemonCard>>(pokemonCardsRepositoryProvider);

    final cardsList = _filteredCards;

    final emptyTextHelper = cardsList.isEmpty && notFilteredCardList.isEmpty
        ? 'Lista vazia!'
        : 'O Filtro não encontrou nada!';
    final emptySubtextHelper =
        (cardsList.isEmpty && notFilteredCardList.isEmpty)
            ? 'Adicione alguns cards para encontrar aqui.'
            : 'Remova ou refaça o filtro!';

    final filterNotSelected = _selectedKinds.isEmpty &&
        _selectedPokemonTypes.isEmpty &&
        _selectedVariants.isEmpty &&
        _selectedRarities.isEmpty &&
        !_onlyForExchange &&
        !_onlyForSale;

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
            if (notFilteredCardList.isNotEmpty)
              IconButton(
                  onPressed: () {
                    changeListViewType();
                  },
                  icon: Icon(
                    showListGrid
                        ? Symbols.view_cozy_rounded
                        : Symbols.lists_rounded,
                    color: Colors.white,
                  )),
            if (notFilteredCardList.isNotEmpty)
              IconButton(
                key: _filterIconKey,
                onPressed: () => _openFiltersMenu(_filterIconKey),
                icon: Icon(Icons.filter_list,
                    color: filterNotSelected
                        ? Colors.white
                        : Colors.deepPurpleAccent),
              ),
            if (notFilteredCardList.isNotEmpty)
              IconButton(
                  onPressed: () => showStatsModal(
                      ref.read(pokemonCardsRepositoryProvider),
                      _computeStats(notFilteredCardList),
                      context),
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ))
          ],
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: notFilteredCardList.isEmpty
            ? null
            : SearchFAB(
                showSearchBar: _showSearchBar,
                searchController: _searchController,
                onChangetext: (value) {
                  setState(() {
                    _searchQuery = value.trim();
                  });
                },
                onToggleFAB: () {
                  setState(() {
                    _showSearchBar = !_showSearchBar;
                    if (!_showSearchBar) {
                      _searchController.clear();
                      _searchQuery = '';
                    }
                  });
                }),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
              child: cardsList.isEmpty
                  ? NoCardsView(
                      emptyTextHelper: emptyTextHelper,
                      emptySubtextHelper: emptySubtextHelper)
                  : showListGrid
                      ? CardsGridView(
                        appBarheight: appBarheight, 
                        bottomTabHeight: bottomTabHeight, 
                        cardsList: cardsList, 
                        cardLongPressDialog: cardLongPressDialog, 
                        getBadges: getBadges)
                      : Padding(
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
