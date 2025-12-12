sealed class SignUpEvent {
  const SignUpEvent();
}

final class SignUpRegisterRequested extends SignUpEvent {
  const SignUpRegisterRequested({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.referralCode,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String? referralCode;
}
