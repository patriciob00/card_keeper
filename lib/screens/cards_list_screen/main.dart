import 'package:card_keeper/controllers/pokemon_cards_controller.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/repositories/pokemon_cards_repository.dart';
import 'package:card_keeper/widgets/card_with_ripple.dart';
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
                          child: ImageCached(imageURL: card.image ?? '')),
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

  @override
  Widget build(BuildContext context) {
    double appBarheight = Scaffold.of(context).appBarMaxHeight ?? 60;
    double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    final cardsList =
        ref.watch<List<PokemonCard>>(pokemonCardsRepositoryProvider);

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
                      childAspectRatio: 2 / 2.8,
                    ),
                    itemCount: cardsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(clipBehavior: Clip.none, children: [
                        CardWithRipple(
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
                  ),
          ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 16,
      height: 16,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: child,
    );
  }
}
