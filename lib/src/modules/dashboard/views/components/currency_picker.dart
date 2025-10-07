// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class CurrencyPicker extends StatelessWidget {
  const CurrencyPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33.99967575073242,
      padding: EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
          color: ColorConfig.surfaceWhite,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: ColorConfig.backgroundLightGrey)),
      child: Row(
        children: [
          CircleAvatar(
              radius: 10,
              backgroundColor: ColorConfig.primaryBlueLight,
              child: AppImageViewer(
                AssetConfig.appIcon,
                height: 11.20038890838623,
              )),
          const SizedBox(width: 4),
          Text(
            "NGN",
            style: context.textTheme.labelSmall,
          ),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 14,
          )
        ],
      ),
    );
  }
}
