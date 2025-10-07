import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/components/scaffold_header.dart';
import 'package:pgoldapp/src/reusables/utils/validator_mixin.dart';

class UserNameView extends ConsumerStatefulWidget {
  static const routeName = "/UserNameView";

  const UserNameView({super.key});

  @override
  ConsumerState<UserNameView> createState() => _UserNameView();
}

class _UserNameView extends ConsumerState<UserNameView> with ValidatorMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ScaffoldHeader(
            title: "Create a username",
            subtitle: "Pick a name that represents your financial journey!",
            paddingTop: 24,
            paddingBottom: 16,
          ),
          const SizedBox(height: 10),
          AppPlainTextField(
            labelText: "Username",
            hintText: "johndoe1",
            leadingIcon: AppImageViewer(AssetConfig.userIcon),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}
