import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:flutter/material.dart';

class ModalBottomSheet extends StatelessWidget {
  final CardListItem card;

  const ModalBottomSheet({ super.key, required this.card });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.08,
                  child: Image.network(card.image ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(card.name as String, style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text('#${card.localId}', style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),),
                  ],),
                )
              ],
            ),
          ),
          Divider(color: Colors.black.withOpacity(0.3))
        ],
      ),
    );
  }
}