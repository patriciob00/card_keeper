import 'package:card_keeper/widgets/hero_widget.dart';
import 'package:card_keeper/widgets/image_cached.dart';
import 'package:flutter/material.dart';

class CardWithRipple extends StatelessWidget {
  const CardWithRipple(
      {super.key,
      required this.tag,
      required this.imageURL,
      this.onTap,
      this.onLongPress,
      this.showHoloEffect = false,
    });

  final String tag;
  final String imageURL;
  final Function? onTap;
  final Function? onLongPress;
  final bool? showHoloEffect;


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      HeroWidget(
        tag: tag,
        child: ImageCached(imageURL: imageURL, showHoloEffect: showHoloEffect,),
      ),
      Positioned.fill(
          child: Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: Colors.transparent,
              child: InkWell(
                  splashColor: Colors.white24,
                  onLongPress: () =>
                      onLongPress != null ? onLongPress!() : null))),
    ]);
  }
}
