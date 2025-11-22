import 'package:flutter/material.dart';

class CardSearchBarInline extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;

  const CardSearchBarInline({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          filled: true,
          fillColor: Colors.black.withValues(alpha: .5),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            borderSide: BorderSide(
              color: Color.fromARGB(120, 255, 255, 255),
              width: 0.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            borderSide: BorderSide(color: Colors.white, width: 0.5),
          ),
          hintText: "Buscar...",
          hintStyle: const TextStyle(
            color: Color(0xffb2b2b2),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.white),
          prefixIconColor: Colors.white,
        ),
      ),
    );
  }
}