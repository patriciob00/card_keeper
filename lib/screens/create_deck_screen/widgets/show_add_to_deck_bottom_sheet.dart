import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/extensions/card_list_item_extensions.dart';
import 'package:card_keeper/repositories/deck_cards_notifier.dart';
import 'package:collection/collection.dart';
import 'package:material_symbols_icons/symbols.dart';

void showAddToDeckBottomSheet({
  required BuildContext context,
  required WidgetRef ref,
  required CardListItem card,
}) {
  final deckCard = ref
      .read(deckCardsProvider)
      .firstWhereOrNull((c) => c.id == card.id);

  int cardQuantity = deckCard?.deckRequiredQuantity ?? 1;

  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Imagem da carta
                if (card.image != null)
                  SizedBox(
                    height: 130,
                    child: Image.network(card.image!, fit: BoxFit.contain),
                  ),

                const SizedBox(height: 12),

                // Nome da carta
                Text(
                  card.name ?? 'Sem nome',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 24),

                // Quantidade
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Symbols.fullscreen_portrait_sharp, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Quantidade no deck',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                          ),
                          onPressed: cardQuantity > 1
                              ? () => setState(() => cardQuantity--)
                              : null,
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            '$cardQuantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                          ),
                          onPressed: () => setState(() => cardQuantity++),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Botões de ação
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ref.read(deckCardsProvider.notifier).addCard(
                                card.toPokemonCard(),
                                cardQuantity,
                              );
                          Navigator.pop(context);
                        },
                        icon: const Icon(Symbols.save_rounded),
                        label: Text(deckCard != null ? 'Atualizar' : 'Adicionar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    if (deckCard != null) ...[
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(deckCardsProvider.notifier)
                                .removeCard(card.id ?? '');
                            Navigator.pop(context);
                          },
                          icon: const Icon(Symbols.delete),
                          label: const Text('Remover'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}