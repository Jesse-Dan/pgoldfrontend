import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/color_config.dart';

class AppSearchField extends ConsumerStatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hintText = 'Search...',
    this.onChanged,
    this.onSubmitted,
    this.borderRadius = 50.0,
  });

  final TextEditingController? controller;
  final String hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final double borderRadius;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppSearchFieldState();
  }
}

class _AppSearchFieldState extends ConsumerState<AppSearchField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _internalController;

  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

    _internalController = widget.controller ?? TextEditingController();
    _internalController.addListener(_onTextChange);

    _hasText = _internalController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _internalController.removeListener(_onTextChange);
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChange() {
    final newHasText = _internalController.text.isNotEmpty;
    if (_hasText != newHasText) {
      setState(() {
        _hasText = newHasText;
      });
    }
    // Pass change notification up to the parent
    widget.onChanged?.call(_internalController.text);
  }

  void _clearText() {
    _internalController.clear();
    widget.onChanged?.call('');
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = _isFocused
        ? ColorConfig.primaryBlueLight.withOpacity(.4)
        : ColorConfig.textWhite;
    final Color fillColor = Color(0xFFFAFBFD);
    final BorderRadius customBorderRadius =
        BorderRadius.circular(widget.borderRadius);

    return TextFormField(
      controller: _internalController,
      focusNode: _focusNode,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: widget.onSubmitted,
      onChanged: widget.onChanged,
      style: const TextStyle(color: ColorConfig.textDark),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Icon(
            Icons.search,
            color:
                _isFocused ? ColorConfig.primaryBlueDark : ColorConfig.textDark,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: _hasText
            ? IconButton(
                icon: const Icon(Icons.close, color: ColorConfig.textGrey),
                onPressed: _clearText,
              )
            : null,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: ColorConfig.textGrey),
        filled: true,
        fillColor: fillColor,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: BorderSide(
            color: borderColor,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: customBorderRadius,
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
