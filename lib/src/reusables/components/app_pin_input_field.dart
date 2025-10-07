import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../config/color_config.dart';

class AppPinInputField extends ConsumerStatefulWidget {
  const AppPinInputField({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.validator,
    this.controller,
  });

  final int length;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppPinInputFieldState();
  }
}

class _AppPinInputFieldState extends ConsumerState<AppPinInputField> {
  final double fieldSize = 50;
  final double borderRadius = 50.0;
  final double borderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: fieldSize,
      height: fieldSize,
      textStyle: const TextStyle(
        fontSize: 20,
        color: ColorConfig.textDark,
        fontWeight: FontWeight.w900,
      ),
      decoration: BoxDecoration(
        color: ColorConfig.backgroundLightGrey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: ColorConfig.textGrey.withOpacity(0.3),
          width: borderWidth,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: ColorConfig.primaryBlueLight,
        width: 2.0,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: ColorConfig.primaryBlueLight,
        width: borderWidth,
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: Colors.red,
        width: borderWidth,
      ),
    );

    return Pinput(
      autofocus: true,
      length: widget.length,
      controller: widget.controller,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      validator: widget.validator,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      obscureText: true,
      animationCurve: Curves.easeIn,
      hapticFeedbackType: HapticFeedbackType.vibrate,
    );
  }
}
