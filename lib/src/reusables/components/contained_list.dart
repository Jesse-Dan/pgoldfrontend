import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/color_config.dart';

class ContainedList extends ConsumerWidget {
  const ContainedList({
    super.key,
    required this.children,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 16.0,
    this.hasOuterDivider = false,
  });

  final List<Widget> children;

  final EdgeInsetsGeometry padding;

  final double borderRadius;

  final bool hasOuterDivider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> itemsWithDividers = children.isNotEmpty
        ? children
            .take(children.length - 1)
            .map(
              (item) => [
                item,
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                  color: Color(0xFFF0F0F0),
                ),
              ],
            )
            .expand((element) => element)
            .toList()
        : [];

    if (children.isNotEmpty) {
      itemsWithDividers.add(children.last);
    }

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: ColorConfig.surfaceWhite,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasOuterDivider
              ? Border.all(
                  color: ColorConfig.textGrey.withOpacity(0.2),
                  width: 1.0,
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: itemsWithDividers,
        ),
      ),
    );
  }
}
