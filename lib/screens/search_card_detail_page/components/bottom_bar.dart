import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar(
      {super.key,
      required this.size,
      required this.animate,
      required this.isAlreadyOnList,
      required this.saveNewPokemon,
      required this.removePokemon,
    });

  final Size size;
  final bool animate;
  final bool isAlreadyOnList;
  final Function saveNewPokemon;
  final Function removePokemon;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int cardQuantity = 1;

  void increaseQuantity() {
    setState(() {
      cardQuantity = ++cardQuantity;
    });
  }

  void decreaseQuantity() {
    if(cardQuantity > 1) {
      setState(() {
      cardQuantity = --cardQuantity;
    });
    }
    
  }

  @override
  Widget build(BuildContext context) {
    const iconfavorite = Icon(Icons.favorite, color: Colors.red, size: 15);
    const iconDelete = Icon(Icons.delete, color: Colors.grey, size: 20);

    return Positioned(
      bottom: 10.0,
      width: widget.size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: AnimatedOpacity(
          opacity: widget.animate ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                  onPressed: () {
                    if(widget.isAlreadyOnList) {
                      widget.removePokemon();
                    } else {
                      widget.saveNewPokemon(cardQuantity);
                    }
                  },
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: widget.isAlreadyOnList ? iconDelete : iconfavorite),
                    Text(widget.isAlreadyOnList ? 'Remover' : 'Adicionar',
                        style: const TextStyle(color: Colors.white)),
                  ])),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.8), width: 0.8),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () { increaseQuantity(); },
                      child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                    SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          cardQuantity.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: cardQuantity < 1 ? null : () { decreaseQuantity(); },
                      child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
