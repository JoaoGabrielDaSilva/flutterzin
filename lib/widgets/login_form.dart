import 'package:flutterzin/models/login_data.dart';
import 'package:flutterzin/widgets/login_input.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final Future<void> Function(LoginData) handleSubmit;

  LoginForm(this.handleSubmit);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _data = Map<String, dynamic>();
  bool inLogin = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (!inLogin)
                    LoginInput(
                      hintText: 'Nome',
                      property: 'name',
                      data: _data,
                    ),
                  LoginInput(
                    hintText: 'E-mail',
                    property: 'email',
                    data: _data,
                  ),
                  LoginInput(
                    hintText: 'Senha',
                    property: 'password',
                    data: _data,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              _formKey.currentState.save();
                              widget.handleSubmit(
                                LoginData(
                                  email: _data['email'],
                                  password: _data['password'],
                                  name: _data['name'],
                                  isLogin: inLogin,
                                ),
                              );
                            },
                            child: Text(
                              inLogin ? 'Login' : 'Registrar',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        inLogin = !inLogin;
                      });
                    },
                    child: Text(
                      inLogin ? 'Registrar' : 'Login',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
