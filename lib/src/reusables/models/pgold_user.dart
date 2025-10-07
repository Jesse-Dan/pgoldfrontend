class PgoldUser {
  final String id;
  final String name;
  final String email;
  final DateTime? emailVerifiedAt;
  final DateTime? otpExpiresAt;

  PgoldUser({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.otpExpiresAt,
  });

  factory PgoldUser.fromJson(Map<String, dynamic> json) {
    return PgoldUser(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.tryParse(json['email_verified_at'])
          : null,
      otpExpiresAt: json['otp_expires_at'] != null
          ? DateTime.tryParse(json['otp_expires_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'otp_expires_at': otpExpiresAt?.toIso8601String(),
      };
}
