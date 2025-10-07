import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';

class RateDisplay extends ConsumerStatefulWidget {
  final String rate;
  final String totalValue;

  const RateDisplay({super.key, required this.rate, required this.totalValue});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RateDisplay();
}

class _RateDisplay extends ConsumerState<RateDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.6376495361328,
      decoration: BoxDecoration(
          color: ColorConfig.surfaceWhite,
          border: Border.all(color: ColorConfig.backgroundLightGrey),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Rate',
                    style:
                        TextStyle(color: ColorConfig.textGrey, fontSize: 16)),
                Text(widget.rate,
                    style: const TextStyle(
                        color: ColorConfig.textGrey, fontSize: 16)),
              ],
            ),
          ),
          const Divider(
              color: ColorConfig.backgroundLightGrey,
              height: 20), // Subtle separator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Value',
                    style:
                        TextStyle(color: ColorConfig.textGrey, fontSize: 16)),
                Text(widget.totalValue,
                    style: const TextStyle(
                        color: ColorConfig.textGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
