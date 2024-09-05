import 'package:card_keeper/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MainApp());
}

