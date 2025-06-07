import 'package:card_keeper/controllers/deck_controller.dart';
import 'package:card_keeper/data/models/deck_model.dart';
import 'package:card_keeper/main_app.dart';
import 'package:card_keeper/repositories/deck_cards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class BottomButtons extends ConsumerWidget {
  final PageController pageController;
  final double pages;
  final double currentPage;
  final bool? disabledNext;
  final TextEditingController? nameController;

  const BottomButtons({
    super.key,
    required this.pageController,
    required this.pages,
    required this.currentPage,
    this.disabledNext,
    this.nameController,
  });

  ButtonStyle getButtonStyle({
    required bool isDisabled,
    required bool isFirstScreen,
  }) {
    return ElevatedButton.styleFrom(
      disabledBackgroundColor: Colors.black.withAlpha(77),
      disabledForegroundColor: Colors.deepPurpleAccent.withAlpha(77),
      backgroundColor:
          isDisabled ? Colors.black.withAlpha(77) : Colors.deepPurpleAccent,
      foregroundColor: isDisabled
          ? Colors.deepPurpleAccent.withAlpha(77)
          : Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: const CircleBorder(
        side: BorderSide(color: Colors.deepPurpleAccent),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFirstScreen = currentPage == 0;
    final bool isLastScreen = currentPage == pages - 1;
    final deckCards = ref.watch(deckCardsProvider);
    final bool isDeckEmpty = deckCards.isEmpty;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: isFirstScreen
              ? null
              : () => pageController.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
          style: getButtonStyle(
              isDisabled: isFirstScreen, isFirstScreen: isFirstScreen),
          child: const SizedBox(
            width: 50,
            height: 50,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: disabledNext!
              ? null
              : () async {
                  if (isLastScreen) {
                    final name = nameController?.text.trim() ?? '';
                    if (name.isEmpty || isDeckEmpty) return;
                    final deck = DeckModel(
                      id: UniqueKey().toString(),
                      name: name,
                      cards: deckCards,
                      createdAt: DateTime.now(),
                    );

                    final controller = DeckController(ref: ref);
                    await controller.saveDeck(deck);
                    ref.read(deckCardsProvider.notifier).clear();

                    if (!context.mounted) return;

                    // Mostra Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deck "$name" criado com sucesso!'),
                        duration: const Duration(seconds: 3),
                      ),
                    );


                    // Navega para tela inicial
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const MainPage(initialIndex: 2),
                      ),
                      (route) => false,
                    );
                  } else {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
          style:
              getButtonStyle(isDisabled: disabledNext!, isFirstScreen: false),
          child: SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              isLastScreen ? Symbols.save : Icons.arrow_forward,
              color: disabledNext! ? Colors.deepPurpleAccent : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}