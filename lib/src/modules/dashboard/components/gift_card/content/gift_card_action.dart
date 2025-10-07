import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';

class GiftCardAction extends ConsumerStatefulWidget {
  const GiftCardAction({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GiftCardAction();
  }
}

class _GiftCardAction extends ConsumerState<GiftCardAction> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Giftcard Action',
      hintText: 'Select Giftcard Action',
      borderRadius: 10,
      readOnly: true,
      leadingIcon: Visibility(
        visible: ref.watch(pGoldRateProvider).selectedCardAction != null,
        child: CircleAvatar(
            backgroundColor: ColorConfig.actionGiftcards,
            child: AppImageViewer(AssetConfig.giftCard)),
      ),
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedCardAction != null
              ? "${ref.watch(pGoldRateProvider).selectedCardAction?.title}"
                  .toUpperCase()
              : ""),
      onTap: () async {

         if (ref.watch(pGoldRateProvider).giftCardRate == null) {
          showText("You have to select a Gift Card, Country, Range and Receipt Category");
          return;
        }
        await BottomSheetUtil.showCustomSheet(
          context,
          searchable: true,
          title: "Select your most preferred action",
          subtitle: "Choose your most preferred action",
          backgroundColor: ColorConfig.backgroundLightGrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 24),
            child: SingleChildScrollView(
                child: ContainedList(
                    children: List.generate(
                        GiftCardActionType.values.toList().length, (i) {
              final GiftCardActionType action =
                  GiftCardActionType.values.toList()[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedCardAction = action;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    CircleAvatar(
                        backgroundColor: ColorConfig.actionGiftcards,
                        child: AppImageViewer(AssetConfig.giftCard)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          action.title,
                          style: context.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          action.subtitle,
                          style: context.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConfig.textGrey),
                        )
                      ],
                    ),
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
