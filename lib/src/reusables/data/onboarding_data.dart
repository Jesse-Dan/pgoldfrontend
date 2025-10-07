import 'package:pgoldapp/src/config/asset_config.dart';

import '../models/onbording_slide.dart';

class OnboardingData {
  static List<OnboardingSlide> slides = [
    OnboardingSlide(
      illustration: AssetConfig.ob_1,
      title: 'Purchase and Trade Giftcards Effortlessly',
      description:
          'Access the best deals on top-brand giftcards. Buy, Sell, or redeem instantly—no hassles, just value.',
    ),
    OnboardingSlide(
      illustration: AssetConfig.ob_2,
      title: 'Secure Payments with  Virtual Dollar Cards',
      description:
          'Create and manage virtual cards for safe and flexible online transastions. Control your spendings with just few taps.',
    ),
  ];
}
