import 'package:card_keeper/widgets/card_with_ripple/holo_effect.dart';
import 'package:card_keeper/widgets/card_with_ripple/reverse_holo_effect.dart';
import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';

class CardWithRipple extends StatelessWidget {
  const CardWithRipple({
    super.key,
    required this.tag,
    required this.imageURL,
    this.onTap,
    this.onLongPress,
    this.showHoloEffect = false,
    this.showReverseHoloEffect = false,
  });

  final String tag;
  final String imageURL;
  final Function? onTap;
  final Function? onLongPress;
  final bool? showHoloEffect;
  final bool? showReverseHoloEffect;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      HeroWidget(
        tag: tag,
        child: Stack(children: [
          ImageCached(
            imageURL: imageURL,
            showHoloEffect: showHoloEffect,
            showReverseHoloEffect: showReverseHoloEffect,
          ),
          if (showHoloEffect == true)
            const Positioned.fill(child: HoloEffect()),
          if (showReverseHoloEffect == true)
          const Positioned.fill(child: ReverseHoloEffect())
        ]),
      ),
      Positioned.fill(
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.white24,
                  onTap: () => onTap != null ? onTap!() : null,
                  onLongPress: () =>
                      onLongPress != null ? onLongPress!() : null))),
    ]);
  }
}
