import "package:flutter/material.dart";

import "../utils/view_utils.dart";

extension ContextExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;

  RouteSettings? get settings => ModalRoute.of(this)?.settings;

  Object? get args => ModalRoute.of(this)?.settings.arguments;

  bool get isTablet => ViewUtils.isTablet(this);

  bool get isMobile => ViewUtils.isMobile(this);

  bool get isDesktop => ViewUtils.isDesktop(this);
}

enum ButtonSheetTransition { newSheet, newPage }
