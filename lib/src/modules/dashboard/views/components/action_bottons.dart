// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class ActionBottons extends StatelessWidget {
  const ActionBottons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          OutlinedButton.icon(
            onPressed: () {},
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: Text(
                "Withdraw".padRight(8, ' '),
                style: context.textTheme.titleMedium?.copyWith(
                    color: ColorConfig.primaryBlueLight,
                    fontWeight: FontWeight.w500),
              ),
            ),
            icon: AppImageViewer(AssetConfig.arrowLeftDownCircle),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            label: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
              child: Text(
                "Deposit".padRight(8, ' '),
                style: context.textTheme.titleMedium?.copyWith(
                    color: ColorConfig.primaryBlueLight,
                    fontWeight: FontWeight.w500),
              ),
            ),
            icon: AppImageViewer(AssetConfig.send),
          )
        ],
      ),
    );
  }
}
