import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/data/authentication_repository.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_test/screens/authentication/ui/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationRepository _authenticationRepository =
  AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
        create: (context) =>
        AuthenticationBloc(authenticationRepository: _authenticationRepository),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    ),
    );
  }
}