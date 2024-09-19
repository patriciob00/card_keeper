
import 'package:card_keeper/data/models/search_history_item.dart';
import 'package:card_keeper/repositories/card_search_history.dart';
import 'package:card_keeper/storage/search_history_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchHistoryController {
  final WidgetRef ref;
  const SearchHistoryController({required this.ref});

  static final SearchHistoryStorage _searchStorage = SearchHistoryStorage();

  Future<void> addSearchLog(SearchHistoryItem log) async {
    await ref.read(cardSearchHistoryProvider.notifier).addNewLog(log);

    await _searchStorage.saveSearchHistoryItem(log);
  }


  Future<void> initializeSearchHistoryFromDb() async {
    List<SearchHistoryItem> logsList = await _searchStorage.getSearchHistoryList();

    await ref.read(cardSearchHistoryProvider.notifier).addList(logsList);
  }
}
