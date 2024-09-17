import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ImageCached extends StatelessWidget {
  const ImageCached(
      {super.key,
      required this.imageURL,
      this.placeholderURL = 'assets/images/card-back.png',
      this.errorWidget});

  final String imageURL;

  final String? placeholderURL;

  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      filterQuality: FilterQuality.high,
      fadeInDuration: const Duration(milliseconds: 150),
      fit: BoxFit.contain,
      imageUrl: imageURL,
      placeholderFadeInDuration: const Duration(milliseconds: 150),
      placeholder: (_, __) => Image.asset(
        placeholderURL!,
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
      errorWidget: (_, __, ___) => errorWidget ?? const Icon(
        Symbols.photo_sharp,
        color: Colors.white,
      ),
    );
  }
}
