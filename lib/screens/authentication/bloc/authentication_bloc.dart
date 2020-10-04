import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/data/authentication_repository.dart';
import 'package:flutter_bloc_test/models/user.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/login_event.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/login_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({@required this.authenticationRepository});

  @override
  AuthenticationState get initialState => AuthStatusUnknown();

  @override
  void onTransition(Transition<AuthenticationEvent, AuthenticationState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async*{
    if (event is AuthUserChanged) {
      yield* _mapUserAuthenticationChangedToState(event);
    }
  }

  Stream _mapUserAuthenticationChangedToState(AuthUserChanged event) async* {
    final User user = event.user;
    if (user == User.empty) {
      yield AuthStatusUnknown();
    } else {
      try {
        final authResult = await AuthenticationRepository().attemptLogIn(user.email, user.password);
        print(authResult);
        yield AuthStatusSuccess(user, response: authResult);
      } catch (error) {
        yield AuthStatusFailure(error);
      }
    }
  }
}