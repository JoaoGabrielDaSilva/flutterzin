import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutterzin/models/login_data.dart';
import 'package:flutterzin/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleSubmit(LoginData data) async {
    try {
      if (data.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: data.email.trim(),
          password: data.password,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: data.email.trim(),
          password: data.password,
        );
      }

      final userData = {
        'name': data.name.trim(),
        'email': data.email,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set(userData);
    } catch (error) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Ocorreu um erro! Tente novamente'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LoginForm(_handleSubmit),
    );
  }
}
