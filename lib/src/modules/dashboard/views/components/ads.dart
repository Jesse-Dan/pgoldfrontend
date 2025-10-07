// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class Ads extends StatelessWidget {
  const Ads({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135.05435180664062,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(2, (i) {
                return Container(
                  margin:
                      EdgeInsets.only(left: 12, right: i == (2 - 1) ? 12 : 0),
                  height: 135.05435180664062,
                  width: 350,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          ColorConfig.primaryBlueLight,
                          ColorConfig.primaryBlueLight.withOpacity(0.7),
                          ColorConfig.primaryBlueLight.withOpacity(0.3),
                          ColorConfig.primaryBlueLight.withOpacity(0.1),
                        ],
                        stops: [0.0, 0.4, 0.7, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                        child: SizedBox(
                          width: 140,
                          child: Column(
                            children: [
                              Text(
                                "Earn cash rewards every time you  refer a friend",
                                style: context.textTheme.labelLarge?.copyWith(
                                  color: ColorConfig.textWhite,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "Refer a friend",
                                    style:
                                        context.textTheme.labelSmall?.copyWith(
                                      color: ColorConfig.textWhite,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: ColorConfig.textWhite,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: AppImageViewer(
                          AssetConfig.earn_cash_image,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          )),
    );
  }
}
