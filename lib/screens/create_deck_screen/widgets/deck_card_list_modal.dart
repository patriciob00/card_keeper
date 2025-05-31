import 'package:card_keeper/extensions/deck_card_extensions.dart';
import 'package:card_keeper/screens/create_deck_screen/widgets/show_add_to_deck_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:card_keeper/repositories/deck_cards_notifier.dart';

void showDeckCardListModal(BuildContext context, WidgetRef ref) {
  final cards = ref.read(deckCardsProvider);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      final screenHeight = MediaQuery.of(context).size.height;

      return SizedBox(
        height: screenHeight * 0.5, // Limita o modal à metade da tela
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Cartas no deck',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: cards.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return ListTile(
                      leading: card.image != null
                          ? Image.network(card.image!, width: 40, fit: BoxFit.cover)
                          : const Icon(Icons.image_not_supported),
                      title: Text(card.name ?? 'Sem nome'),
                      subtitle: Text('Quantidade: ${card.deckRequiredQuantity}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.pop(context);
                          showAddToDeckBottomSheet(
                            context: context,
                            ref: ref,
                            card: card.toCardListItem(),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}