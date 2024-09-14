import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardListScreen extends ConsumerStatefulWidget {
  const CardListScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends ConsumerState<CardListScreen> {
  bool get isWeb => kIsWeb;

  late PokemonCardsControler _pkmnCardsController;

  @override
  void initState() {
    super.initState();
    _pkmnCardsController = PokemonCardsControler(ref: ref);
  }

  void deleteCard(PokemonCard card) {
    _pkmnCardsController.removeCard(card);
    Navigator.pop(context);
  }

  void cardLongPress(PokemonCard card) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black..withOpacity(0.3),
              body: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    HeroWidget(
                      tag: card.image ?? '',
                      child: ImageCached(imageURL: card.image ?? ''),
                    ),
                  ],
                ),
              ),
            )));
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
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
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
                        child: ImageCached(imageURL: card.image ?? ''),
                      ),
                    ),
                    Container(
                      width: size.width * 0.50,
                      margin: const EdgeInsets.only(top: 20),
                      child: OutlinedButton(
                          onPressed: () {
                            deleteCard(card);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Symbols.delete,
                                    color: Colors.white,
                                  )),
                              Text('Remover card',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double appBarheight = Scaffold.of(context).appBarMaxHeight ?? 60;
    double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    final cardsList = ref.watch<List<PokemonCard>>(pokemonCardsRepositoryProvider);

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
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ))
          ],
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            child: cardsList.isEmpty
                ? SizedBox(
                    height: double.infinity,
                    width: double.infinity,
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
                : GridView.builder(
                    padding: EdgeInsets.only(
                        top: appBarheight + 10.0, bottom: bottomTabHeight + 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: cardsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onLongPress: () =>
                            cardLongPressDialog(cardsList[index]),
                        child: HeroWidget(
                            tag: cardsList[index].image ?? '',
                            child: Badge.count(
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              offset: const Offset(-2, -8),
                              largeSize: 20,
                              isLabelVisible:
                                  cardsList[index].cardQuantity! >= 1,
                              count: cardsList[index].cardQuantity ?? 0,
                              child: ImageCached(
                                  imageURL: cardsList[index].image ?? ''),
                            )),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
