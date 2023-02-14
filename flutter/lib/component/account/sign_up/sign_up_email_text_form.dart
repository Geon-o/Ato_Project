import 'package:ato/api/spring_member_api.dart';
import 'package:ato/component/common/common_alert_dialog.dart';
import 'package:ato/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpEmailTextForm extends StatefulWidget{
  SignUpEmailTextForm({Key? key, this.controller}) : super(key: key);

  final controller;
  static bool? buttonStateValue;

  @override
  State<SignUpEmailTextForm> createState() => _SignUpEmailTextFormState();
}

class _SignUpEmailTextFormState extends State<SignUpEmailTextForm>{
  String? email;
  bool buttonEnable = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      validator: (text) => Validation().validateEmail(text!),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (text) {
        setState(() {
          email = text;
          if (Validation().validateEmail(email!) == null) {
            buttonEnable = true;
            SignUpEmailTextForm.buttonStateValue = false;
          }

          if (Validation().validateEmail(email!) != null){
            buttonEnable = false;
          }
        });
      },
      decoration: InputDecoration(
        labelText: "이메일",
        hintText: "이메일을 입력해주세요",
        enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        errorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        focusedErrorBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );
  }
}