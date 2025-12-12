class SignUpEntity {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String? referralCode;

  SignUpEntity({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.referralCode,
  });
}
