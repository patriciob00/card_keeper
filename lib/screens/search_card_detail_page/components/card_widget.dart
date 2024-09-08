import 'package:card_keeper/components/hero_widget.dart';
import 'package:card_keeper/screens/search_card_detail_page/main.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.isExpanded,
    required this.size,
    required this.widget,
  });

  final Size size;
  final SearchCardDetailPage widget;
  final bool isExpanded;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));

    _animation = ColorTween(begin: Colors.transparent, end: Colors.black87)
        .animate(CurvedAnimation(
            curve: Curves.decelerate, parent: _animationController));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.reset();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Material(
        color: Colors.transparent,
        elevation: 5.0,
        shadowColor: _animation.value,
        borderOnForeground: true,
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: Container(
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
        ),
      ),
    );
  }
}
