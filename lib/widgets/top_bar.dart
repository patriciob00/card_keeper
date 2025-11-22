import 'package:flutter/material.dart';

class TopBar extends AppBar {
  TopBar({super.key, this.centerWidget, this.actionsWidget, this.centerTitle = false, this.hasBack = false, this.context })
      : super(
          centerTitle: centerTitle,
          bottomOpacity: 30.0,
          backgroundColor: Colors.black.withValues(alpha: .3),
          elevation: 0.0,
          shadowColor: Colors.black,
          surfaceTintColor: Colors.white,
          scrolledUnderElevation: 20.0,
          title: centerWidget,
          actions: actionsWidget ?? [],
          leading: hasBack! ? IconButton(
              style: IconButton.styleFrom(
                  iconSize: 40.0, fixedSize: const Size(40.0, 40.0)),
              color: Colors.white,
              onPressed: () {
                if(context != null) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 30.0,
              )) : Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Image.asset('assets/images/icon-pokeball.png',
                  width: 10, height: 10)),
        );

  final Widget? centerWidget;
  final List<Widget>? actionsWidget;
  final bool? hasBack;
  final BuildContext? context;

  
  @override
  // ignore: overridden_fields
  final bool? centerTitle;

}
