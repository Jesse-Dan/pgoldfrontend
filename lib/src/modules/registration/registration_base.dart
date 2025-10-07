import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/modules/registration/views/email_view.dart';
import 'package:pgoldapp/src/modules/registration/views/personal_data_view.dart';
import 'package:pgoldapp/src/modules/registration/views/username_view.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_scaffold.dart';
import 'package:pgoldapp/src/reusables/components/step_header.dart';

final registrationStepProvider = StateProvider<int>((ref) => 1);

class RegistrationBase extends ConsumerStatefulWidget {
  static const routeName = "/RegistrationBase";
  const RegistrationBase({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationBaseState();
}

class _RegistrationBaseState extends ConsumerState<RegistrationBase> {
  final int totalSteps = 3;

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
      ref.read(registrationStepProvider.notifier).state = step + 1;
    }
  }

  Widget _buildStepContent(int step) {
    switch (step) {
      case 1:
        return const UserNameView();
      case 2:
        return const PersonalDataView();
      case 3:
        return const EmailView();
      default:
        return const Center(child: Text("Unknown Step"));
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
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
                              if (_formKey.currentState!.validate()) {
                                ref.read(pGoldAuthProvider).register();
                              }
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
      ),
    );
  }
}
