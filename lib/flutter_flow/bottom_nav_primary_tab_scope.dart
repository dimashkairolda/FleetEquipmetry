import 'package:flutter/material.dart';

/// True when the page is embedded in [NavBarPage] as a **current** bottom bar item.
/// AppBars should omit back / «to profile» in this case.
class BottomNavPrimaryTabScope extends InheritedWidget {
  const BottomNavPrimaryTabScope({
    super.key,
    required this.isPrimaryTab,
    required super.child,
  });

  final bool isPrimaryTab;

  static bool isPrimaryTabOf(BuildContext context) {
    return context
            .dependOnInheritedWidgetOfExactType<BottomNavPrimaryTabScope>()
            ?.isPrimaryTab ??
        false;
  }

  @override
  bool updateShouldNotify(BottomNavPrimaryTabScope oldWidget) =>
      isPrimaryTab != oldWidget.isPrimaryTab;
}
