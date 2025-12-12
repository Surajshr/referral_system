sealed class SignInEvent {
  const SignInEvent();
}

final class SignInRequested extends SignInEvent {
  const SignInRequested({required this.email, required this.password});

  final String email;
  final String password;
}
