import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_test/models/user.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();
}

class AuthStatusUnknown extends AuthenticationState {
  @override
  String toString() => 'AuthenticationStatusUnknown';

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthStatusSuccess extends AuthenticationState {
  final User user;
  final String response;

  AuthStatusSuccess(this.user, {this.response}) : super([user]);

  @override
  String toString() => 'AuthenticationStatusSuccess';

  @override
  List<Object> get props => throw UnimplementedError();
}

class AuthStatusFailure extends AuthenticationState {
  final String error;

  AuthStatusFailure(this.error) : super([error]);

  @override
  String toString() => 'AuthenticationStatusFailure { error: $error }';

  @override
  List<Object> get props => throw UnimplementedError();
}