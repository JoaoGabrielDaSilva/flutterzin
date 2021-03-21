import 'package:flutterzin/utils/constants.dart';
import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  final String hintText;
  final Map<String, dynamic> data;
  final String property;

  LoginInput({this.hintText, this.data, this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        onSaved: (newValue) => data[property] = newValue,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Constants.BORDER_COLOR),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Constants.BORDER_COLOR),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Constants.BORDER_COLOR),
          ),
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
