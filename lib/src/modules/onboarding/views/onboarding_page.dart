import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

import '../../../config/color_config.dart';

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({
    super.key,
    required this.illustrationString,
    required this.title,
    required this.description,
    required this.currentPageIndex,
    required this.totalPages,
    required this.onNextPressed,
    required this.onSkipPressed,
  });

  final String illustrationString;
  final String title;
  final String description;
  final int currentPageIndex;
  final int totalPages;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: ColorConfig.textWhite,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 4),
              child: Align(
                alignment: Alignment.topRight,
                child: OutlinedButton(
                  onPressed: onSkipPressed,
                  child: const Text(
                    'Skip',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: AppImageViewer(
                illustrationString,
                width: double.infinity,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: context.textTheme.displayMedium!.copyWith(
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                    color: ColorConfig.textDark,
                    height: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: context.textTheme.labelSmall!.copyWith(
                  fontSize: 16,
                  color: ColorConfig.textGrey,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            // _buildPagination(currentPageIndex, totalPages),
          ],
        ),
      ),
    );
  }
}
