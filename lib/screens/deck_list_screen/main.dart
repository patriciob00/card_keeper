import 'package:card_keeper/controllers/deck_controller.dart';
import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/repositories/deck_repository.dart';
import 'package:card_keeper/screens/create_deck_screen/main.dart';
import 'package:card_keeper/screens/deck_list_screen/widgets/deck_grid_item.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class DeckListScreen extends ConsumerStatefulWidget {
  const DeckListScreen({
    super.key,
    required this.currentIdx,
    required this.onTap,
  });

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends ConsumerState<DeckListScreen> {
  @override
  Widget build(BuildContext context) {
    final decks = ref.watch(deckRepositoryProvider);
    final sortedDecks = [...decks]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return ContainerWithBg(
        child: Scaffold(
      appBar: TopBar(
        centerWidget: const Text(
          'Decks',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: decks.isEmpty
          ? Stack(
              children: [
                Positioned(
                    left: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.11,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(-2, 2),
                                ),
                              ]),
                          child: const Text(
                            'Clique aqui para adicionar \n um novo deck',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                            left: MediaQuery.of(context).size.width * 0.45,
                          ),
                          child: Image.asset(
                            'assets/images/arrow-right.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            width: 80,
                            height: 80,
                          ),
                        )
                      ],
                    ))
              ],
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 12.0),
                child: GridView.builder(
                  itemCount: sortedDecks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 24,
                    childAspectRatio: 2 / 2.9,
                  ),
                  itemBuilder: (context, index) {
                    final deck = sortedDecks[index];

                    return DeckGridItem(
                      deck: deck,
                      onTap: () {
                        // Navegar para detalhes do deck
                      },
                      onLongPress: () {
                        showRemoveDeckDialog(context: context, ref: ref, deck: deck);
                      },
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 85.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 400),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: ((context, animation, secondaryAnimation) {
                  final curvedAnimation = CurvedAnimation(
                      parent: animation, curve: const Interval(0, 0.5));
                  return FadeTransition(
                    opacity: curvedAnimation,
                    child: const CreateDeckScreen(),
                  );
                })));
          },
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          focusElevation: 10.0,
          child: SafeArea(
            maintainBottomViewPadding: true,
            bottom: true,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(-2, 2),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: const Icon(
                Symbols.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

Future<void> showRemoveDeckDialog({
  required BuildContext context,
  required WidgetRef ref,
  required DeckModel deck,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => GestureDetector(
      onTap: () => Navigator.pop(ctx),
      child: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Deseja remover esse deck?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            IconButton.filled(
              iconSize: 28.0,
              onPressed: () async {
                final controller = DeckController(ref: ref);
                await controller.removeDeck(deck);

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Deck removido com sucesso!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(Symbols.delete),
            ),
          ],
        ),
      ),
    ),
  );
}
