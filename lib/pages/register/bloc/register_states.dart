class RegisterStates {
  // create immutable so that it saves what we type or changed
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  // declare constructor so it can use the variables
  const RegisterStates({
    this.username = "",
    this.email = "",
    this.password = "",
    this.confirmPassword = "",
  });

  RegisterStates copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterStates(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
