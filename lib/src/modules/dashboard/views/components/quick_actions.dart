import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

class QuickActionItem {
  final String title;
  final String imagePath;
  final Color color;

  QuickActionItem({
    required this.title,
    required this.imagePath,
    required this.color,
  });
}

class QuickActions extends StatelessWidget {
  QuickActions({
    super.key,
  });

  final List<QuickActionItem> quickActionItems = [
    QuickActionItem(
      title: 'Crypto',
      imagePath: AssetConfig.database,
      color: ColorConfig.actionCrypto,
    ),
    QuickActionItem(
      title: 'Giftcards',
      imagePath: AssetConfig.giftCard,
      color: ColorConfig.actionGiftcards,
    ),
    QuickActionItem(
      title: 'Top Up',
      imagePath: AssetConfig.plus,
      color: ColorConfig.actionTopUp,
    ),
    QuickActionItem(
      title: 'Cable TV',
      imagePath: AssetConfig.tv,
      color: ColorConfig.actionCableTV,
    ),
    QuickActionItem(
      title: 'Electricity',
      imagePath: AssetConfig.lightbulb,
      color: ColorConfig.actionElectricity,
    ),
    QuickActionItem(
      title: 'Betting',
      imagePath: AssetConfig.dribbble,
      color: ColorConfig.actionBetting,
    ),
    QuickActionItem(
      title: 'Flight',
      imagePath: AssetConfig.planeUp,
      color: ColorConfig.actionFlight,
    ),
    QuickActionItem(
      title: 'User Rank',
      imagePath: AssetConfig.star,
      color: ColorConfig.actionUserRank,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.26, bottom: 10.26, left: 9.12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quick Action",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.78,
                  color: ColorConfig.textDark,
                ),
              ),
              TextButton.icon(
                iconAlignment: IconAlignment.end,
                label: Text("More"),
                onPressed: () {},
                icon: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4.56,
              mainAxisSpacing: 4.56,
              childAspectRatio: 1.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: quickActionItems.length,
            itemBuilder: (_, i) {
              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 52.989768981933594,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: quickActionItems[i].color,
                      ),
                      alignment: Alignment.center,
                      child: AppImageViewer(
                        quickActionItems[i].imagePath,
                        height: 24,
                        width: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    SizedBox(height: 4.56),
                    Text(
                      quickActionItems[i].title,
                      style: context.textTheme.labelMedium?.copyWith(
                          color: ColorConfig.textDark,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
