import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/screens/search_screen/components/card_search_bar.dart';
import 'package:card_keeper/screens/search_screen/components/search_content.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CardListItem>? cardList;
  bool isLoading = false;
  bool isLoaded = false;

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

  void searchCard(String searchText) {
    search(searchText);
  }

  bool get isWeb => kIsWeb;

  @override
  Widget build(BuildContext context) {
    return ContainerWithBg(
        child: Scaffold(
      appBar: TopBar(
        centerWidget: CardSearchBar(onSubmit: searchCard),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchContent(
              isLoaded: isLoaded,
              isLoading: isLoading,
              cardList: cardList ?? [],
            )
          ],
        ),
      ),
    ));
  }
}
