abstract class SignInEvent {
  const SignInEvent();
}

// when email is changed or typed
class EmailEvent extends SignInEvent {
  final String email;
  const EmailEvent(this.email);
}

// when password is changed or typed
class PasswordEvent extends SignInEvent {
  final String password;
  const PasswordEvent(this.password);
}
