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

class CryptoAction extends ConsumerStatefulWidget {
  const CryptoAction({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CryptoAction();
  }
}

class _CryptoAction extends ConsumerState<CryptoAction> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Crypto Action',
      hintText: 'Select Crypto Action',
      borderRadius: 10,
      readOnly: true,
      leadingIcon: Visibility(
        visible: ref.watch(pGoldRateProvider).selectedCryptoActionType != null,
        child: CircleAvatar(
            backgroundColor: ColorConfig.actionCrypto,
            child: AppImageViewer(AssetConfig.database)),
      ),
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).selectedCryptoActionType != null
              ? "${ref.watch(pGoldRateProvider).selectedCryptoActionType?.title}"
                  .toUpperCase()
              : ""),
      onTap: () async {
        if (ref.watch(pGoldRateProvider).giftCardRate == null) {
          showText("Hey Chief. You need to select Crypto First");
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
                        CryptoActionType.values.toList().length, (i) {
              final CryptoActionType action =
                  CryptoActionType.values.toList()[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).selectedCryptoActionType =
                        action;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    CircleAvatar(
                        backgroundColor: ColorConfig.actionCrypto,
                        child: AppImageViewer(AssetConfig.database)),
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
