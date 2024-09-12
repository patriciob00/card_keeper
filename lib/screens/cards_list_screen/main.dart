import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  // List<PokemonCard> cardsList = [];

  @override
  void initState() {
    super.initState();
    _pkmnCardsController = PokemonCardsControler(ref: ref);
  }

  @override
  Widget build(BuildContext context) {

    double appBarheight = Scaffold.of(context).appBarMaxHeight ?? 60;
    double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    final List<PokemonCard> cardsList =
        _pkmnCardsController.getCardsList();


    return ContainerWithBg(
        child: Scaffold(
      appBar: TopBar(
        centerWidget: const Text(
          'Cards',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
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
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: EdgeInsets.only(
                          top: appBarheight + 10.0,
                          bottom: bottomTabHeight + 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: cardsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {},
                            child: HeroWidget(
                                tag: cardsList[index].image ?? '',
                                child: Badge.count(
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  offset: const Offset(-2, -8),
                                  largeSize: 20,
                                  isLabelVisible: cardsList[index].cardQuantity! >= 1,
                                  count: cardsList[index].cardQuantity ?? 0,
                                  child: FadeInImage.assetNetwork(
                                    placeholderFit: BoxFit.cover,
                                    placeholder: 'images/card-back.png',
                                    image: cardsList[index].image ?? '',
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                  ),
                                )));
                      },
                    ),
            ),
        ),
      ),
    );
  }
}




// GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 15,
//                 crossAxisSpacing: 15,
//                 childAspectRatio: 2 / 3,
//               ),
//               itemCount: cardsList.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return GestureDetector(
//                     onTap: () {},
//                     child: HeroWidget(
//                         tag: cardsList[index].image ?? '',
//                         child: FadeInImage.assetNetwork(
//                           placeholderFit: BoxFit.cover,
//                           placeholder: 'images/card-back.png',
//                           image: cardsList[index].image ?? '',
//                           fit: BoxFit.contain,
//                           filterQuality: FilterQuality.high,
//                         )));
//               },
//             )
