import 'package:card_keeper/screens/card_detail_screen/main.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.size,
    required this.widget, this.onTap,
  });

  final Size size;
  final SearchCardDetailPage widget;
  final Function? onTap;


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
    final imageWithRipple = Stack(children: [
      ImageCached(imageURL: widget.widget.card.image ?? ''),
      Positioned.fill(
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.white24,
                  onTap: () =>
                      widget.onTap != null ? widget.onTap!() : null))),
    ]);
    return Container(
      width: widget.size.width * 0.90,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: HeroWidget(
        tag: widget.widget.card.image ?? '',
        child: widget.onTap != null ? imageWithRipple : ImageCached(imageURL: widget.widget.card.image ?? ''),
      ),
    );
  }
}
