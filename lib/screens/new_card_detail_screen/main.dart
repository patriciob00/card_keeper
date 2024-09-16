import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:card_keeper/data/models/pokemon_card.dart';
import 'package:card_keeper/screens/card_detail_screen/components/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewCardDetailScreen extends ConsumerStatefulWidget {
  const NewCardDetailScreen({super.key, required this.card});

  final CardListItem card;

  @override
  ConsumerState<NewCardDetailScreen> createState() =>
      _NewCardDetailScreenState();
}

class _NewCardDetailScreenState extends ConsumerState<NewCardDetailScreen> {
  PokemonCard? currentPokemon;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: CachedNetworkImage(imageUrl: widget.card.image ?? '', fit: BoxFit.cover, filterQuality: FilterQuality.high,),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  stops: [
                    0.2,
                    0.0
                  ]),
            ),
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          //   child: Center(
          //     child: CardWidget(
          //       size: size,
          //       widget: widget,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
