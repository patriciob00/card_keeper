import 'package:card_keeper/widgets/card_with_ripple/holo_effect.dart';
import 'package:card_keeper/widgets/card_with_ripple/reverse_holo_effect.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';

class CardWithRipple extends StatelessWidget {
  const CardWithRipple({
    super.key,
    this.tag = '',
    required this.imageURL,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.showHoloEffect = false,
    this.showReverseHoloEffect = false,
    this.disableHero = false,
  });

  final String tag;
  final String imageURL;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final bool? showHoloEffect;
  final bool? showReverseHoloEffect;
  final bool? disableHero;

  void _onTap() {
    if (onTap != null) {
      onTap!();
    }
  }

  void _onDoubleTap() {
    if (onDoubleTap != null) {
      onDoubleTap!();
    }
  }

  void _onLongPress() {
    if (onLongPress != null) {
      onLongPress!();
    }
  }

  Widget content(Widget initialContent) {
    if (disableHero == true) {
      return initialContent;
    } else {
      return HeroWidget(
        tag: tag,
        child: initialContent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      content(Stack(children: [
        ImageCached(
          imageURL: imageURL,
        ),
        if (showHoloEffect == true) const Positioned.fill(child: HoloEffect()),
        if (showReverseHoloEffect == true)
          const Positioned.fill(child: ReverseHoloEffect())
      ])),
      Positioned.fill(
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white24,
                onDoubleTap: () => _onDoubleTap(),
                onTap: () => _onTap(),
                onLongPress: () => _onLongPress(),
              ))),
    ]);
  }
}
