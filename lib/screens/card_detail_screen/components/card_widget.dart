import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/screens/card_detail_screen/main.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.size,
    required this.widget,
  });

  final Size size;
  final SearchCardDetailPage widget;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
          width: widget.size.width * 0.90,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: HeroWidget(
            tag: widget.widget.card.image ?? '',
            child: Image.network(
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              widget.widget.card.image ?? '',
            ),
          ),
        );
  }
}
