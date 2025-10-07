import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/modules/dashboard/main_view.dart';
import 'package:pgoldapp/src/modules/dashboard/views/rate_view.dart';
import 'package:pgoldapp/src/modules/registration/registration_base.dart';
import 'package:pgoldapp/src/modules/registration/views/personal_data_view.dart';
import 'package:pgoldapp/src/modules/verify_email/verify_email_base.dart';
import 'package:pgoldapp/src/reusables/extensions/route_arguments.dart';

import '../modules/login/login_view.dart';
import '../modules/onboarding/views/onboarding_screen.dart';
import '../modules/onboarding/views/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return navigatorKey;
});

class RouteConfig {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case OnboardingScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
          settings: settings,
        );

      case LoginView.routeName:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
          settings: settings,
        );

      case PersonalDataView.routeName:
        return MaterialPageRoute(
          builder: (_) => PersonalDataView(),
          settings: settings,
        );

      case RegistrationBase.routeName:
        return MaterialPageRoute(
          builder: (_) => RegistrationBase(),
          settings: settings,
        );

      case VerifyEmailBase.routeName:
        return MaterialPageRoute(
          builder: (context) => VerifyEmailBase(
            email: settings.arguments.getArgument<String>("email") ??
                "test@gmail.",
          ),
          settings: settings,
        );

      case MainView.routeName:
        return MaterialPageRoute(
          builder: (context) => MainView(
            selectedIndex:
                settings.arguments.getArgument<int>("selectedIndex") ?? 0,
          ),
          settings: settings,
        );

      case RateView.routeName:
        return MaterialPageRoute(
          builder: (context) => RateView(),
          settings: settings,
        );

      default:
        return _errorRoute(settings, 'Route not found: ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings, String message) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}
