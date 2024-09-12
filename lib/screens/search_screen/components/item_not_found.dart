import 'package:flutter/material.dart';

class ItemNotFound extends StatelessWidget {
  const ItemNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Nenhum resultado encontrado',
      style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1.5, 1.5),
              blurRadius: 6.0,
              color: Color.fromARGB(150, 255, 255, 255),
            ),
          ]),
    ));
  }
}