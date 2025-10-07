import 'package:flutter/material.dart';
import 'package:pgoldapp/src/config/route_config.dart';
import 'package:pgoldapp/src/reusables/components/app_loading_indicator.dart';
import 'package:pgoldapp/src/reusables/extensions/context.dart';

import '../components/app_scaffold.dart';

extension AppScaffoldExtensions on AppScaffold {
  /// 🔹 Change background color
  AppScaffold withBackground(Color color) {
    return AppScaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: color,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Wrap body in padding
  AppScaffold withBodyPadding(EdgeInsets padding) {
    return AppScaffold(
      appBar: appBar,
      body: Padding(padding: padding, child: body),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Add bottom navigation bar
  AppScaffold withBottomNav(Widget nav) {
    return AppScaffold(
      appBar: appBar,
      body: body,
      bottomNavigationBar: nav,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Make body scrollable
  AppScaffold withScroll({EdgeInsets? padding}) {
    return AppScaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: padding,
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Wrap body in SafeArea
  AppScaffold withSafeArea({bool top = true, bool bottom = true}) {
    return AppScaffold(
      appBar: appBar,
      body: SafeArea(
        top: top,
        bottom: bottom,
        child: body ?? const SizedBox.shrink(),
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Center the body content
  AppScaffold centered() {
    return AppScaffold(
      appBar: appBar,
      body: Center(child: body),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Add gradient background behind the body
  AppScaffold withGradient(Gradient gradient) {
    return AppScaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(gradient: gradient),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Add vertical spacing to body content
  AppScaffold withVerticalSpacing(double space) {
    return AppScaffold(
      appBar: appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: space),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Wrap in SafeArea + ScrollView combo
  AppScaffold scrollSafe() {
    return AppScaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(child: body),
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Wrap body in Card
  AppScaffold withCardBody({EdgeInsets? padding, double? elevation}) {
    return AppScaffold(
      appBar: appBar,
      body: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Card(
          elevation: elevation ?? 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Show loading overlay or loader screen
  AppScaffold withLoading(bool isLoading, {String? message}) {
    if (!isLoading) return this;

    return AppScaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppLoadingIndicator(),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(message,
                  style: navigatorKey.currentContext!.textTheme.labelSmall!
                      .copyWith(fontSize: 16)),
            ],
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? Colors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  /// 🔹 Show error message with retry button
  AppScaffold withError(
    String? error, {
    required VoidCallback onRetry,
    String retryText = "Retry",
  }) {
    if (error == null || error.isEmpty) return this;

    return AppScaffold(
      appBar: appBar,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 64, color: Colors.redAccent.shade200),
              const SizedBox(height: 16),
              Text(
                error,
                textAlign: TextAlign.center,
                style: navigatorKey.currentContext!.textTheme.labelSmall!
                    .copyWith(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(retryText),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor ?? Colors.white,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
