import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/color_config.dart';

class DisclaimerText extends StatelessWidget {
  const DisclaimerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.info_outline, color: ColorConfig.textGrey, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'This is an estimated rate. Actual rate may differ.',
            style: TextStyle(color: ColorConfig.textGrey, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
