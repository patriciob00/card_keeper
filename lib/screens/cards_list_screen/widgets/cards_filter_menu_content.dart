
import 'package:card_keeper/data/models/card_variant.dart';
import 'package:card_keeper/data/providers/enums.dart';
import 'package:card_keeper/screens/cards_list_screen/utils/filter_functions.dart';
import 'package:card_keeper/screens/cards_list_screen/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';


class CardsFilterMenuContent extends StatefulWidget {
  const CardsFilterMenuContent({
    super.key,
    required this.initialKinds,
    required this.initialTypes,
    required this.initialVariants,
    required this.initialRarities,
    required this.availableRarities,
    required this.initialOnlyForSale,
    required this.initialOnlyForExchange,
    required this.onApply,
    required this.onClear,
  });

  final Set<CardKind> initialKinds;
  final Set<String> initialTypes;
  final Set<CardVariant> initialVariants;
  final Set<String> initialRarities;
  final List<String> availableRarities;
  final bool initialOnlyForSale;
  final bool initialOnlyForExchange;

  /// Chamado quando o usuário clica em "Aplicar"
  final void Function(
    Set<CardKind> kinds,
    Set<String> types,
    Set<CardVariant> variants,
    Set<String> rarities,
    bool onlyForSale,
    bool onlyForExchange,
  ) onApply;

  /// Chamado quando o usuário clica em "Limpar"
  final VoidCallback onClear;

  @override
  State<CardsFilterMenuContent> createState() =>
      _CardsFilterMenuContentState();
}

class _CardsFilterMenuContentState extends State<CardsFilterMenuContent> {
  late Set<CardKind> draftKinds;
  late Set<String> draftTypes;
  late Set<CardVariant> draftVariants;
  late Set<String> draftRarities;
  late bool draftSale;
  late bool draftExchange;

  @override
  void initState() {
    super.initState();
    draftKinds = Set<CardKind>.from(widget.initialKinds);
    draftTypes = Set<String>.from(widget.initialTypes);
    draftVariants = Set<CardVariant>.from(widget.initialVariants);
    draftRarities = Set<String>.from(widget.initialRarities);
    draftSale = widget.initialOnlyForSale;
    draftExchange = widget.initialOnlyForExchange;
  }

  Widget _kindChip(CardKind k) {
    final selected = draftKinds.contains(k);
    return FilterChip(
      selected: selected,
      label: Text(kindLabel(k)),
      onSelected: (_) {
        setState(() {
          if (selected) {
            draftKinds.remove(k);
          } else {
            draftKinds.add(k);
          }
        });
      },
    );
  }

  Widget _typeChip(PokemonTypesIcon t) {
    final selected = draftTypes.contains(t.typeName);
    return FilterChip(
      selected: selected,
      avatar: Image.asset(t.iconSrc, width: 18, height: 18),
      label: Text(t.typeName),
      onSelected: (_) {
        setState(() {
          if (selected) {
            draftTypes.remove(t.typeName);
          } else {
            draftTypes.add(t.typeName);
          }
        });
      },
    );
  }

  String _variantLabel(CardVariant v) {
    switch (v) {
      case CardVariant.holo:
        return 'Holo';
      case CardVariant.reverse:
        return 'Reverse';
      default:
        return 'Normal';
    }
  }

  Widget _variantChip(CardVariant v) {
    final selected = draftVariants.contains(v);
    Map<CardVariant, Color>colorVariant = {
      CardVariant.holo: Colors.deepPurple,
      CardVariant.reverse: Colors.deepOrange,
      CardVariant.normal: Colors.black,
    };
    return FilterChip(
      selected: selected,
      label: Text(_variantLabel(v), style: TextStyle(color: colorVariant[v]),),
      onSelected: (_) {
        setState(() {
          if (selected) {
            draftVariants.remove(v);
          } else {
            draftVariants.add(v);
          }
        });
      },
    );
  }

  Widget _rarityChip(String r) {
    final selected = draftRarities.contains(r);
    return FilterChip(
      selected: selected,
      label: Text(r),
      onSelected: (_) {
        setState(() {
          if (selected) {
            draftRarities.remove(r);
          } else {
            draftRarities.add(r);
          }
        });
      },
    );
  }

  void _onClearPressed() {
    widget.onClear();
    Navigator.of(context).pop(); // fecha o menu
  }

  void _onApplyPressed() {
    widget.onApply(
      draftKinds, 
      draftTypes, 
      draftVariants,
      draftRarities,
      draftSale, 
      draftExchange
    );
    Navigator.of(context).pop(); // fecha o menu
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle('Tipo de carta'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CardKind.values.map(_kindChip).toList(),
          ),
          const SizedBox(height: 12),
          const SectionTitle('Tipos de Pokémon'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                PokemonTypesIcon.values.map(_typeChip).toList(),
          ),
          const SizedBox(height: 12),
          const SectionTitle('Variante'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: CardVariant.values.map(_variantChip).toList(),
          ),
          const SizedBox(height: 12),

          const SectionTitle('Raridade'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.availableRarities.map(_rarityChip).toList(),
          ),
          const SizedBox(height: 12),
          const SectionTitle('Disponibilidade'),
          Wrap(
            spacing: 8,
            children: [
              FilterChip(
                selected: draftSale,
                label: const Text('À venda'),
                avatar: const Icon(
                  Symbols.attach_money_rounded,
                  size: 18,
                  color: Colors.lightGreen,
                ),
                onSelected: (_) =>
                    setState(() => draftSale = !draftSale),
              ),
              FilterChip(
                selected: draftExchange,
                label: const Text('Para troca'),
                avatar: const Icon(
                  Symbols.sync_alt_rounded,
                  size: 18,
                  color: Colors.orange,
                ),
                onSelected: (_) =>
                    setState(() => draftExchange = !draftExchange),
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              TextButton.icon(
                onPressed: _onClearPressed,
                icon: const Icon(Icons.clear),
                label: const Text('Limpar'),
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                onPressed: _onApplyPressed,
                child: const Text('Aplicar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}