import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/screens/search_screen/components/item_not_found.dart';
import 'package:card_keeper/screens/card_detail_screen/main.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchContent extends StatelessWidget {
  final bool isLoading;
  final List<CardListItem> cardList;

  final bool isLoaded;

  const SearchContent({
    super.key,
    required this.isLoading,
    required this.cardList,
    required this.isLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Content(
            isLoading: isLoading, isLoaded: isLoaded, cardList: cardList));
  }
}

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.isLoading,
    required this.isLoaded,
    required this.cardList,
  });

  final bool isLoading;
  final bool isLoaded;
  final List<CardListItem> cardList;

  @override
  Widget build(BuildContext context) {
    void openCardDetailPage(CardListItem card) {
      Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          pageBuilder: ((context, animation, secondaryAnimation) {
            final curvedAnimation = CurvedAnimation(
                parent: animation, curve: const Interval(0, 0.5));
            return FadeTransition(
              opacity: curvedAnimation,
              child: SearchCardDetailPage(
                card: card,
              ),
            );
          })));
    }

    double appBarheight = Scaffold.of(context).appBarMaxHeight as double;
    double bottomTabHeight = const NavigationBarThemeData().height ?? 80;

    return Container(
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isLoaded && cardList.isEmpty
              ? const ItemNotFound()
              : GridView.builder(
                  padding: EdgeInsets.only(
                      top: appBarheight + 10.0, bottom: bottomTabHeight + 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: cardList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          openCardDetailPage(cardList[index]);
                        },
                        child: HeroWidget(
                          tag: cardList[index].image ?? '',
                          child: ImageCached(imageURL: cardList[index].image ?? ''),
                        ));
                  },
                ),
    );
  }
}
