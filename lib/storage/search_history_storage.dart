import 'package:card_keeper/data/models/search_history_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryStorage {
  final SharedPreferencesAsync pref = SharedPreferencesAsync();

  static var searchHistoryListId = 'search_history_list';

  Future<void> saveSearchHistoryItem(SearchHistoryItem log) async {
    List<SearchHistoryItem> logsList = await getSearchHistoryList();

    print('log: $log');
    if(logsList.length >= 4) {
      var aux = [...logsList];

      aux.removeLast();

      aux.add(log);

      await saveSearchHistoryList(aux);
    } else {
      logsList.add(log);
      await saveSearchHistoryList(logsList);
    }

    
  }


  Future<void> saveSearchHistoryList(List<SearchHistoryItem> logs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        logs.map((log) => searchHistoryItemToJson(log)).toList();
    
    await prefs.setStringList(searchHistoryListId, jsonStringList);
  }

  Future<List<SearchHistoryItem>> getSearchHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonStringList = prefs.getStringList(searchHistoryListId);

    if (jsonStringList != null) {
      return jsonStringList
          .map((jsonString) => searchHistoryItemFromJson(jsonString))
          .toList();
    }
    return [];
  }
}
