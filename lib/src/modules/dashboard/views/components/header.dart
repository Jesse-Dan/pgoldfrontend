// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/action_bottons.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/balance_and_currency.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class Header extends ConsumerWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Stack(
          children: [
            // BG
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  colors: [
                    ColorConfig.primaryBlueDark,
                    ColorConfig.primaryBlueLight,
                  ],
                ),
              ),
              child: AppImageViewer(
                AssetConfig.pgoldPatterns,
                fit: BoxFit.fill,
                resizeMode: ImageResizeMode.cover,
              ),
            ),
            // items
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppImageViewer(
                              "https://img.freepik.com/free-photo/young-african-american-man-wearing-white-shirt_273609-21699.jpg",
                              height: 42,
                              width: 42,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello ${ref.watch(pGoldAuthProvider).currentUser?.name.split(" ").first ?? "User"} 👋",
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                          color: ColorConfig.textWhite,
                                          fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  "Top of the morning to you",
                                  style: context.textTheme.labelSmall
                                      ?.copyWith(color: ColorConfig.textWhite),
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                            children: List.generate(
                                HeaderActionModel.items.length,
                                (i) => HeaderAction(
                                      model: HeaderActionModel.items[i],
                                    )))
                      ],
                    ),
                  ),
                  BalanceAndCurrency(),
                  ActionBottons()
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class HeaderActionModel {
  final bool showBadge;
  final String imagePath;

  HeaderActionModel({required this.showBadge, required this.imagePath});

  static List<HeaderActionModel> items = [
    HeaderActionModel(showBadge: true, imagePath: AssetConfig.vector),
    HeaderActionModel(showBadge: false, imagePath: AssetConfig.bell),
  ];
}

class HeaderAction extends StatelessWidget {
  final HeaderActionModel model;

  const HeaderAction({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: ColorConfig.textWhite),
          color: ColorConfig.primaryBlueLight.withOpacity(.3),
          shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Badge(
          isLabelVisible: model.showBadge,
          child: AppImageViewer(
            model.imagePath,
            color: ColorConfig.surfaceWhite,
          )),
    );
  }
}
