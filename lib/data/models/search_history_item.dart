// To parse this JSON data, do
//
//     final searchHistoryItem = searchHistoryItemFromJson(jsonString);

import 'dart:convert';

import 'package:card_keeper/data/models/card_list_item_model.dart';

SearchHistoryItem searchHistoryItemFromJson(String str) => SearchHistoryItem.fromJson(json.decode(str));

String searchHistoryItemToJson(SearchHistoryItem data) => json.encode(data.toJson());

class SearchHistoryItem {
    DateTime searchedAt;
    String searchTerm;
    List<CardListItem>? results;

    SearchHistoryItem({
        required this.searchedAt,
        required this.searchTerm,
        required this.results,
    });

    SearchHistoryItem copyWith({
        DateTime? searchedAt,
        String? searchTerm,
        List<CardListItem>? results,
    }) => 
        SearchHistoryItem(
            searchedAt: searchedAt ?? this.searchedAt,
            searchTerm: searchTerm ?? this.searchTerm,
            results: results ?? this.results,
        );

    factory SearchHistoryItem.fromJson(Map<String, dynamic> json) => SearchHistoryItem(
        searchedAt: DateTime.parse(json["searched_at"]),
        searchTerm: json["search_term"],
        results: json["results"] == null ? [] : List<CardListItem>.from(json["results"]!.map((x) => CardListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "searched_at": searchedAt.toIso8601String(),
        "search_term": searchTerm,
        "results": results == null || results!.isEmpty ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}