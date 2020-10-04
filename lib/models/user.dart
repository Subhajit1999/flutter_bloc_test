import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({
    @required this.email,
    @required this.password,
    this.name,
  })  : assert(email != null),
        assert(password != null);

  final String email;
  final String password;
  final String name;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(email: '', password: '', name: null);

  @override
  List<Object> get props => [email, password, name];
}