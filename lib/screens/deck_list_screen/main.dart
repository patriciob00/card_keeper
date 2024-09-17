import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckListScreen extends ConsumerStatefulWidget {
  const DeckListScreen({super.key, required this.currentIdx, required this.onTap, });

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends ConsumerState<DeckListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ContainerWithBg(child: SizedBox())
    );
  }
}