import 'package:flutter/material.dart';

class TopBar extends AppBar {
  TopBar({super.key, this.centerWidget, this.actionsWidget, this.centerTitle = false })
      : super(
          centerTitle: centerTitle,
          bottomOpacity: 30.0,
          backgroundColor: Colors.black.withOpacity(0.3),
          elevation: 10.0,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 20.0,
          title: centerWidget,
          actions: actionsWidget ?? [],
          leading: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Image.asset('assets/images/icon-pokeball.png',
                  width: 10, height: 10)),
        );

  final Widget? centerWidget;
  final List<Widget>? actionsWidget;

  
  @override
  // ignore: overridden_fields
  final bool? centerTitle;

}
