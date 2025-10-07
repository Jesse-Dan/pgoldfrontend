// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pgoldapp/src/config/constants.dart';
import 'package:pgoldapp/src/reusables/models/crypto_rate.dart';
import 'package:pgoldapp/src/reusables/models/gift_card_rate.dart';
import 'package:pgoldapp/src/reusables/utils/show_loading.dart';
import 'package:pgoldapp/src/reusables/utils/show_text.dart';
import 'package:pgoldapp/src/services/http/http_manager.dart';
import 'package:pgoldapp/src/services/http/settle_http_req.dart';

final pGoldRateProvider = ChangeNotifierProvider(
  (ref) => PGoldRate.instance,
);

enum GiftCardActionType { sell, buy }

extension GiftCardActionTypeSubtitle on GiftCardActionType {
  String get title {
    switch (this) {
      case GiftCardActionType.sell:
        return "Sell Giftcards";
      case GiftCardActionType.buy:
        return "Buy Giftcards";
    }
  }

  String get subtitle {
    switch (this) {
      case GiftCardActionType.sell:
        return "Sell Giftcards to cash Instantly";
      case GiftCardActionType.buy:
        return "Buy  Giftcards with cash";
    }
  }
}

enum CryptoActionType { sell, buy }

extension CryptoActionTypeSubtitle on CryptoActionType {
  String get title {
    switch (this) {
      case CryptoActionType.sell:
        return "Sell Crypto";
      case CryptoActionType.buy:
        return "Buy Crypto";
    }
  }

  String get subtitle {
    switch (this) {
      case CryptoActionType.sell:
        return "Sell Crypto at the best market rate";
      case CryptoActionType.buy:
        return "Sell Crypto at the best market rate";
    }
  }
}

class PGoldRate extends ChangeNotifier {
  static final HttpManager httpManager = HttpManager(Constants.BASE_URL);

  PGoldRate._internal();

  static final PGoldRate instance = PGoldRate._internal();

  factory PGoldRate() => instance;

// GIFTCARD VALUE

  GiftCardRate? _giftCardRate;
  GiftCardRate? get giftCardRate => _giftCardRate;

  Giftcard? _selectedGiftCard;
  Giftcard? get selectedGiftCard => _selectedGiftCard;
  set selectedGiftCard(Giftcard? val) {
    _selectedGiftCard = val;
    notifyListeners();
  }

  Country? _selectedCountry;
  Country? get selectedCountry => _selectedCountry;
  set selectedCountry(Country? val) {
    _selectedCountry = val;
    notifyListeners();
  }

  Range? _selectedRange;
  Range? get selectedRange => _selectedRange;
  set selectedRange(Range? val) {
    _selectedRange = val;
    notifyListeners();
  }

  ReceiptCategory? _selectedReceiptCategory;
  ReceiptCategory? get selectedReceiptCategory => _selectedReceiptCategory;
  set selectedReceiptCategory(ReceiptCategory? val) {
    _selectedReceiptCategory = val;
    notifyListeners();
  }

  GiftCardActionType? _selectedCardAction;
  GiftCardActionType? get selectedCardAction => _selectedCardAction;
  set selectedCardAction(GiftCardActionType? val) {
    _selectedCardAction = val;
    notifyListeners();
  }

  final giftCardValueCtl = TextEditingController(text: "0");

  // CRYPTO VALUE

  CryptoRate? _cryptoRate;
  CryptoRate? get cryptoRate => _cryptoRate;
  set cryptoRate(CryptoRate? val) {
    _cryptoRate = val;
    notifyListeners();
  }

  Crypto? _crypto;
  Crypto? get crypto => _crypto;
  set crypto(Crypto? val) {
    _crypto = val;
    notifyListeners();
  }

  CryptoActionType? _selectedCryptoActionType;
  CryptoActionType? get selectedCryptoActionType => _selectedCryptoActionType;
  set selectedCryptoActionType(CryptoActionType? val) {
    _selectedCryptoActionType = val;
    notifyListeners();
  }

  final cryptoValueCtl = TextEditingController(text: "0");

  Future<void> getCryptoRates() async {
    try {
      if (_cryptoRate != null) return;

      final httpRes = await httpManager.get(
        '/crypto-rates',
        isAuthenticated: true,
      );

      final response = settleResponse<CryptoRate>(
        httpRes,
        fromJsonT: (json) => CryptoRate.fromJson(json),
      );

      if (response.statusCode == 200) {
        _cryptoRate = response.data;
        notifyListeners();
      }
    } catch (e) {
      final errorMessage = e.toString();
      showText(errorMessage);
    } finally {
      cancelLoading();
    }
  }

  Future<void> getGiftCardRates() async {
    try {
      if (_giftCardRate != null) return;
      final httpRes = await httpManager.get(
        '/giftcard-rates',
        isAuthenticated: true,
      );

      final response = settleResponse<GiftCardRate>(
        httpRes,
        fromJsonT: (json) => GiftCardRate.fromJson(json),
      );

      if (response.statusCode == 200) {
        _giftCardRate = response.data;
        notifyListeners();
      }
    } catch (e) {
      final errorMessage = e.toString();
      showText(errorMessage);
    } finally {
      cancelLoading();
    }
  }
}
