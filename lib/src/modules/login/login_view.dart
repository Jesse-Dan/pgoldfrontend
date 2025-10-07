import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pgoldapp/src/config/asset_config.dart';
import 'package:pgoldapp/src/config/color_config.dart';
import 'package:pgoldapp/src/modules/registration/registration_base.dart';
import 'package:pgoldapp/src/providers/authentication_provider.dart';
import 'package:pgoldapp/src/reusables/components/app_plain_text_field.dart';
import 'package:pgoldapp/src/reusables/components/app_scaffold.dart';
import 'package:pgoldapp/src/reusables/components/image_viewer.dart';
import 'package:pgoldapp/src/reusables/components/main_app_bar.dart';
import 'package:pgoldapp/src/reusables/components/scaffold_header.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';
import 'package:pgoldapp/src/reusables/utils/validator_mixin.dart';

class LoginView extends ConsumerStatefulWidget {
  static const routeName = "/LoginView";

  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginView();
}

class _LoginView extends ConsumerState<LoginView> with ValidatorMixin {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: MainAppBar(
        height: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ScaffoldHeader(
                  title: "Welcome back 👋",
                  subtitle: "Sign in to start using your Pgold Account!",
                  paddingTop: 24,
                  paddingBottom: 16,
                ),
                const SizedBox(height: 10),
                AppPlainTextField(
                  labelText: "Email",
                  hintText: "name@example.com",
                  controller: ref.read(pGoldAuthProvider).emailController,
                  leadingIcon: AppImageViewer(AssetConfig.mailIcon),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                AppPlainTextField(
                  labelText: "Password",
                  hintText: "Type Password",
                  secure: true,
                  controller: ref.read(pGoldAuthProvider).passwordController,
                  leadingIcon: AppImageViewer(AssetConfig.component4),
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) => validateNotEmpty(value, "Password"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        Text(
                          "Remember me",
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: context.textTheme.labelMedium?.copyWith(
                            color: ColorConfig.primaryBlueLight,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(pGoldAuthProvider).login();
                          }
                        },
                        child: Text("Next"))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: context.textTheme.labelMedium?.copyWith(
                        color: ColorConfig.textGrey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegistrationBase.routeName);
                      },
                      child: Text(
                        "Sign Up",
                        style: context.textTheme.labelMedium?.copyWith(
                            color: ColorConfig.primaryBlueLight,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorConfig.primaryBlueLight),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
