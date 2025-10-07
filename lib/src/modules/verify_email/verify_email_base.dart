import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/modules/login/login_view.dart';
import 'package:pgoldapp/src/modules/verify_email/views/email_verification_view.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_scaffold.dart';
import 'package:pgoldapp/src/reusables/components/step_header.dart';

final registrationStepProvider = StateProvider<int>((ref) => 1);

class VerifyEmailBase extends ConsumerStatefulWidget {
  final String email;
  static const routeName = "/VerifyEmailBase";
  const VerifyEmailBase({super.key, required this.email});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailBaseState();
}

class _VerifyEmailBaseState extends ConsumerState<VerifyEmailBase> {
  final int totalSteps = 2;

  void _handleBack() {
    final step = ref.read(registrationStepProvider);
    if (step > 1) {
      ref.read(registrationStepProvider.notifier).state = step - 1;
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _nextStep() {
    final step = ref.read(registrationStepProvider);
    if (step < totalSteps) {
      ref.read(pGoldAuthProvider).verifyOtp();
    } else {
      ref.read(registrationStepProvider.notifier).state = step + 1;
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return EmailVerifyView(email: widget.email);
      case 2:
        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Icon(
                    Icons.done_rounded,
                    size: 70,
                    color: Colors.white,
                  )),
              const SizedBox(height: 10),
              Text('Verification Successful'),
            ],
          ),
        );
      default:
        return Center(
          child: Text("Unknown Step"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(registrationStepProvider);

    return AppScaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: StepHeader(
          currentStep: currentStep,
          totalSteps: totalSteps,
          onBack: _handleBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Expanded(child: _buildStepContent(currentStep)),
            const SizedBox(height: 16),
            Row(
              children: [
                if (currentStep > 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _handleBack,
                      child: const Text("Back"),
                    ),
                  ),
                if (currentStep > 1) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: currentStep < totalSteps
                        ? _nextStep
                        : () {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginView.routeName);
                          },
                    child: Text(currentStep < totalSteps ? "Next" : "Finish"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
