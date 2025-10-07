import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/modules/dashboard/components/disclaimer_text.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/content/country_selector.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/content/gift_card_action.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/content/gift_card_selector.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/content/range_picker.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/content/receipt_cagegory_selector.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/rate_display.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/extensions/amount_formatter.dart';

class GiftcardContent extends ConsumerStatefulWidget {
  const GiftcardContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GiftcardContent();
}

class _GiftcardContent extends ConsumerState<GiftcardContent> {
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
          GiftCardSelector(),
          CountrySelector(),
          RangePicker(),
          ReceiptCategorySelector(),
          GiftCardAction(),
          AppPlainTextField(
            labelText: currency == null
                ? 'Card Value'
                : 'Card Value  (${currency.symbol} ${currency.code})',
            hintText: 'Enter Card Value',
            borderRadius: 10,
            controller: prov.giftCardValueCtl,
            keyboardType: TextInputType.numberWithOptions(),
            onChanged: (val) {
              setState(() {});
            },
          ),
          SizedBox(height: 24),
          Builder(builder: (context) {
            final value = prov.selectedReceiptCategory != null
                ? int.parse(
                        "${prov.selectedReceiptCategory?.amount?.replaceAll(".00", "")}") *
                    int.parse(prov.giftCardValueCtl.text.isEmpty
                        ? "0"
                        : prov.giftCardValueCtl.text)
                : 0;
            final code = prov.selectedCountry?.currency != null
                ? prov.selectedCountry?.currency?.code
                : "";
            return RateDisplay(
                rate: "${prov.selectedReceiptCategory?.amount ?? 0}",
                totalValue:
                    "${value.asCurrency(symbol: prov.selectedCountry?.currency?.symbol ?? "\$")} $code");
          }),
          SizedBox(height: 16),
          DisclaimerText(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
