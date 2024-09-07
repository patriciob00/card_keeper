import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final Size size;
  final bool animate;
  final Function moreOptionsFn;

  const TopBar({ super.key, required this.size, required this.animate, required this.moreOptionsFn });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.0,
      width: size.width,
      child: AnimatedOpacity(
        opacity: animate ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.chevron_left,
                      color: Colors.white, size: 28.0)),
              IconButton(
                  onPressed: () => moreOptionsFn(),
                  icon: const Icon(Icons.more_vert_rounded,
                      color: Colors.white, size: 24.0)),
            ],
          ),
      ),
    );
  }
}
