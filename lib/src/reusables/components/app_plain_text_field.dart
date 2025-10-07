import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';

class AppPlainTextField extends ConsumerStatefulWidget {
  const AppPlainTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.leadingIcon,
    this.secure = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.borderRadius = 50.0,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final dynamic leadingIcon; // Can be IconData, AppImageViewer, or Widget
  final bool secure;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double borderRadius;
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AppPlainTextFieldState();
  }
}

class _AppPlainTextFieldState extends ConsumerState<AppPlainTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  late bool _isContentObscured;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _isContentObscured = widget.secure;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  void _toggleObscure() {
    setState(() {
      _isContentObscured = !_isContentObscured;
    });
  }

  Widget? _buildPrefixIcon() {
    final icon = widget.leadingIcon;
    if (icon == null) return null;

    // Case 1: IconData
    if (icon is IconData) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: Icon(
          icon,
          color:
              _isFocused ? ColorConfig.primaryBlueLight : ColorConfig.textGrey,
        ),
      );
    }

    // Case 2: AppImageViewer
    if (icon is AppImageViewer) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: icon.copyWith(
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
          color:
              _isFocused ? ColorConfig.primaryBlueLight : ColorConfig.textGrey,
        ),
      );
    }

    // Case 3: Any other Widget
    if (icon is Widget) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: icon,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor =
        _isFocused ? ColorConfig.primaryBlueLight : Colors.transparent;

    final BorderRadius customBorderRadius =
        BorderRadius.circular(widget.borderRadius);

    final Color fillColor = ColorConfig.surfaceWhite;

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
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: _isContentObscured,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          style: const TextStyle(color: ColorConfig.textDark, fontSize: 12.5),
          decoration: InputDecoration(
            prefixIcon: _buildPrefixIcon(),
            prefixIconConstraints: widget.leadingIcon != null
                ? const BoxConstraints(minWidth: 0, minHeight: 0)
                : null,
            suffixIcon: widget.secure
                ? IconButton(
                    icon: Icon(
                      _isContentObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: ColorConfig.textGrey,
                    ),
                    onPressed: _toggleObscure,
                  )
                : null,
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
              borderSide: BorderSide(
                color: ColorConfig.backgroundLightGrey,
                width: 2.0,
              ),
            ),
            suffix: widget.onTap != null
                ? Icon(Icons.keyboard_arrow_down_rounded, size: 18)
                : null,
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
                color: ColorConfig.backgroundLightGrey,
                width: 2.0,
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
        ),
      ],
    );
  }
}
