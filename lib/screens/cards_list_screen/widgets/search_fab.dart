import 'package:card_keeper/screens/cards_list_screen/widgets/search_bar_inline.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SearchFAB extends StatelessWidget {
const SearchFAB({
  super.key,
  this.showSearchBar = false,
  required this.searchController,
  required this.onChangetext,
  required this.onToggleFAB,
});

final bool showSearchBar;
final TextEditingController searchController;
final Function(String value) onChangetext;
final VoidCallback onToggleFAB;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
                minimum: const EdgeInsets.only(bottom: 16, right: 0),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 65.0, right: 0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      const fabSize = 86.0;
                      const spacing = 8;
                      final maxWidth = constraints.maxWidth;
                      final searchWidth =
                          showSearchBar ? (maxWidth - fabSize - spacing) : 0.0;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              width: searchWidth.clamp(0.0, maxWidth),
                              child: showSearchBar
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: CardSearchBarInline(
                                        controller: searchController,
                                        onChanged: onChangetext,
                                      ),
                                    )
                                  : const SizedBox.shrink()),
                          if (showSearchBar) const SizedBox(width: 8),
                          FloatingActionButton(
                            elevation: 1.0,
                            backgroundColor: Colors.black87,
                            onPressed: onToggleFAB,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusElevation: 10.0,
                            child: Icon(
                              showSearchBar ? Symbols.close : Symbols.search,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
  }
}