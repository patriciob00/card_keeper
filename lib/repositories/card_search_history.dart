import 'package:card_keeper/data/models/search_history_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cardSearchHistoryProvider = StateNotifierProvider<CardSearchHistory, List<SearchHistoryItem>>((ref) => CardSearchHistory(),); 

class CardSearchHistory extends StateNotifier<List<SearchHistoryItem>> {
  
  CardSearchHistory() : super([]);

  addNewLog(SearchHistoryItem log) {
    if(state.length >= 4) {
      var aux  = [...state];
      aux.removeAt(0);
      aux.add(log);
      state = aux;
    } else {
      var aux  = [...state];
      aux.add(log);
      state = aux;
    }
  }

  addList(List<SearchHistoryItem> logs) {
    state = logs;
  }

  int get getTotalOfResults {
    return state.length;
  }
  
}