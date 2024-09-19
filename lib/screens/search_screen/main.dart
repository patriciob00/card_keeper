import 'package:card_keeper/controllers/search_history_controller.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/search_history_item.dart';
import 'package:card_keeper/data/service/poke_card_service.dart';
import 'package:card_keeper/repositories/card_search_history.dart';
import 'package:card_keeper/screens/search_screen/components/card_search_bar.dart';
import 'package:card_keeper/screens/search_screen/components/search_content.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<CardListItem>? cardList;
  bool isLoading = false;
  bool isLoaded = false;

  late SearchHistoryController _searchController;

  Future<void> search(String searchTerm) async {
    final pokeCardService = PokeCardService();
    setState(() {
      isLoaded = false;
      isLoading = true;
    });

    cardList = await pokeCardService.searchCard(searchTerm);

    if (cardList != null && cardList!.isNotEmpty) {
      var timeStamp = DateTime.now();

      SearchHistoryItem log = SearchHistoryItem(
          searchedAt: timeStamp,
          searchTerm: searchTerm,
          results: cardList ?? []);
      _searchController.addSearchLog(log);
    }

    setState(() {
      isLoaded = true;
      isLoading = false;
    });
  }

  void useSearchLog(SearchHistoryItem log) {
    print('set state: ${log.results!.length.toString()}');
    setState(() {
      cardList = log.results;  
    });
    
  }

  void searchCard(String searchText) {
    search(searchText);
  }

  bool get isWeb => kIsWeb;

  @override
  void initState() {
    super.initState();
    _searchController = SearchHistoryController(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    final searchLog =
        ref.watch<List<SearchHistoryItem>>(cardSearchHistoryProvider);

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
            if (!isLoaded &&
                !isLoading &&
                searchLog.isNotEmpty &&
                (cardList == null || cardList!.isEmpty))
              LastSearches(
                searchLog: searchLog.where((log) => log.results != null && log.results!.isNotEmpty).toList(),
                useSearchLog: useSearchLog,
              ),
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

class LastSearches extends StatelessWidget {
  const LastSearches({
    super.key,
    required this.searchLog, required this.useSearchLog,
  });

  final Function(SearchHistoryItem log) useSearchLog;

  final List<SearchHistoryItem> searchLog;

  void useLog(SearchHistoryItem log) {
    useSearchLog(log);
  }

  String getDate(DateTime date) {
    return DateFormat.yMd('pt_BR').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height * 0.85,
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Últimos',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 20),
            ),
            const Text('Resultados',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Container(
              width: double.infinity,
              height: size.height * 0.75,
              padding: const EdgeInsets.only(top: 10.0),
              child: GridView.builder(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 2 / 2.78,
                ),
                itemCount: searchLog.length,
                itemBuilder: (BuildContext context, int idx) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    image: NetworkImage(
                                        searchLog[idx].results![0].image ??
                                            ''))),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.transparent),
                            )),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.65)),
                        padding: const EdgeInsets.only(bottom: 10.0, top: 20.0, left: 10.0, right: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Busca: ${searchLog[idx].searchTerm}', textAlign: TextAlign.left, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14),),
                            Text('Data: ${getDate(searchLog[idx].searchedAt)}', textAlign: TextAlign.left, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14),),
                            Text('Resultados: ${searchLog[idx].results!.length.toString()}', textAlign: TextAlign.left, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)

                          ],
                        ),
                      ),
                      Positioned.fill(
                          child: Material(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              color: Colors.transparent,
                              child: InkWell(
                                  splashColor: Colors.white24,
                                  onTap: () => useLog(searchLog[idx])))),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
