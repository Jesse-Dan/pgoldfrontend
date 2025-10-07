import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';

import '../../config/color_config.dart';

class AppDropdownField<T> extends ConsumerStatefulWidget {
  const AppDropdownField({
    super.key,
    this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.labelText,
    this.leadingIcon,
    this.validator,
    this.borderRadius = 50.0,
  });

  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? hintText;
  final String? labelText;
  final Widget? leadingIcon;
  final String? Function(T?)? validator;
  final double borderRadius;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppDropdownFieldState<T>();
  }
}

class _AppDropdownFieldState<T> extends ConsumerState<AppDropdownField<T>> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        _isFocused ? ColorConfig.primaryBlueLight : Colors.transparent;
    final Color fillColor = ColorConfig.surfaceWhite;
    final BorderRadius customBorderRadius =
        BorderRadius.circular(widget.borderRadius);

    const BorderSide defaultBorderSide =
        BorderSide(color: Colors.transparent, width: 0.0);
    final BorderSide focusedBorderSide =
        BorderSide(color: borderColor, width: 2.0);
    final BorderSide enabledBorderSide =
        BorderSide(color: borderColor, width: 1.0);
    const BorderSide errorBorderSide =
        BorderSide(color: Colors.red, width: 1.5);
    const BorderSide focusedErrorBorderSide =
        BorderSide(color: Colors.red, width: 2.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12.8,
                color: ColorConfig.textDark,
              ),
            ),
          ),
        DropdownButtonFormField<T>(
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          validator: widget.validator,
          focusNode: _focusNode,
          style: const TextStyle(color: ColorConfig.textDark, fontSize: 12),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: ColorConfig.textGrey,
          ),
          dropdownColor: ColorConfig.surfaceWhite,
          decoration: InputDecoration(
            prefixIcon: widget.leadingIcon.runtimeType == IconData
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: (widget.leadingIcon as AppImageViewer).copyWith(
                      height: 24,
                      width: 24,
                      color: _isFocused
                          ? ColorConfig.primaryBlueLight
                          : ColorConfig.textGrey,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                : widget.leadingIcon != null && widget.leadingIcon is IconData
                    ? Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                        child: Icon(
                          widget.leadingIcon as IconData,
                          color: _isFocused
                              ? ColorConfig.primaryBlueLight
                              : ColorConfig.textGrey,
                        ),
                      )
                    : widget.leadingIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.8,
              color: ColorConfig.textGrey.withOpacity(.5),
            ),
            filled: true,
            fillColor: fillColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: customBorderRadius,
              borderSide: defaultBorderSide,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: customBorderRadius,
              borderSide: focusedBorderSide,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: customBorderRadius,
              borderSide: enabledBorderSide,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: customBorderRadius,
              borderSide: errorBorderSide,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: customBorderRadius,
              borderSide: focusedErrorBorderSide,
            ),
          ),
        ),
      ],
    );
  }
}
