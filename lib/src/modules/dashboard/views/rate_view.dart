import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/modules/dashboard/components/crypto/crypto_content.dart';
import 'package:pgoldapp/src/modules/dashboard/components/gift_card/giftcard_content.dart';
import 'package:pgoldapp/src/modules/dashboard/components/pgold_tab_toggle.dart';
import 'package:pgoldapp/src/providers/rate_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_scaffold.dart';
import 'package:pgoldapp/src/reusables/components/main_app_bar.dart';

class RateView extends ConsumerStatefulWidget {
  static const routeName = "/RateView";

  const RateView({super.key});

  @override
  ConsumerState<RateView> createState() => _RateViewState();
}

class _RateViewState extends ConsumerState<RateView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    Future.microtask(() async {
      initData();
    });
    super.initState();
  }

  Future<void> initData() async {
    await ref.read(pGoldRateProvider).getGiftCardRates();
    await ref.read(pGoldRateProvider).getCryptoRates();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainAppBar(
        height: 70,
        title: "Rates",
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await initData();
        },
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  PgoldTabToggle(
                    text: 'Giftcard',
                    iconPath: AssetConfig.giftCard,
                    isSelected: _selectedIndex == 0,
                    onTap: () => setState(() => _selectedIndex = 0),
                  ),
                  const SizedBox(width: 8),
                  PgoldTabToggle(
                    text: 'Crypto',
                    iconPath: AssetConfig.bitcoin,
                    isSelected: _selectedIndex == 1,
                    onTap: () => setState(() => _selectedIndex = 1),
                  ),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: const [
                  GiftcardContent(),
                  CryptoContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
