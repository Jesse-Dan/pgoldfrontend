import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/modules/login/login_view.dart';
import 'package:pgoldapp/src/reusables/data/onboarding_data.dart';

import 'onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  static const routeName = "/OnboardingScreen";
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() {
    // Changed return type to ConsumerState<OnboardingScreen>
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPageIndex < OnboardingData.slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _onSkipPressed() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    Navigator.of(context).pushNamed(LoginView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = OnboardingData.slides.length;
    final isLastPage = _currentPageIndex == totalPages - 1;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final slide = OnboardingData.slides[index];
                return OnboardingPage(
                  illustrationString: slide.illustration,
                  title: slide.title,
                  description: slide.description,
                  currentPageIndex: _currentPageIndex,
                  totalPages: totalPages,
                  onNextPressed: () {},
                  onSkipPressed: _onSkipPressed,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    child: Text(
                      isLastPage ? 'Get Started' : 'Next',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
