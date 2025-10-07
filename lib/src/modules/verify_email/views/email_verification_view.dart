import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_pin_input_field.dart';
import 'package:pgoldapp/src/reusables/components/scaffold_header.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';
import 'package:pgoldapp/src/reusables/utils/validator_mixin.dart';

class EmailVerifyView extends ConsumerStatefulWidget {
  final String email;
  static const routeName = "/EmailVerifyView";

  const EmailVerifyView({super.key, required this.email});

  @override
  ConsumerState<EmailVerifyView> createState() => _EmailVerifyView();
}

class _EmailVerifyView extends ConsumerState<EmailVerifyView>
    with ValidatorMixin {
  bool isLoading = false;

  Future<void> _requestOtp() async {
    setState(() => isLoading = true);
    try {
      ref.read(pGoldAuthProvider).otpController.clear();
      await ref.read(pGoldAuthProvider).sendOtp(widget.email);
      showText("OTP has been resent successfully!");
    } catch (e) {
      showText("Failed to resend OTP: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScaffoldHeader(
            title: "Verify Email",
            subtitle:
                "Before you continue, enter the 6-digit code sent to ${widget.email}!",
            paddingTop: 24,
            paddingBottom: 16,
          ),
          const SizedBox(height: 10),
          AppPinInputField(
            controller: ref.read(pGoldAuthProvider).otpController,
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              const Text(
                "Didn’t receive the code?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: isLoading ? null : _requestOtp,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  decoration: BoxDecoration(
                    color: isLoading ? Colors.grey[400] : Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          "Request OTP",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
