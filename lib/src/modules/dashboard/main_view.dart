import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/modules/dashboard/components/app_navbar_container.dart';
import 'package:pgoldapp/src/modules/dashboard/views/home_view.dart';
import 'package:pgoldapp/src/modules/dashboard/views/rate_view.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';

class MainView extends ConsumerStatefulWidget {
  final int selectedIndex;
  static const routeName = "/MainScreen";

  const MainView({super.key, required this.selectedIndex});

  @override
  ConsumerState<MainView> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return AppNavBarContainer(
      initialIndex: selectedIndex,
      onIndexChanged: (index) {
        setState(() => selectedIndex = index);
        debugPrint("Active Index: $index");
      },
      pages: [
        HomeView(),
        Center(child: Text("History")),
        Center(child: Text("Cards")),
        RateView(),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile"),
            Text(
                "Email Verified: ${ref.watch(pGoldAuthProvider).currentUser?.emailVerifiedAt != null}"),
            Text("Email: ${ref.watch(pGoldAuthProvider).currentUser?.email}"),
            OutlinedButton(
                onPressed: () {
                  ref.read(pGoldAuthProvider).logout();
                },
                child: Text("Logout"))
          ],
        )),
      ],
      items: [
        AppNavItem(iconPath: AssetConfig.home3, label: "Home"),
        AppNavItem(iconPath: AssetConfig.bars, label: "History"),
        AppNavItem(iconPath: AssetConfig.cardPos, label: "Cards"),
        AppNavItem(iconPath: AssetConfig.calculator2, label: "Rates"),
        AppNavItem(iconPath: AssetConfig.userCircle, label: "Profile"),
      ],
    );
  }
}
