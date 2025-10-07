// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/balance_text.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/balance_title_text.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/currency_picker.dart';

class BalanceAndCurrency extends StatelessWidget {
  const BalanceAndCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BalanceTitleText(),
              const SizedBox(height: 8),
              BalanceText()
            ],
          ),
          CurrencyPicker()
        ],
      ),
    );
  }
}
