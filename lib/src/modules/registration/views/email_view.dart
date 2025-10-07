import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/components/scaffold_header.dart';
import 'package:pgoldapp/src/reusables/utils/validator_mixin.dart';

class EmailView extends ConsumerStatefulWidget {
  static const routeName = "/EmailView";

  const EmailView({super.key});

  @override
  ConsumerState<EmailView> createState() => _EmailView();
}

class _EmailView extends ConsumerState<EmailView> with ValidatorMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ScaffoldHeader(
            title: "Email Address",
            subtitle: "Make sure you enter your details correctly!",
            paddingTop: 24,
            paddingBottom: 16,
          ),
          const SizedBox(height: 10),
          AppPlainTextField(
            labelText: "Email Address",
            hintText: "Enter Email Address",
            controller: ref.read(pGoldAuthProvider).emailController,
            leadingIcon: AppImageViewer(AssetConfig.mailIcon),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
