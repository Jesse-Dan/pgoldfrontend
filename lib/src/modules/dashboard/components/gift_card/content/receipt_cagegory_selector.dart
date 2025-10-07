import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/models/gift_card_rate.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';

class ReceiptCategorySelector extends ConsumerStatefulWidget {
  const ReceiptCategorySelector({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ReceiptCagegorySelector();
  }
}

class _ReceiptCagegorySelector extends ConsumerState<ReceiptCategorySelector> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Receipt Category',
      hintText: 'Select Receipt Category',
      readOnly: true,
      borderRadius: 10,
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedReceiptCategory != null
              ? "${ref.watch(pGoldRateProvider).selectedReceiptCategory?.title}"
              : ""),
      onTap: () async {
        if (ref.watch(pGoldRateProvider).giftCardRate == null) {
          showText("You have to select a Gift Card, Country and Range");
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
                        (ref
                                    .watch(pGoldRateProvider)
                                    .selectedRange
                                    ?.receiptCategories ??
                                [])
                            .length, (i) {
              final ReceiptCategory category = (ref
                      .watch(pGoldRateProvider)
                      .selectedRange
                      ?.receiptCategories ??
                  [])[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedReceiptCategory =
                        category;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [Text("${category.title}")]),
                ),
              );
            }))),
          ),
        );
      },
    );
  }
}
