import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:card_keeper/screens/cards_list_screen/main.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/filter_functions.dart';
import 'package:flutter/material.dart';

void showStatsModal(
    List<PokemonCard> cards, CardsStats status, BuildContext context) {
  final stats = status;

  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    clipBehavior: Clip.hardEdge,
    backgroundColor: Colors.black,
    showDragHandle: true,
    elevation: 3,
    enableDrag: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '- INFO - ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total de cartas',
                      style: TextStyle(
                        fontSize: 16, // ou 16
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${stats.total}',
                      style: const TextStyle(
                        fontSize: 22, // ou 18
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '- Tipos de cartas - ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                children: CardKind.values.map((k) {
                  final n = stats.perKind[k] ?? 0;
                  final screenW = MediaQuery.of(context).size.width;
                  final containerW = (screenW - 52) / 3;
                  // 50% da tela, considerando margens e spacing (ajuste o "- (10*3)" conforme espaçamento/margem externa)
      
                  return Container(
                    width: containerW,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          kindLabel(k),
                          style: const TextStyle(
                            fontSize: 14, // ou 16
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "$n",
                          style: const TextStyle(
                            fontSize: 20, // ou 18
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '- Tipos de Pokémon - ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                children: stats.pokemonPerType.entries.map((k) {
                  final typeName = k.key;
                  final count = k.value;
                  
                  final screenW = MediaQuery.of(context).size.width;
                  final containerW = (screenW - 42) / 2;
                  // 50% da tela, considerando margens e spacing (ajuste o "- (42*2)" conforme espaçamento/margem externa)
      
                  final typeEnum = PokemonTypesIcon.values.firstWhere(
                    (t) => t.typeName.toLowerCase() == typeName.toLowerCase(),
                    orElse: () => PokemonTypesIcon.normal, // fallback
                  );
      
                  return Container(
                    width: containerW,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Image.asset(
                              typeEnum.iconSrc,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              typeEnum.typeName,
                              style: const TextStyle(
                                fontSize: 16, // ou 16
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 20, // ou 16
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '- Coleções - ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Wrap(
                spacing: 10,
                children: stats.perColection.entries.map((k) {
      
                  final collectionName = k.key;
                  final collectionCount = k.value.toString();
                  
                  final screenW = MediaQuery.of(context).size.width;
                  final containerW = (screenW - 42) / 2;
                  // 50% da tela, considerando margens e spacing (ajuste o "- (42*2)" conforme espaçamento/margem externa)
      
                  return Container(
                    width: containerW,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                              collectionName,
                              style: const TextStyle(
                                fontSize: 16, // ou 16
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          collectionCount,
                          style: const TextStyle(
                            fontSize: 20, // ou 16
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}