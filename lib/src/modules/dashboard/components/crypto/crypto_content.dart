import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/modules/dashboard/components/crypto/content/crypto_action.dart';
import 'package:pgoldapp/src/modules/dashboard/components/crypto/content/crypto_selector.dart';
import 'package:pgoldapp/src/modules/dashboard/components/disclaimer_text.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/rate_display.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/extensions/amount_formatter.dart';

class CryptoContent extends ConsumerStatefulWidget {
  const CryptoContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CryptoContent();
}

class _CryptoContent extends ConsumerState<CryptoContent> {
  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(pGoldRateProvider);
    final currency = prov.selectedCountry?.currency;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CryptoSelector(),
          CryptoAction(),
          AppPlainTextField(
            labelText: 'Card Value  (\$ USD)',
            hintText: 'Enter Card Value',
            borderRadius: 10,
            controller: prov.cryptoValueCtl,
            keyboardType: TextInputType.numberWithOptions(),
            onChanged: (val) {
              setState(() {});
            },
          ),
          SizedBox(height: 24),
          Builder(builder: (context) {
            CryptoActionType? actionType = prov.selectedCryptoActionType;
            String? rate = actionType == CryptoActionType.buy
                ? prov.crypto?.buyRate
                : prov.crypto?.sellRate;

            final value = prov.crypto != null
                ? int.parse("${rate?.replaceAll(".00", "")}") *
                    int.parse(prov.cryptoValueCtl.text.isEmpty
                        ? "0"
                        : prov.cryptoValueCtl.text)
                : 0;

            return RateDisplay(
                rate: int.parse(rate ?? "0").asCurrency(symbol: "\$"),
                totalValue: "${value.asCurrency(symbol: "")} USD");
          }),
          SizedBox(height: 16),
          DisclaimerText(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
