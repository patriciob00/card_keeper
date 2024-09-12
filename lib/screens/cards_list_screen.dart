import 'package:card_keeper/widgets/main_bar.dart';
import 'package:card_keeper/widgets/top_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardListScreen extends ConsumerStatefulWidget {
  const CardListScreen(
      {super.key, required this.currentIdx, required this.onTap});

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends ConsumerState<CardListScreen> {
  bool get isWeb => kIsWeb;

  @override
  Widget build(BuildContext context) {
    final paddingTop = MainBar().preferredSize.height + (isWeb ? 60 : 0.0);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/splash_bg.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: TopBar(
          centerWidget: const Text('Cards', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),),
          actionsWidget: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list, color: Colors.white,))
          ],
        ),
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Padding(
          padding:
              EdgeInsets.only(top: paddingTop, left: 20, right: 20),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
