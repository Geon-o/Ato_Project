import 'package:ato/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInTextForm extends StatefulWidget {
  SignInTextForm({Key? key, required this.text, required this.controller}) : super(key: key);

  final String text;
  final controller;

  @override
  State<SignInTextForm> createState() => _SignInTextFormState();
}

class _SignInTextFormState extends State<SignInTextForm> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        const SizedBox(height: 5.0,),
        TextFormField(
          controller: widget.controller,
          validator: (value){
            if (widget.text == "아이디"){
              return Validation().validateEmail(value!);
            } else if (widget.text == "비밀번호") {
              return Validation().validatePassword(value!);
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: widget.text == "비밀번호" ? true : false,
          decoration: InputDecoration(
            hintText: "${widget.text}",
            enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }
}