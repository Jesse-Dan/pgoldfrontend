import 'package:equatable/equatable.dart';

class CryptoRate extends Equatable {
  const CryptoRate({
    required this.data,
  });

  final List<Crypto> data;
  static const String dataKey = "data";

  CryptoRate copyWith({
    List<Crypto>? data,
  }) {
    return CryptoRate(
      data: data ?? this.data,
    );
  }

  factory CryptoRate.fromJson(Map<String, dynamic> json) {
    return CryptoRate(
      data: json["data"] == null
          ? []
          : List<Crypto>.from(json["data"]!.map((x) => Crypto.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$data, ";
  }

  @override
  List<Object?> get props => [
        data,
      ];
}

class Crypto extends Equatable {
  const Crypto({
    required this.id,
    required this.name,
    required this.code,
    required this.icon,
    required this.networks,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.isStable,
    required this.color,
    required this.minimumDeposit,
    required this.maximumDecimalPlaces,
    required this.showBuy,
    required this.buyRate,
    required this.sellRate,
    required this.usdRate,
  });

  final int? id;
  static const String idKey = "id";

  final String? name;
  static const String nameKey = "name";

  final String? code;
  static const String codeKey = "code";

  final String? icon;
  static const String iconKey = "icon";

  final List<Network> networks;
  static const String networksKey = "networks";

  final int? status;
  static const String statusKey = "status";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  final int? isStable;
  static const String isStableKey = "is_stable";

  final String? color;
  static const String colorKey = "color";

  final String? minimumDeposit;
  static const String minimumDepositKey = "minimumDeposit";

  final int? maximumDecimalPlaces;
  static const String maximumDecimalPlacesKey = "maximumDecimalPlaces";

  final bool? showBuy;
  static const String showBuyKey = "show_buy";

  final String? buyRate;
  static const String buyRateKey = "buy_rate";

  final String? sellRate;
  static const String sellRateKey = "sell_rate";

  final String? usdRate;
  static const String usdRateKey = "usd_rate";

  Crypto copyWith({
    int? id,
    String? name,
    String? code,
    String? icon,
    List<Network>? networks,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? isStable,
    String? color,
    String? minimumDeposit,
    int? maximumDecimalPlaces,
    bool? showBuy,
    String? buyRate,
    String? sellRate,
    String? usdRate,
  }) {
    return Crypto(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      icon: icon ?? this.icon,
      networks: networks ?? this.networks,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isStable: isStable ?? this.isStable,
      color: color ?? this.color,
      minimumDeposit: minimumDeposit ?? this.minimumDeposit,
      maximumDecimalPlaces: maximumDecimalPlaces ?? this.maximumDecimalPlaces,
      showBuy: showBuy ?? this.showBuy,
      buyRate: buyRate ?? this.buyRate,
      sellRate: sellRate ?? this.sellRate,
      usdRate: usdRate ?? this.usdRate,
    );
  }

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      icon: json["icon"],
      networks: json["networks"] == null
          ? []
          : List<Network>.from(
              json["networks"]!.map((x) => Network.fromJson(x))),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      isStable: json["is_stable"],
      color: json["color"],
      minimumDeposit: json["minimumDeposit"],
      maximumDecimalPlaces: json["maximumDecimalPlaces"],
      showBuy: json["show_buy"],
      buyRate: json["buy_rate"],
      sellRate: json["sell_rate"],
      usdRate: json["usd_rate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "icon": icon,
        "networks": networks.map((x) => x?.toJson()).toList(),
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_stable": isStable,
        "color": color,
        "minimumDeposit": minimumDeposit,
        "maximumDecimalPlaces": maximumDecimalPlaces,
        "show_buy": showBuy,
        "buy_rate": buyRate,
        "sell_rate": sellRate,
        "usd_rate": usdRate,
      };

  @override
  String toString() {
    return "$id, $name, $code, $icon, $networks, $status, $createdAt, $updatedAt, $isStable, $color, $minimumDeposit, $maximumDecimalPlaces, $showBuy, $buyRate, $sellRate, $usdRate, ";
  }

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        icon,
        networks,
        status,
        createdAt,
        updatedAt,
        isStable,
        color,
        minimumDeposit,
        maximumDecimalPlaces,
        showBuy,
        buyRate,
        sellRate,
        usdRate,
      ];
}

class Network extends Equatable {
  const Network({
    required this.id,
    required this.addressRegex,
    required this.memoRegex,
    required this.name,
    required this.code,
    required this.fee,
    required this.feeType,
    required this.minimum,
    required this.contractAddress,
    required this.explorerLink,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  static const String idKey = "id";

  final String? addressRegex;
  static const String addressRegexKey = "addressRegex";

  final dynamic memoRegex;
  static const String memoRegexKey = "memoRegex";

  final String? name;
  static const String nameKey = "name";

  final String? code;
  static const String codeKey = "code";

  final String? fee;
  static const String feeKey = "fee";

  final String? feeType;
  static const String feeTypeKey = "feeType";

  final String? minimum;
  static const String minimumKey = "minimum";

  final String? contractAddress;
  static const String contractAddressKey = "contractAddress";

  final dynamic explorerLink;
  static const String explorerLinkKey = "explorerLink";

  final DateTime? createdAt;
  static const String createdAtKey = "created_at";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updated_at";

  Network copyWith({
    int? id,
    String? addressRegex,
    dynamic? memoRegex,
    String? name,
    String? code,
    String? fee,
    String? feeType,
    String? minimum,
    String? contractAddress,
    dynamic? explorerLink,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Network(
      id: id ?? this.id,
      addressRegex: addressRegex ?? this.addressRegex,
      memoRegex: memoRegex ?? this.memoRegex,
      name: name ?? this.name,
      code: code ?? this.code,
      fee: fee ?? this.fee,
      feeType: feeType ?? this.feeType,
      minimum: minimum ?? this.minimum,
      contractAddress: contractAddress ?? this.contractAddress,
      explorerLink: explorerLink ?? this.explorerLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json["id"],
      addressRegex: json["addressRegex"],
      memoRegex: json["memoRegex"],
      name: json["name"],
      code: json["code"],
      fee: json["fee"],
      feeType: json["feeType"],
      minimum: json["minimum"],
      contractAddress: json["contractAddress"],
      explorerLink: json["explorerLink"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "addressRegex": addressRegex,
        "memoRegex": memoRegex,
        "name": name,
        "code": code,
        "fee": fee,
        "feeType": feeType,
        "minimum": minimum,
        "contractAddress": contractAddress,
        "explorerLink": explorerLink,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $addressRegex, $memoRegex, $name, $code, $fee, $feeType, $minimum, $contractAddress, $explorerLink, $createdAt, $updatedAt, ";
  }

  @override
  List<Object?> get props => [
        id,
        addressRegex,
        memoRegex,
        name,
        code,
        fee,
        feeType,
        minimum,
        contractAddress,
        explorerLink,
        createdAt,
        updatedAt,
      ];
}
