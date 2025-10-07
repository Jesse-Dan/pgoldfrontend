import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/color_config.dart';

class AppTile extends ConsumerWidget {
  const AppTile({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.leadingIcon,
    this.trailing,
    this.backgroundColor = ColorConfig.surfaceWhite,
    this.borderColor = const Color(0xFFE0E7FF),
    this.textColor = ColorConfig.textDark,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    this.margin = const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    this.selected = false,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final Widget? trailing;

  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;

  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: margin,
        duration: const Duration(milliseconds: 200),
        padding: padding,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: selected ? ColorConfig.primaryBlueLight : borderColor,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: ColorConfig.primaryBlueLight.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              leadingIcon!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: ColorConfig.textGrey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
