import 'package:flutter/material.dart';

enum ScrollDirection { up, down, none }

void scrollToPosition(ScrollController controller, ScrollDirection direction) {
  if (!controller.hasClients) return;

  switch (direction) {
    case ScrollDirection.up:
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      break;

    case ScrollDirection.down:
      controller.animateTo(
        controller.position.maxScrollExtent + 3,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      break;

    case ScrollDirection.none:
      break;
  }
}

bool shouldShowScrollToBottomButton(ScrollController controller) {
  if (!controller.hasClients) return false;
  return controller.position.pixels < controller.position.maxScrollExtent - 100;
}
