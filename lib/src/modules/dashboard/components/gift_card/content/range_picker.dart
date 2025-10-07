import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/models/gift_card_rate.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';

class RangePicker extends ConsumerStatefulWidget {
  const RangePicker({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RangePicker();
  }
}

class _RangePicker extends ConsumerState<RangePicker> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Card Range',
      readOnly: true,
      hintText: 'Select Card Range',
      borderRadius: 10,
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedRange != null
              ? "${ref.watch(pGoldRateProvider).selectedCountry?.currency?.symbol} ${ref.watch(pGoldRateProvider).selectedRange?.min} -  ${ref.watch(pGoldRateProvider).selectedCountry?.currency?.symbol} ${ref.watch(pGoldRateProvider).selectedRange?.max}"
              : ""),
      onTap: () async {
        if (ref.watch(pGoldRateProvider).giftCardRate == null) {
          showText("You have to select a Gift Card and Country");
          return;
        }
        await BottomSheetUtil.showCustomSheet(
          context,
          searchable: true,
          title: "Choose an option",
          subtitle: "Choose one option to proceed to the next step.",
          backgroundColor: ColorConfig.backgroundLightGrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: SingleChildScrollView(
                child: ContainedList(
                    children: List.generate(
                        (ref.watch(pGoldRateProvider).selectedCountry?.ranges ??
                                [])
                            .length, (i) {
              final Range range =
                  (ref.watch(pGoldRateProvider).selectedCountry?.ranges ??
                      [])[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedRange = range;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    Text(
                        "${ref.watch(pGoldRateProvider).selectedCountry?.currency?.symbol} ${range.min} - ${ref.watch(pGoldRateProvider).selectedCountry?.currency?.symbol} ${range.max}")
                  ]),
                ),
              );
            }))),
          ),
        );
      },
    );
  }
}
