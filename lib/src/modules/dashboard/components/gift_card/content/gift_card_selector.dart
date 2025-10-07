import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/models/gift_card_rate.dart';

class GiftCardSelector extends ConsumerStatefulWidget {
  const GiftCardSelector({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GiftCardSelector();
}

class _GiftCardSelector extends ConsumerState<GiftCardSelector> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Giftcard',
      hintText: 'Select Giftcard',
      borderRadius: 10,
      readOnly: true,
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedGiftCard?.title),
      onTap: () async {
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
                                    .giftCardRate
                                    ?.allGiftcards ??
                                [])
                            .length, (i) {
              final Giftcard giftcard =
                  (ref.watch(pGoldRateProvider).giftCardRate?.allGiftcards ??
                      [])[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedGiftCard = giftcard;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    AppImageViewer(
                      "${(ref.watch(pGoldRateProvider).giftCardRate?.allGiftcards ?? [])[i].brandLogo?.replaceAll("giftcards//", "giftcards/")}",
                      height: 24.024600982666016,
                      width: 32.54336166381836,
                    ),
                    const SizedBox(width: 8),
                    Text(
                        "${(ref.watch(pGoldRateProvider).giftCardRate?.allGiftcards ?? [])[i].title}")
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
