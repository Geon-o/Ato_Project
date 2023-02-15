import 'package:ato/api/spring_member_api.dart';
import 'package:ato/component/common/common_alert_dialog.dart';
import 'package:ato/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpEmailTextForm extends StatefulWidget {
  SignUpEmailTextForm({Key? key, this.controller}) : super(key: key);

  final controller;
  static bool? buttonStateValue;

  @override
  State<SignUpEmailTextForm> createState() => _SignUpEmailTextFormState();
}

class _SignUpEmailTextFormState extends State<SignUpEmailTextForm> {
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

          if (Validation().validateEmail(email!) != null) {
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
          suffixIcon: Container(
            margin: EdgeInsets.only(right: 10),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0XFF000000),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: buttonEnable
                  ? () {
                      var validation = SpringMemberApi()
                          .emailDuplicateCheck(DuplicateEmailRequest(email!));

                      validation.then((value) {
                        if (value.success == true) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CommonAlertDialog(
                                    title: "✅",
                                    content: "사용 가능한 이메일입니다.",
                                    onCustomButtonPressed: () {
                                      Navigator.pop(context);
                                    });
                              });
                          setState(() {
                            buttonEnable = false;
                            SignUpEmailTextForm.buttonStateValue = true;
                          });
                        }
                        if (value.success == false) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CommonAlertDialog(
                                    title: "⚠️",
                                    content: "중복된 이메일입니다.",
                                    onCustomButtonPressed: () {
                                      Navigator.pop(context);
                                    });
                              });
                        }
                      });
                    }
                  : null,
              child: Text("중복 확인", style: TextStyle(color: Color(0xffFAEBD7))),
            ),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );
  }
}
