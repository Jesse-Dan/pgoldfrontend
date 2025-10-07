import 'package:equatable/equatable.dart';

class GiftCardRate extends Equatable {
  const GiftCardRate({
    required this.allGiftcards,
    required this.topTradedGiftcards,
  });

  final List<Giftcard> allGiftcards;
  static const String allGiftcardsKey = "all_giftcards";

  final List<Giftcard> topTradedGiftcards;
  static const String topTradedGiftcardsKey = "top_traded_giftcards";

  GiftCardRate copyWith({
    List<Giftcard>? allGiftcards,
    List<Giftcard>? topTradedGiftcards,
  }) {
    return GiftCardRate(
      allGiftcards: allGiftcards ?? this.allGiftcards,
      topTradedGiftcards: topTradedGiftcards ?? this.topTradedGiftcards,
    );
  }

  factory GiftCardRate.fromJson(Map<String, dynamic> json) {
    return GiftCardRate(
      allGiftcards: json["all_giftcards"] == null
          ? []
          : List<Giftcard>.from(
              json["all_giftcards"]!.map((x) => Giftcard.fromJson(x))),
      topTradedGiftcards: json["top_traded_giftcards"] == null
          ? []
          : List<Giftcard>.from(
              json["top_traded_giftcards"]!.map((x) => Giftcard.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "all_giftcards": allGiftcards.map((x) => x?.toJson()).toList(),
        "top_traded_giftcards":
            topTradedGiftcards.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$allGiftcards, $topTradedGiftcards, ";
  }

  @override
  List<Object?> get props => [
        allGiftcards,
        topTradedGiftcards,
      ];
}

class Giftcard extends Equatable {
  const Giftcard({
    required this.id,
    required this.title,
    required this.image,
    required this.brandLogo,
    required this.status,
    required this.createdAt,
    required this.confirmMin,
    required this.confirmMax,
    required this.countries,
  });

  final int? id;
  static const String idKey = "id";

  final String? title;
  static const String titleKey = "title";

  final String? image;
  static const String imageKey = "image";

  final String? brandLogo;
  static const String brandLogoKey = "brand_logo";

  final String? status;
  static const String statusKey = "status";

  final String? createdAt;
  static const String createdAtKey = "created_at";

  final int? confirmMin;
  static const String confirmMinKey = "confirm_min";

  final int? confirmMax;
  static const String confirmMaxKey = "confirm_max";

  final List<Country> countries;
  static const String countriesKey = "countries";

  Giftcard copyWith({
    int? id,
    String? title,
    String? image,
    String? brandLogo,
    String? status,
    String? createdAt,
    int? confirmMin,
    int? confirmMax,
    List<Country>? countries,
  }) {
    return Giftcard(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      brandLogo: brandLogo ?? this.brandLogo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      confirmMin: confirmMin ?? this.confirmMin,
      confirmMax: confirmMax ?? this.confirmMax,
      countries: countries ?? this.countries,
    );
  }

  factory Giftcard.fromJson(Map<String, dynamic> json) {
    return Giftcard(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      brandLogo: json["brand_logo"],
      status: json["status"],
      createdAt: json["created_at"],
      confirmMin: json["confirm_min"],
      confirmMax: json["confirm_max"],
      countries: json["countries"] == null
          ? []
          : List<Country>.from(
              json["countries"]!.map((x) => Country.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "brand_logo": brandLogo,
        "status": status,
        "created_at": createdAt,
        "confirm_min": confirmMin,
        "confirm_max": confirmMax,
        "countries": countries.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $title, $image, $brandLogo, $status, $createdAt, $confirmMin, $confirmMax, $countries, ";
  }

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        brandLogo,
        status,
        createdAt,
        confirmMin,
        confirmMax,
        countries,
      ];
}

class Country extends Equatable {
  const Country({
    required this.id,
    required this.status,
    required this.name,
    required this.image,
    required this.iso,
    required this.currency,
    required this.ranges,
  });

  final int? id;
  static const String idKey = "id";

  final String? status;
  static const String statusKey = "status";

  final String? name;
  static const String nameKey = "name";

  final String? image;
  static const String imageKey = "image";

  final String? iso;
  static const String isoKey = "iso";

  final Currency? currency;
  static const String currencyKey = "currency";

  final List<Range> ranges;
  static const String rangesKey = "ranges";

  Country copyWith({
    int? id,
    String? status,
    String? name,
    String? image,
    String? iso,
    Currency? currency,
    List<Range>? ranges,
  }) {
    return Country(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      image: image ?? this.image,
      iso: iso ?? this.iso,
      currency: currency ?? this.currency,
      ranges: ranges ?? this.ranges,
    );
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["id"],
      status: json["status"],
      name: json["name"],
      image: json["image"],
      iso: json["iso"],
      currency:
          json["currency"] == null ? null : Currency.fromJson(json["currency"]),
      ranges: json["ranges"] == null
          ? []
          : List<Range>.from(json["ranges"]!.map((x) => Range.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "name": name,
        "image": image,
        "iso": iso,
        "currency": currency?.toJson(),
        "ranges": ranges.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $status, $name, $image, $iso, $currency, $ranges, ";
  }

  @override
  List<Object?> get props => [
        id,
        status,
        name,
        image,
        iso,
        currency,
        ranges,
      ];
}

class Currency extends Equatable {
  const Currency({
    required this.id,
    required this.name,
    required this.symbol,
    required this.symbolNative,
    required this.decimalDigits,
    required this.rounding,
    required this.code,
    required this.namePlural,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final String? symbol;
  static const String symbolKey = "symbol";

  final String? symbolNative;
  static const String symbolNativeKey = "symbolNative";

  final int? decimalDigits;
  static const String decimalDigitsKey = "decimalDigits";

  final int? rounding;
  static const String roundingKey = "rounding";

  final String? code;
  static const String codeKey = "code";

  final String? namePlural;
  static const String namePluralKey = "namePlural";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  Currency copyWith({
    int? id,
    String? name,
    String? symbol,
    String? symbolNative,
    int? decimalDigits,
    int? rounding,
    String? code,
    String? namePlural,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Currency(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      symbolNative: symbolNative ?? this.symbolNative,
      decimalDigits: decimalDigits ?? this.decimalDigits,
      rounding: rounding ?? this.rounding,
      code: code ?? this.code,
      namePlural: namePlural ?? this.namePlural,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json["id"],
      name: json["name"],
      symbol: json["symbol"],
      symbolNative: json["symbolNative"],
      decimalDigits: json["decimalDigits"],
      rounding: json["rounding"],
      code: json["code"],
      namePlural: json["namePlural"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "symbolNative": symbolNative,
        "decimalDigits": decimalDigits,
        "rounding": rounding,
        "code": code,
        "namePlural": namePlural,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $name, $symbol, $symbolNative, $decimalDigits, $rounding, $code, $namePlural, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
        id,
        name,
        symbol,
        symbolNative,
        decimalDigits,
        rounding,
        code,
        namePlural,
        createdAt,
        updatedAt,
      ];
}

class Range extends Equatable {
  const Range({
    required this.id,
    required this.giftCardId,
    required this.giftCardCountryId,
    required this.status,
    required this.min,
    required this.max,
    required this.updatedBy,
    required this.receiptCategories,
  });

  final int? id;
  static const String idKey = "id";

  final String? giftCardId;
  static const String giftCardIdKey = "gift_card_id";

  final String? giftCardCountryId;
  static const String giftCardCountryIdKey = "gift_card_country_id";

  final String? status;
  static const String statusKey = "status";

  final String? min;
  static const String minKey = "min";

  final String? max;
  static const String maxKey = "max";

  final String? updatedBy;
  static const String updatedByKey = "updated_by";

  final List<ReceiptCategory> receiptCategories;
  static const String receiptCategoriesKey = "receipt_categories";

  Range copyWith({
    int? id,
    String? giftCardId,
    String? giftCardCountryId,
    String? status,
    String? min,
    String? max,
    String? updatedBy,
    List<ReceiptCategory>? receiptCategories,
  }) {
    return Range(
      id: id ?? this.id,
      giftCardId: giftCardId ?? this.giftCardId,
      giftCardCountryId: giftCardCountryId ?? this.giftCardCountryId,
      status: status ?? this.status,
      min: min ?? this.min,
      max: max ?? this.max,
      updatedBy: updatedBy ?? this.updatedBy,
      receiptCategories: receiptCategories ?? this.receiptCategories,
    );
  }

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
      id: json["id"],
      giftCardId: json["gift_card_id"],
      giftCardCountryId: json["gift_card_country_id"],
      status: json["status"],
      min: json["min"],
      max: json["max"],
      updatedBy: json["updated_by"],
      receiptCategories: json["receipt_categories"] == null
          ? []
          : List<ReceiptCategory>.from(json["receipt_categories"]!
              .map((x) => ReceiptCategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "gift_card_id": giftCardId,
        "gift_card_country_id": giftCardCountryId,
        "status": status,
        "min": min,
        "max": max,
        "updated_by": updatedBy,
        "receipt_categories":
            receiptCategories.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $giftCardId, $giftCardCountryId, $status, $min, $max, $updatedBy, $receiptCategories, ";
  }

  @override
  List<Object?> get props => [
        id,
        giftCardId,
        giftCardCountryId,
        status,
        min,
        max,
        updatedBy,
        receiptCategories,
      ];
}

class ReceiptCategory extends Equatable {
  const ReceiptCategory({
    required this.id,
    required this.updatedBy,
    required this.status,
    required this.title,
    required this.amount,
    required this.rangeId,
    required this.giftCardCountryId,
    required this.giftCardId,
  });

  final int? id;
  static const String idKey = "id";

  final String? updatedBy;
  static const String updatedByKey = "updated_by";

  final String? status;
  static const String statusKey = "status";

  final String? title;
  static const String titleKey = "title";

  final String? amount;
  static const String amountKey = "amount";

  final String? rangeId;
  static const String rangeIdKey = "range_id";

  final String? giftCardCountryId;
  static const String giftCardCountryIdKey = "gift_card_country_id";

  final String? giftCardId;
  static const String giftCardIdKey = "gift_card_id";

  ReceiptCategory copyWith({
    int? id,
    String? updatedBy,
    String? status,
    String? title,
    String? amount,
    String? rangeId,
    String? giftCardCountryId,
    String? giftCardId,
  }) {
    return ReceiptCategory(
      id: id ?? this.id,
      updatedBy: updatedBy ?? this.updatedBy,
      status: status ?? this.status,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      rangeId: rangeId ?? this.rangeId,
      giftCardCountryId: giftCardCountryId ?? this.giftCardCountryId,
      giftCardId: giftCardId ?? this.giftCardId,
    );
  }

  factory ReceiptCategory.fromJson(Map<String, dynamic> json) {
    return ReceiptCategory(
      id: json["id"],
      updatedBy: json["updated_by"],
      status: json["status"],
      title: json["title"],
      amount: json["amount"],
      rangeId: json["range_id"],
      giftCardCountryId: json["gift_card_country_id"],
      giftCardId: json["gift_card_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_by": updatedBy,
        "status": status,
        "title": title,
        "amount": amount,
        "range_id": rangeId,
        "gift_card_country_id": giftCardCountryId,
        "gift_card_id": giftCardId,
      };

  @override
  String toString() {
    return "$id, $updatedBy, $status, $title, $amount, $rangeId, $giftCardCountryId, $giftCardId, ";
  }

  @override
  List<Object?> get props => [
        id,
        updatedBy,
        status,
        title,
        amount,
        rangeId,
        giftCardCountryId,
        giftCardId,
      ];
}
