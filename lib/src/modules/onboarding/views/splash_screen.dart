import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';

class SplashScreen extends ConsumerWidget {
  static const String routeName = "/SplashScreen";
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();

      ref.read(pGoldAuthProvider).decideInitialRoute(ref);
    });

    return Scaffold(
      backgroundColor: ColorConfig.primaryBlueLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [AppImageViewer(AssetConfig.launchIcon)],
        ),
      ),
    );
  }
}
