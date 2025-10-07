// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class BalanceTitleText extends StatelessWidget {
  const BalanceTitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Wallet Balance",
          style: context.textTheme.titleMedium
              ?.copyWith(color: ColorConfig.textWhite),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
            radius: 10,
            backgroundColor: ColorConfig.surfaceWhite,
            child: AppImageViewer(AssetConfig.eye))
      ],
    );
  }
}
