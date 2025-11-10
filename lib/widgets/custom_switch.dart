import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({ 
    super.key, 
    this.icon, 
    required this.title, 
    this.activeColor = Colors.green,
    this.isActive = false,
    required this.setIsActive,
  });

  final Icon? icon;
  final String title;
  final Color? activeColor; 
  final bool isActive;
  final Function(bool value) setIsActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setIsActive(isActive == true ? false : true),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (icon != null) 
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: icon
                ),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
            SizedBox(
              width: 50,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Switch(
                  activeColor: activeColor ?? Colors.green,
                  value: isActive,
                  onChanged: setIsActive,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}