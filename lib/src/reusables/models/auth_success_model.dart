import 'package:pgoldapp/src/reusables/models/pgold_user.dart';


class AuthSuccessResponse {
  final PgoldUser user;
  final String accessToken;
  final String tokenType;

  AuthSuccessResponse({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  factory AuthSuccessResponse.fromJson(Map<String, dynamic> json) {
    return AuthSuccessResponse(
      user: PgoldUser.fromJson(json['user'] ?? {}),
      accessToken: json['access_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
    );
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'access_token': accessToken,
        'token_type': tokenType,
      };
}
