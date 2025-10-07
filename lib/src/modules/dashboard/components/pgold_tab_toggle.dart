import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';

class PgoldTabToggle extends StatelessWidget {
  final String text;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const PgoldTabToggle({
    super.key,
    required this.text,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isSelected
        ? ColorConfig.primaryBlueLight
        : ColorConfig.backgroundLightGrey;
    final Color foregroundColor =
        isSelected ? ColorConfig.textWhite : ColorConfig.textGrey;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageViewer(iconPath, color: foregroundColor),
              const SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(
                  color: foregroundColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
