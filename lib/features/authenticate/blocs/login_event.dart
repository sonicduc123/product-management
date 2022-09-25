abstract class AuthenticateEvent {}

class LoginEvent extends AuthenticateEvent {
  LoginEvent(this.email, this.password);

  final String email;
  final String password;
}
