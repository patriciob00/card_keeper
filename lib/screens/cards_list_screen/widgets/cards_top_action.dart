import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class CardsTopActions extends StatelessWidget {
  const CardsTopActions({
    super.key,
    required this.showListGrid,
    required this.onToggleListType,
    required this.onOpenFilters,
    required this.onOpenStats,
    required this.hasCards,
    required this.filterNotSelected,
    required this.filterIconKey,
  });

  final bool showListGrid;
  final bool hasCards;
  final bool filterNotSelected;
  final GlobalKey filterIconKey;

  final VoidCallback onToggleListType;
  final VoidCallback onOpenFilters;
  final VoidCallback onOpenStats;

  @override
  Widget build(BuildContext context) {
    if (!hasCards) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Alternar Grid / Lista
        IconButton(
          onPressed: onToggleListType,
          icon: Icon(
            showListGrid ? Symbols.view_cozy_rounded : Symbols.lists_rounded,
            color: Colors.white,
          ),
        ),

        /// Botão de Filtros
        IconButton(
          key: filterIconKey,
          onPressed: onOpenFilters,
          icon: Icon(
            Icons.filter_list,
            color: filterNotSelected ? Colors.white : Colors.deepPurpleAccent,
          ),
        ),

        /// Botão de estatísticas
        IconButton(
          onPressed: onOpenStats,
          icon: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}