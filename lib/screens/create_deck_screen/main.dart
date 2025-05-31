import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/repositories/deck_cards_notifier.dart';
import 'package:card_keeper/screens/create_deck_screen/widgets/bottom_buttons.dart';
import 'package:card_keeper/screens/create_deck_screen/widgets/deck_card_list_modal.dart';
import 'package:card_keeper/screens/create_deck_screen/widgets/search_cards_list.dart';
import 'package:card_keeper/screens/search_screen/components/card_search_bar.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/step_progress.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateDeckScreen extends ConsumerStatefulWidget {
  const CreateDeckScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateDeckScreenState();
}

class _CreateDeckScreenState extends ConsumerState<CreateDeckScreen> {
  // ignore: prefer_final_fields
  late PageController _pageController;
  double _currentPage = 0;
  String deckName = '';
  bool isNameEmpty = true;
  late TextEditingController nameTextFieldCtrl;
  List<CardListItem>? cardList;
  bool isLoading = false;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    nameTextFieldCtrl = TextEditingController()
      ..addListener(() {
        setState(() {
          deckName = nameTextFieldCtrl.value.text;
          isNameEmpty = nameTextFieldCtrl.value.text.trim().isEmpty;
        });
      });
  }

  void onSearchSubmit(String searchTerm) {
    if (searchTerm.isEmpty) {
      setState(() {
        cardList = [];
        isLoaded = true;
        isLoading = false;
      });
    } else {
      search(searchTerm);
    }
  }

  Future<void> search(String searchTerm) async {
    final pokeCardService = PokeCardService();
    setState(() {
      isLoaded = false;
      isLoading = true;
    });

    cardList = await pokeCardService.searchCard(searchTerm);

    setState(() {
      isLoaded = true;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.removeListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final deckCards = ref.watch(deckCardsProvider);
    final bool isDeckEmpty = deckCards.isEmpty;
    final bool disableNext = (_currentPage == 0 && isNameEmpty) || (_currentPage == 1 && isDeckEmpty);

    return ContainerWithBg(
      child: Scaffold(
        appBar: TopBar(
          hasBack: true,
          context: context,
          centerWidget: const Text(
            'Criar Deck',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26.0),
          ),
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: StepProgress(currentStep: _currentPage, steps: 2),
              ),
              Expanded(
                  child: PageView(
                controller: _pageController,
                children: [
                  AddDeckName(nameTextFieldCtrl: nameTextFieldCtrl),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 35),
                          child: Text(
                            deckName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child:
                                      CardSearchBar(onSubmit: onSearchSubmit),
                                ),
                              ),
                              const DeckCardListButtonWithBadge(),
                            ],
                          ),
                        ),
                        if (cardList != null && cardList!.isNotEmpty)
                          SearchCardsList(cardList: cardList)
                      ],
                    ),
                  ),
                ],
              )),
              BottomButtons(
                pageController: _pageController,
                pages: 2.0,
                currentPage: _currentPage,
                disabledNext: disableNext,
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddDeckName extends StatelessWidget {
  const AddDeckName({
    super.key,
    required this.nameTextFieldCtrl,
  });

  final TextEditingController nameTextFieldCtrl;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: TextField(
              controller: nameTextFieldCtrl,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black54),
                  ),
                  fillColor: Colors.black.withOpacity(0.3),
                  filled: true,
                  focusColor: Colors.white,
                  labelText: 'Digite o nome do seu deck',
                  floatingLabelStyle: const TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold),
                  labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ]);
  }
}

class DeckCardListButtonWithBadge extends ConsumerWidget {
  const DeckCardListButtonWithBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deckCards = ref.watch(deckCardsProvider);
    final totalQuantity = deckCards.fold<int>(
      0,
      (sum, card) => sum + (card.deckRequiredQuantity ?? 0),
    );

    final isDeckEmpty = deckCards.isEmpty;

    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        ElevatedButton(
          onPressed: isDeckEmpty ? null : () => showDeckCardListModal(context, ref),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.transparent,
            elevation: 2,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            shape: const CircleBorder(
              side: BorderSide(color: Colors.deepPurpleAccent),
            ),
            fixedSize: const Size(42, 42),
          ),
          child: const Icon(Icons.list, color: Colors.white, size: 24),
        ),
        if (totalQuantity > 0)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              child: Text(
                totalQuantity.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
