import 'package:card_keeper/widgets/top_bar.dart';
import 'package:card_keeper/widgets/container_with_bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

class DeckListScreen extends ConsumerStatefulWidget {
  const DeckListScreen({
    super.key,
    required this.currentIdx,
    required this.onTap,
  });

  final int currentIdx;
  final Function(int idx) onTap;

  @override
  ConsumerState<DeckListScreen> createState() => _DeckListScreenState();
}

class _DeckListScreenState extends ConsumerState<DeckListScreen> {
  final List<String> decks = [];

  @override
  Widget build(BuildContext context) {
    return ContainerWithBg(
        child: Scaffold(
      appBar: TopBar(
        centerWidget: const Text(
          'Decks',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
        ),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: decks.isEmpty
          ? Stack(
              children: [
                Positioned(
                    left: MediaQuery.of(context).size.width * 0.1,
                    bottom: MediaQuery.of(context).size.height * 0.11,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: const Offset(-4, 4),
                                ),
                              ]),
                          child: const Text(
                            'Clique aqui para adicionar \n um novo deck',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 30,
                            left: MediaQuery.of(context).size.width * 0.45,
                          ),
                          child: Image.asset(
                            'assets/images/arrow-right.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.high,
                            width: 80,
                            height: 80,
                          ),
                        )
                      ],
                    ))
              ],
            )
          : SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: const SizedBox(),
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 85.0),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          focusElevation: 10.0,
          child: SafeArea(
            maintainBottomViewPadding: true,
            bottom: true,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(-4, 4),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: const Icon(
                Symbols.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
