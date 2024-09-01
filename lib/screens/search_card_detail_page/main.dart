import 'package:card_keeper/components/hero_widget.dart';
import 'package:card_keeper/data/models/card_list_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const Color commonBgColor = Color(0xff17203A);

class SearchCardDetailPage extends StatefulWidget {
  final CardListItem card;

  const SearchCardDetailPage({super.key, required this.card});

  @override
  State<SearchCardDetailPage> createState() => SearchCardDetailPageState();
}

class SearchCardDetailPageState extends State<SearchCardDetailPage> {
  bool isExpanded = true;
  int quantity = 1;

  void addQuantity() {
    setState(() {
      quantity = quantity + 1;
    });
  }

  void removeQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity = quantity - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                bottom: isExpanded ? 120 : 200,
                width: size.width * 0.85,
                child: Row(
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 2.0,
                      fillColor: commonBgColor,
                      padding: const EdgeInsets.all(10.0),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 35.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    QuantityCtrl(
                        quantity: quantity,
                        remove: removeQuantity,
                        add: addQuantity),
                    RawMaterialButton(
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: commonBgColor,
                      padding: const EdgeInsets.all(10.0),
                      shape: const CircleBorder(),
                      child: const Icon(
                        Icons.save_alt,
                        size: 35.0,
                        color: Colors.lightGreen,
                      ),
                    )
                  ],
                ),
              ),
              CardWidget(
                isExpanded: isExpanded,
                size: size,
                widget: widget,
                quantity: quantity,
              )
            ],
          )),
        ));
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.isExpanded,
    required this.size,
    required this.widget,
    required this.quantity,
  });

  final bool isExpanded;
  final Size size;
  final SearchCardDetailPage widget;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        bottom: isExpanded ? 250 : 100,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: size.width * 0.8,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: HeroWidget(
            tag: widget.card.image ?? '',
            child: Image.network(
              fit: BoxFit.fitWidth,
              widget.card.image ?? '',
            ),
          ),
        ));
  }
}

class QuantityCtrl extends StatelessWidget {
  final int quantity;
  final Function add;
  final Function remove;

  const QuantityCtrl(
      {super.key,
      required this.quantity,
      required this.add,
      required this.remove});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                  color: commonBgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                  boxShadow: [
                    BoxShadow(
                      color: commonBgColor.withOpacity(0.2),
                      offset: const Offset(-5, 10),
                      blurRadius: 40,
                    ),
                  ]),
              child: Wrap(
                  spacing: 16,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (quantity > 1) {
                          remove();
                        }
                      },
                      child: const Icon(Icons.remove, color: Colors.black,),
                    ),
                    SizedBox(
                      width: 28,
                      child: Text(
                        quantity.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        add();
                      },
                      child: const Icon(Icons.add, color: Colors.black,),
                    ),
                  ]),
            ),
          ],
        ));
  }
}
