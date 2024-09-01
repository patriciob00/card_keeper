import 'package:card_keeper/components/curved_painter.dart';
import 'package:card_keeper/components/poke_card/components/pokemon_name.dart';
import 'package:card_keeper/models/constants.dart';
import 'package:flutter/material.dart';

// #694C33
// #A16A31
// #EBA746

class PokeCard extends StatelessWidget {
  static const silverColor = Color(0xff8A8D8F);
  static const pokemonImage =
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png';
  static const fireTypeGradient = [
    Color(0xffEBA746),
    Color(0xffA16A31),
    Color(0xff694C33)
  ];

  const PokeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: RadialGradient(
                      colors: typesGradient['ice']!, radius: 1.6)),
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CustomPaint(
                    painter: CurvedPainter(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const PokemonName(name: 'Charizard', id: 38,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Image.network(
                            pokemonImage,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  )))),
    );
  }
}
