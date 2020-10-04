import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_test/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AuthUserChanged extends AuthenticationEvent {
  final User user;

  AuthUserChanged({this.user}) : super([user]);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationUserChanged';
}

class AuthLogoutRequested extends AuthenticationEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}