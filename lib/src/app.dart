import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/route_config.dart';
import 'package:pgoldapp/src/config/theme_config.dart';
import 'package:pgoldapp/src/modules/onboarding/views/splash_screen.dart';
import 'package:pgoldapp/src/providers/theme_provider.dart';
import 'package:pgoldapp/src/reusables/utils/ref_holder.dart';
import 'package:pgoldapp/src/reusables/utils/view_utils.dart';

class PGoldApp extends ConsumerWidget {
  const PGoldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final navigatorKey = ref.watch(navigatorKeyProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: themeMode,
      navigatorKey: navigatorKey,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      onGenerateRoute: RouteConfig.generateRoute,
      initialRoute: SplashScreen.routeName,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        ViewUtils.watch(context);

        Widget wrapped = child ?? const SizedBox.shrink();
        wrapped = BotToastInit()(context, wrapped);
        RefHolder.init(ref);

        return wrapped;
      },
    );
  }
}
