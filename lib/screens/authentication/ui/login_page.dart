import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/models/user.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/login_event.dart';
import 'package:flutter_bloc_test/screens/authentication/bloc/login_state.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthStatusUnknown) {
            return LoginBody();
          }if(state is AuthStatusFailure){
            return Column(children: [LoginBody(), SnackBar(content: Text(state.error),)],);
          }if(state is AuthStatusSuccess){
            return Center(child: Text(state.response));
          }else{
            return Column(children: [LoginBody(), SnackBar(content: Text('Unknown error occurred.'),)],);
          }
        },
    );
  }
}

class LoginBody extends StatefulWidget {

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final _formKey = GlobalKey<FormState>();
  static String _password;
  static String _email;
  AuthenticationBloc _authenticationBloc;
  
  @override
  void initState() {
    super.initState();
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //texts
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 28, 0, 12),
                      child: Text(
                        'JOIN US',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Montserrat',
                          color: Colors.lime[900],
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 12, 0, 12),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 42.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 12, 0, 12),
                      child: Text(
                        'Please enter your\ncredentials to login',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Poppins',
                          color: Colors.black54,
                        ),
                      )
                  ),
                  //textFields
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 12, 0, 12),
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 0, 36, 12),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          color: Colors.yellow[100],
                        ),
                        child: TextFormField(
                          onSaved: (value) => _email = value,
                          validator: _emailValidate,
                          autovalidate: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Email',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 0, 0, 12),
                      child: Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 0, 36, 12),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          color: Colors.yellow[100],
                        ),
                        child: TextFormField(
                          validator: _passwordValidate,
                          onSaved: (value) => _password = value,
                          autovalidate: true,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 17.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: InputBorder.none,
                          ),
                        ),
                      )
                  ),
                  //flatButton
                  Padding(
                    padding: EdgeInsets.fromLTRB(36, 12, 36, 12),
                    child: Container(
                      height: 42,
                      child: FlatButton(
                        onPressed: () {
                          // save the fields..
                          final form = _formKey.currentState;
                          form.save();

                          // Validate will return true if is valid, or false if invalid.
                          if (form.validate()) {
                            User user = User(email: _email, password: _password);
                            _authenticationBloc.add(AuthUserChanged(user: user));
                          }else{
                            _authenticationBloc.add(AuthUserChanged(user: User.empty));
                          }
                        },
                        color: Colors.purple[900],
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Register & Reset
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 10, 36, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Not registered yet? ',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(36, 10, 36, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot password? ',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.purple[900],
                            ),
                            child: Text(
                              'RESET',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _emailValidate(String value) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
      return '*Enter a valid email';
    }
    return null;
  }

  String _passwordValidate(String value) {
    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
      return '*Enter valid password';
    }
    return null;
  }
}

