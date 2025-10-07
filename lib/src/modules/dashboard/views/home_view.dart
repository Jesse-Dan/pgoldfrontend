import 'package:flutter/material.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/ads.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/header.dart';
import 'package:pgoldapp/src/modules/dashboard/views/components/quick_actions.dart';
import 'package:pgoldapp/src/reusables/components/app_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              QuickActions(),
              Ads(),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
