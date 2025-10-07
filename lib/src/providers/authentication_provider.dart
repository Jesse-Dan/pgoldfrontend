// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:finn_utils/finn_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/config/constants.dart';
import 'package:pgoldapp/src/config/route_config.dart';
import 'package:pgoldapp/src/modules/dashboard/main_view.dart';
import 'package:pgoldapp/src/modules/login/login_view.dart';
import 'package:pgoldapp/src/modules/onboarding/views/onboarding_screen.dart';
import 'package:pgoldapp/src/modules/verify_email/verify_email_base.dart';
import 'package:pgoldapp/src/reusables/models/auth_success_model.dart';
import 'package:pgoldapp/src/reusables/models/pgold_user.dart';
import 'package:pgoldapp/src/reusables/utils/show_loading.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';
import 'package:pgoldapp/src/services/http/http_manager.dart';
import 'package:pgoldapp/src/services/http/settle_http_req.dart';

final pGoldAuthProvider = ChangeNotifierProvider(
  (ref) => PGoldAuth.instance,
);

class PGoldAuth extends ChangeNotifier {
  static final FinnUtilStorage _localStorage = FinnUtils.storage;
  static final HttpManager httpManager = HttpManager(Constants.BASE_URL);

  PgoldUser? _currentUser;
  String? _authToken;
  bool _hasActiveSession = false;
  bool _firstTimeUser = false;

  PGoldAuth._internal();

  static final PGoldAuth instance = PGoldAuth._internal();

  factory PGoldAuth() => instance;

  // Getters
  PgoldUser? get currentUser => _currentUser;
  String? get authToken => _authToken;
  bool get hasActiveSession => _hasActiveSession;
  bool get firstTimeUser => _firstTimeUser;

  // Text Controllers
  final fullName = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  set currentUser(PgoldUser? user) {
    _currentUser = user;
    if (user != null) {
      _localStorage.write<String>(
        key: Constants.LOCAL_USER,
        value: json.encode(user.toJson()),
      );
    } else {
      _localStorage.delete(key: Constants.LOCAL_USER);
    }
  }

  set authToken(String? token) {
    _authToken = token;
    if (token != null) {
      _localStorage.write<String>(key: Constants.USER_TOKEN, value: token);
    } else {
      _localStorage.delete(key: Constants.USER_TOKEN);
    }
    _hasActiveSession = token?.isNotEmpty ?? false;
  }

  set firstTimeUser(bool value) {
    _firstTimeUser = value;
    _localStorage.write(key: Constants.FST_USER, value: value);
  }

  void setUserData() {
    final jsonUser = _localStorage.read<String>(key: Constants.LOCAL_USER);
    if (jsonUser != null) {
      _currentUser = PgoldUser.fromJson(json.decode(jsonUser));
    }
    _authToken = _localStorage.read<String>(key: Constants.USER_TOKEN);
    _hasActiveSession = _authToken?.isNotEmpty ?? false;
    _firstTimeUser = _localStorage.read(key: Constants.FST_USER) ?? false;
  }

  Future<void> decideInitialRoute(WidgetRef ref) async {
    setUserData();

    final navigator = ref.read(navigatorKeyProvider).currentState;

    final hasSeenOnboarding =
        FinnUtils.storage.read<bool>(key: 'hasSeenOnboarding') ?? false;
    final hasSession =
        _localStorage.read<String>(key: Constants.USER_TOKEN)?.isNotEmpty ??
            false;

    if (hasSession) {
      navigator?.pushReplacementNamed(MainView.routeName);
    } else if (!hasSession && !hasSeenOnboarding) {
      navigator?.pushReplacementNamed(OnboardingScreen.routeName);
    } else {
      navigator?.pushReplacementNamed(LoginView.routeName);
    }
  }

  Future<void> login() async {
    showLoading();

    try {
      final httpRes = await httpManager.post('/auth/login', {
        "email": emailController.text.trim(),
        "password": passwordController.text,
      });

      final response = settleResponse<AuthSuccessResponse>(
        httpRes,
        fromJsonT: (json) => AuthSuccessResponse.fromJson(json),
      );

      final user = response.data?.user;
      final token = response.data?.accessToken;

      if (user == null || token == null) {
        throw Exception("Login failed. Missing user or token.");
      }

      await _storeToken(token, user);

      navigatorKey.currentState?.pushReplacementNamed(MainView.routeName);
      resetFields();
    } catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains('Email not verified.')) {
        await _handleEmailVerification(
          navigatorKey,
          emailController.text.trim(),
        );
      }

      showText(errorMessage);
    } finally {
      cancelLoading();
    }
  }

  Future<void> getUser() async {
    showLoading();

    try {
      final httpRes = await httpManager.get(
        '/get-user',
        isAuthenticated: true,
      );

      log(httpRes, name: "getUser");

      final response = settleResponse<PgoldUser>(
        httpRes,
        fromJsonT: (json) => PgoldUser.fromJson(json),
      );

      if (response.statusCode == 200) {
        currentUser = response.data;
        notifyListeners();
      }
    } catch (e) {
      final errorMessage = e.toString();
      showText(errorMessage);
    } finally {
      cancelLoading();
    }
  }

  Future<PgoldUser?> getUserById(String userId) async {
    try {
      final httpRes = await httpManager.get(
        '/get-user/$userId',
        isAuthenticated: true,
      );

      log(httpRes, name: "getUser");

      final response = settleResponse<PgoldUser>(
        httpRes,
        fromJsonT: (json) => PgoldUser.fromJson(json),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      final errorMessage = e.toString();
      showText(errorMessage);
      return null;
    } finally {
      cancelLoading();
    }
    return null;
  }

  Future<void> register() async {
    showLoading();
    try {
      var httpRes = await httpManager.post('/auth/register', {
        "name": fullName.text,
        "email": emailController.text,
        "password": passwordController.text,
      });

      log(httpRes, name: "login");

      var response = settleResponse<dynamic>(
        httpRes,
        fromJsonT: (json) => (json),
      );

      if (response.statusCode == 201) {
        showText(
            "User Created successfully. On login you would be prompted to verify your email");
        navigatorKey.currentState?.pushNamed(
          LoginView.routeName,
        );
        resetFields();
      }
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  Future<void> _storeToken(String token, PgoldUser? user) async {
    currentUser = user;
    authToken = token;
    firstTimeUser = false;

    _localStorage.write<String>(key: Constants.USER_TOKEN, value: token);

    HttpManager.refireToken();
  }

  Future<void> sendOtp(String email) async {
    showLoading();
    try {
      var httpRes = await httpManager.post('/auth/send-otp', {"email": email});

      var response = settleResponse<dynamic>(
        httpRes,
        fromJsonT: (json) => (json),
      );

      if (response.statusCode == 200) {
        showText(response.message ?? "Otp sent successfully.");
        resetFields();
        navigatorKey.currentState?.popAndPushNamed(
          VerifyEmailBase.routeName,
          arguments: {'email': email},
        );
      }
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  Future<void> verifyOtp() async {
    showLoading();
    log(emailController.text, name: "[verifyOtp]");
    try {
      var httpRes = await httpManager.post('/auth/verify-otp', {
        "otp": otpController.text.trim(),
        "email": emailController.text,
      });

      final response = settleResponse<AuthSuccessResponse>(
        httpRes,
        fromJsonT: (json) => AuthSuccessResponse.fromJson(json),
      );

      final user = response.data?.user;
      final token = response.data?.accessToken;

      if (user == null || token == null) {
        throw Exception("Login failed. Missing user or token.");
      }

      if (response.statusCode == 200) {
        showText(response.message ?? "Verified successfully.");
        resetFields();

        await _storeToken(token, user);

        navigatorKey.currentState?.pushReplacementNamed(MainView.routeName);
        resetFields();
      }
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  Future<void> changePassword(String newPassword, String email) async {
    showLoading();
    try {
      var httpRes = await httpManager.post(
        '/change-password?email=$email&newPassword=$newPassword',
        {},
      );

      var response = settleResponse(httpRes, fromJsonT: (json) => {});

      if (response.statusCode == 200) {
        showText(response.message ?? "Verified successfully.");
        resetFields();

        navigatorKey.currentState?.pushReplacementNamed(LoginView.routeName);
      }
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  Future<void> _handleEmailVerification(
      GlobalKey<NavigatorState> navKey, String email) async {
    log(email, name: "_handleEmailVerification");
    showLoading();
    try {
      await sendOtp(email);

      navKey.currentState?.pushNamed(
        VerifyEmailBase.routeName,
        arguments: {"email": email},
      );
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  Future<void> logout() async {
    try {
      showLoading();

      // Clear all sensitive data
      currentUser = null;
      authToken = null;
      firstTimeUser = false;

      HttpManager.expireToken();

      // Reset controllers if needed
      emailController.clear();
      passwordController.clear();

      // Navigate to login or onboarding
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        LoginView.routeName,
        (_) => false,
      );
    } catch (e) {
      showText("Logout failed: $e");
    } finally {
      cancelLoading();
    }
  }

  Future<void> deleteAccount() async {
    showLoading();
    try {
      var httpRes = await httpManager.delete(
        '/delete-account?userId=${currentUser?.id}',
      );

      var response = settleResponse(httpRes, fromJsonT: (json) => {});

      if (response.statusCode == 200) {
        showText(response.message ?? "Verified successfully.");
        resetFields();

        await logout();

        navigatorKey.currentState?.pushReplacementNamed(LoginView.routeName);
      }
    } catch (e) {
      showText(e.toString());
    } finally {
      cancelLoading();
    }
  }

  void resetFields() {
    fullName.clear();
    emailController.clear();
    passwordController.clear();
    otpController.clear();
  }
}
