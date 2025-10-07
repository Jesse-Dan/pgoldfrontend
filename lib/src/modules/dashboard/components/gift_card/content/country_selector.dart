import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/config/constants.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/models/gift_card_rate.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';

class CountrySelector extends ConsumerStatefulWidget {
  const CountrySelector({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CountrySelector();
  }
}

class _CountrySelector extends ConsumerState<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Country',
      hintText: 'Select Giftcard Country',
      borderRadius: 10,
      readOnly: true,
      leadingIcon: Visibility(
        visible: ref.watch(pGoldRateProvider).selectedCountry != null,
        child: AppImageViewer(
          ref.watch(pGoldRateProvider).selectedCountry?.image ??
              Constants.DEF_PROFILE_PIC,
          height: 20,
          width: 40,
        ),
      ),
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedCountry != null
              ? ref.watch(pGoldRateProvider).selectedCountry?.name
              : ""),
      onTap: () async {
        if (ref.watch(pGoldRateProvider).giftCardRate == null) {
          showText("You have to select a Gift Card!");
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
                                    .selectedGiftCard
                                    ?.countries ??
                                [])
                            .length, (i) {
              final Country giftcard =
                  (ref.watch(pGoldRateProvider).selectedGiftCard?.countries ??
                      [])[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedCountry = giftcard;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    AppImageViewer(
                      "${(ref.watch(pGoldRateProvider).selectedGiftCard?.countries ?? [])[i].image}",
                      height: 24.024600982666016,
                      width: 32.54336166381836,
                    ),
                    const SizedBox(width: 8),
                    Text(
                        "${(ref.watch(pGoldRateProvider).selectedGiftCard?.countries ?? [])[i].name}")
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
