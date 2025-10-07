import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/app_tile.dart';
import 'package:pgoldapp/src/reusables/components/bottom_sheet.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/components/scaffold_header.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';
import 'package:pgoldapp/src/reusables/utils/validator_mixin.dart';

class Country {
  final String country;
  final String flag;
  final String code;

  Country({required this.country, required this.flag, required this.code});
}

final countryCodeProvider = StateProvider<Country?>((ref) =>
    Country(country: "Nigeria", flag: AssetConfig.globe, code: "+234"));

final _countries = [
  Country(country: "Nigeria", flag: AssetConfig.globe, code: "+234"),
  Country(country: "Ghana", flag: AssetConfig.globe, code: "+233"),
  Country(country: "Kenya", flag: AssetConfig.globe, code: "+254"),
  Country(country: "South Africa", flag: AssetConfig.globe, code: "+27"),
  Country(country: "United Kingdom", flag: AssetConfig.globe, code: "+44"),
];

class PersonalDataView extends ConsumerStatefulWidget {
  static const routeName = "/PersonalDataView";

  const PersonalDataView({super.key});

  @override
  ConsumerState<PersonalDataView> createState() => _PersonalDataView();
}

class _PersonalDataView extends ConsumerState<PersonalDataView>
    with ValidatorMixin {
  @override
  Widget build(BuildContext context) {
    final country = ref.watch(countryCodeProvider);

    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScaffoldHeader(
            title: "Create account",
            subtitle: "Create your PGOLD account to get started in minutes!",
            paddingTop: 24,
            paddingBottom: 16,
          ),
          const SizedBox(height: 10),
          AppPlainTextField(
            labelText: "Full Name",
            hintText: "Enter Full Name",
            leadingIcon: AppImageViewer(AssetConfig.userIcon),
            controller: ref.read(pGoldAuthProvider).fullName,
            keyboardType: TextInputType.name,
          ),
          AppPlainTextField(
            labelText: "Phone Number",
            hintText: "Enter Phone Number",
            leadingIcon: GestureDetector(
              onTap: () async {
                await BottomSheetUtil.showCustomSheet(
                  context,
                  title: "Select Country",
                  subtitle: "Choose your country code",
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: _countries
                          .map(
                            (c) => AppTile(
                              title: c.country,
                              trailing: Text(c.code),
                              leadingIcon: AppImageViewer(
                                c.flag,
                                height: 28,
                                width: 28,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                ref.read(countryCodeProvider.notifier).state =
                                    c;
                                Navigator.pop(context);
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppImageViewer(
                      country?.flag ?? AssetConfig.globe,
                      height: 22,
                      width: 22,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      country?.code ?? "+000",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorConfig.textDark,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          AppPlainTextField(
            onTap: () async {
              await BottomSheetUtil.showCustomSheet(
                context,
                title: "Choose an option",
                subtitle: "Choose one option to proceed to the next step.",
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      ...[
                        "Referral",
                        "Social Media",
                        "Website",
                        "Ad",
                        "Instagram",
                        "Newspaper",
                        "Billboard",
                      ].map(
                        (item) => AppTile(
                          title: item,
                          onTap: () {
                            showText(item);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
            labelText: "How did you hear about us (Optional)",
            hintText: "How did you hear about us",
            readOnly: true,
            leadingIcon: AppImageViewer(
              AssetConfig.globe,
              height: 24,
              width: 24,
              color: ColorConfig.textGrey,
              fit: BoxFit.scaleDown,
            ),
          ),
          AppPlainTextField(
            labelText: "Password",
            hintText: "Type Password",
            secure: true,
            leadingIcon: AppImageViewer(AssetConfig.component4),
            controller: ref.read(pGoldAuthProvider).passwordController,
            keyboardType: TextInputType.visiblePassword,
          ),
          AppPlainTextField(
            labelText: "Confirm Password",
            hintText: "Re-Type Password",
            secure: true,
            leadingIcon: AppImageViewer(AssetConfig.component4),
            keyboardType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
