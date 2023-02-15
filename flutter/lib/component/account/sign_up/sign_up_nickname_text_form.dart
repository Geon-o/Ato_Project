import 'package:ato/api/spring_member_api.dart';
import 'package:ato/component/common/common_alert_dialog.dart';
import 'package:ato/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpNicknameTextForm extends StatefulWidget {
  SignUpNicknameTextForm({Key? key, this.controller}) : super(key: key);

  final controller;
  static bool? buttonStateValue;

  @override
  State<SignUpNicknameTextForm> createState() => _SignUpNicknameTextForm();
}

class _SignUpNicknameTextForm extends State<SignUpNicknameTextForm> {
  String? name;
  bool buttonEnable = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      validator: (text) => Validation().validateNickname(text!),
      onChanged: (text) {
        setState(() {
          name = text;

          if (Validation().validateNickname(text) == null) {
            buttonEnable = true;
            SignUpNicknameTextForm.buttonStateValue = false;
          }

          if (Validation().validateNickname(text) != null) {
            buttonEnable = false;
          }
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          labelText: "닉네임",
          hintText: "닉네임을 입력해주세요",
          prefixIcon: Icon(Icons.portrait),
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
                      var validation = SpringMemberApi().nickNameDuplicateCheck(
                          DuplicateNicknameRequest(name!));

                      validation.then((value) {
                        if (value.success == false) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CommonAlertDialog(
                                    title: "⚠️",
                                    content: "사용 가능한 닉네임입니다.",
                                    onCustomButtonPressed: () {
                                      Navigator.pop(context);
                                    });
                              });
                          setState(() {
                            buttonEnable = false;
                            SignUpNicknameTextForm.buttonStateValue = true;
                          });
                        }
                        if (value.success == true) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CommonAlertDialog(
                                    title: "⚠️",
                                    content: "중복된 닉네임입니다.",
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}
