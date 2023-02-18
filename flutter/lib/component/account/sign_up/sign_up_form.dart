import 'package:ato/api/spring_member_api.dart';
import 'package:ato/component/account/sign_up/sign_up_email_text_form.dart';
import 'package:ato/component/account/sign_up/sign_up_nickname_text_form.dart';
import 'package:ato/component/account/sign_up/sign_up_password_text_form.dart';
import 'package:ato/pages/account/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  bool checkedValue = false;

  void successSignUpSnackBar() {
    Get.snackbar(
      "타이틀",
      "메세지",
      titleText: Text("❗알림",
          textAlign: TextAlign.left, style: TextStyle(fontSize: 13)),
      messageText: Text("회원가입이 완료되었습니다.",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black12,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
      borderRadius: 30,
    );
  }
  void _accountDuplicateCheck(String messageVal) {
    Get.snackbar(
      "타이틀",
      "메세지",
      titleText: Text("❗알림",
          textAlign: TextAlign.left, style: TextStyle(fontSize: 13)),
      messageText: Text("${messageVal} 중복체크를 확인해주세요!",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.left),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black12,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
      margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
      borderRadius: 30,
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        child: Column(
          children: [
            SignUpEmailTextForm(controller: emailController),
            const SizedBox(height: 20),
            SignUpPasswordTextForm(
                controller: passwordController,
                confirmController: confirmPasswordController),
            const SizedBox(height: 20),
            SignUpNicknameTextForm(controller: nicknameController),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(250, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.black),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (SignUpEmailTextForm.buttonStateValue == true &&
                      SignUpNicknameTextForm.buttonStateValue == true) {

                    SpringMemberApi().signUp(MemberSignUpRequest(
                        emailController.text, confirmPasswordController.text, nicknameController.text));
                    successSignUpSnackBar();
                    Get.to(() => SignInPage());

                  } else if(SignUpEmailTextForm.buttonStateValue != true){
                    _accountDuplicateCheck("이메일");
                  } else if(SignUpNicknameTextForm.buttonStateValue != true) {
                    _accountDuplicateCheck("닉네임");
                  }
                }
              },
              child: const Text("가입하기",style: TextStyle(
                color: Colors.white
              ),),
            )
          ],
        ),
      ),
    );
  }
}
