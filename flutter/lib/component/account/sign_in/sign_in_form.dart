import 'dart:convert';

import 'package:ato/api/spring_member_api.dart';
import 'package:ato/component/account/member.dart';
import 'package:ato/component/account/sign_in/sign_in_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';


class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  static const storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final memberEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          SignInTextForm(text: "아이디", controller: memberEmailController),
          SizedBox(height: 30),
          SignInTextForm(text: "비밀번호", controller: passwordController),
          SizedBox(height: 30),
          ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              runSignIn();
            }
          },
              child: Text("로그인"),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff000000),
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(10.0),
                  textStyle: TextStyle(color: Colors.black)
              ))
        ],
      ),
    );
  }

  runSignIn() async {
    await SpringMemberApi().signIn(MemberSignInRequest(
        memberEmailController.text, passwordController.text));

    if (SpringMemberApi.signInResponse.statusCode == 200) {
      var val = jsonDecode(
          utf8.decode(SpringMemberApi.signInResponse.bodyBytes));
      var account = Member.fromJson(val);

      await storage.write(key: 'memberValue', value: account.memberValue);
      await storage.write(key: 'accountEmail', value: account.accountEmail);
      await storage.write(
          key: 'accountNickname', value: account.accountNickname);

      _signInSuccess();
    } else {
      _signInFail();
    }
  }

  void _signInSuccess() {
    Get.snackbar(
      "타이틀",
      "메세지",
      titleText: Text("📢로그인 알림", textAlign: TextAlign.left, style: TextStyle(
        fontSize: 13)),
      messageText: Text("로그인되었습니다! 즐거운 여행되세요", style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold),
        textAlign: TextAlign.left),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black12,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
      borderRadius: 30
    );
  }

  void _signInFail(){
    Get.snackbar(
        "타이틀",
        "메세지",
        titleText: Text("📢로그인 알림", textAlign: TextAlign.left, style: TextStyle(
            fontSize: 13)),
        messageText: Text("이메일 혹은 패스워드가 잘못되었습니다.", style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold),
            textAlign: TextAlign.left),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black12,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
        margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
        borderRadius: 30
    );
  }
}