import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shimmer/shimmer.dart';

class ImageCached extends StatelessWidget {
  const ImageCached({
    super.key,
    required this.imageURL,
    this.placeholderURL = 'assets/images/card-back.png',
    this.errorWidget,
    this.opacity = 1.0, // padrão: visível
    this.fit = BoxFit.contain, // padrão original
    this.width,
    this.height,
    this.showHoloEffect = false,
  });

  final String imageURL;
  final String? placeholderURL;
  final Widget? errorWidget;
  final double opacity;
  final BoxFit fit;
  final double? width;
  final double? height;
  final bool? showHoloEffect;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Opacity(
      opacity: opacity,
      child: Stack(children: [
        CachedNetworkImage(
          imageUrl: imageURL,
          width: width,
          height: height,
          fit: fit,
          filterQuality: FilterQuality.high,
          fadeInDuration: const Duration(milliseconds: 150),
          placeholderFadeInDuration: const Duration(milliseconds: 150),
          placeholder: (_, __) => Image.asset(
            placeholderURL!,
            fit: fit,
            width: width,
            height: height,
            filterQuality: FilterQuality.high,
          ),
          errorWidget: (_, __, ___) =>
              errorWidget ??
              const Icon(
                Symbols.photo_sharp,
                color: Colors.white,
              ),
        ),
        if (showHoloEffect == true) Shimmer.fromColors(
          baseColor: Colors.transparent, 
          highlightColor: Colors.white70,
          period: const Duration(milliseconds: 2500),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(8),
            ),
            width: size.width,
            height: size.height * 0.27,
          )
        ),
      ]),
    );
  }
}
