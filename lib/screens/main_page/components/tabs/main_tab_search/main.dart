import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/screens/main_page/components/main_bar.dart';
import 'package:card_keeper/screens/main_page/components/tabs/main_tab_search/components/card_search_bar.dart';
import 'package:card_keeper/screens/main_page/components/tabs/main_tab_search/components/search_content.dart';
import 'package:flutter/material.dart';

class MainTabSearch extends StatefulWidget {
  const MainTabSearch({super.key});

  @override
  State<MainTabSearch> createState() => _MaintabSearchState();
}

class _MaintabSearchState extends State<MainTabSearch> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: MainBarWithGlass().preferredSize.height + 65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CardSearchBar(onSubmit: searchCard),
          SearchContent(
            isLoaded: isLoaded,
            isLoading: isLoading,
            cardList: cardList ?? [],
          )
        ],
      ),
    );
  }
}