import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/config/constants.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/contained_list.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/models/crypto_rate.dart';

class CryptoSelector extends ConsumerStatefulWidget {
  const CryptoSelector({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CryptoSelector();
}

class _CryptoSelector extends ConsumerState<CryptoSelector> {
  @override
  Widget build(BuildContext context) {
    return AppPlainTextField(
      labelText: 'Crypto',
      hintText: 'Select Crypto',
      borderRadius: 10,
      readOnly: true,
      controller: TextEditingController(
          text: ref.watch(pGoldRateProvider).crypto?.name),
      leadingIcon: Visibility(
        visible: ref.watch(pGoldRateProvider).crypto != null,
        child: AppImageViewer(
          ref.watch(pGoldRateProvider).crypto?.icon ??
              Constants.DEF_PROFILE_PIC,
          height: 40,
          width: 40,
        ),
      ),
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
                        (ref.watch(pGoldRateProvider).cryptoRate?.data ?? [])
                            .length, (i) {
              final Crypto crypto =
                  (ref.watch(pGoldRateProvider).cryptoRate?.data ?? [])[i];

              return GestureDetector(
                onTap: () {
                  setState(() {
                    ref.read(pGoldRateProvider).crypto = crypto;
                  });
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                  child: Row(children: [
                    AppImageViewer(
                      "${crypto.icon}",
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 8),
                    Text(
                        "${(ref.watch(pGoldRateProvider).cryptoRate?.data ?? [])[i].name}")
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
