import 'package:flutter/material.dart';

class CardSearchBar extends StatelessWidget {
  final void Function(String) onSubmit;

  const CardSearchBar({
    super.key,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        onSubmitted: onSubmit,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          filled: true,
          fillColor: Colors.black.withOpacity(0.5),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36)),
              borderSide: BorderSide(
                  color: Color.fromARGB(120, 255, 255, 255), width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(36)),
              borderSide: BorderSide(color: Colors.white, width: 0.5)),
          hintText: "Buscar carta",
          hintStyle: const TextStyle(
              color: Color(0xffb2b2b2),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              decorationThickness: 6),
          suffixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.white,
        ),
      ),
    );
  }
}
