// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';
import 'package:pgoldapp/src/reusables/extensions/string2.dart';

class BalanceText extends StatelessWidget {
  const BalanceText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "₦ ${"70127237".formatAmount()}",
      style: context.textTheme.headlineSmall
          ?.copyWith(color: ColorConfig.textWhite, fontWeight: FontWeight.w600),
    );
  }
}
