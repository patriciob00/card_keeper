import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/screens/deck_detail_screen/widgets/deck_categorized_list_view.dart';
import 'package:card_keeper/screens/deck_detail_screen/widgets/deck_grid_view.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:card_keeper/widgets/card_with_ripple.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class DeckDetailScreen extends ConsumerStatefulWidget {
  final DeckModel deck;

  const DeckDetailScreen({super.key, required this.deck});

  @override
  ConsumerState<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends ConsumerState<DeckDetailScreen> {
  bool showListGrid = true;

  void toggleViewType() {
    setState(() {
      showListGrid = !showListGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deck = widget.deck;
    final firstCard = deck.cards.isNotEmpty ? deck.cards.first : null;
    final deckId = deck.id;
    final cards = deck.cards;

    return ContainerWithBg(
      child: Scaffold(
        appBar: TopBar(
          context: context,
          hasBack: true,
          centerWidget: Text(
            deck.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26.0,
            ),
          ),
          actionsWidget: [
            IconButton(
              onPressed: toggleViewType,
              icon: Icon(
                !showListGrid ? Symbols.list_sharp : Symbols.view_cozy_rounded,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                // irá abrir o diálogo com as informações
              },
              icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SafeArea(
          child: showListGrid
                  ? DeckGridView(deck: deck)
                  : DeckCategorizedListView(
                      deck: deck,
                      onCardTap: (cardId) {/* ação */},
                      onCardLongPress: (cardId) {/* ação */},
                    )
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: FloatingActionButton(
            onPressed: () {
              // Ação de exclusão múltipla
            },
            elevation: 1.0,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Symbols.delete,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.white38,
                  blurRadius: 6,
                  offset: Offset(-2, 2),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
