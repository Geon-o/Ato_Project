
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

class _SignUpFormState extends State<SignUpForm>{

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  bool checkedValue = false;

  void successSignUpSnackBar(){
    Get.snackbar(
      "타이틀",
      "메세지",
      titleText: Text("❗알림", textAlign: TextAlign.left, style: TextStyle(
        fontSize: 13)),
      messageText: Text("회원가입이 완료되었습니다.", style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),textAlign: TextAlign.left),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black12,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 30),
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
        height: 644,
        child: Column(
          children: [
            SignUpEmailTextForm(controller: emailController),
            const SizedBox(height: 20),
            SignUpPasswordTextForm(
              controller: passwordController,
              confirmController: confirmPasswordController
            ),
            const SizedBox(height: 20),
            SignUpNicknameTextForm(controller: nicknameController),
            const SizedBox(height: 80),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                primary: Colors.black
              ),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  if(SignUpEmailTextForm.buttonStateValue == true && SignUpNicknameTextForm.buttonStateValue == true){
                    var validation = SpringMemberApi().signUp(MemberSignUpRequest(
                      emailController.text,
                      confirmPasswordController.text,
                      nicknameController.text));
                    validation.then((value) {
                      if (value.success == true) {
                        Get.off(const SignInPage());
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                content: const Text(
                                  "오류 발생",
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text("확인", style: TextStyle(color: Colors.black)),
                                  ),
                                ],
                              );
                            });
                      }
                    });
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            content: const Text(
                              "중복확인을 진행해주세요",
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text("확인", style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          );
                        });
                  }
                  successSignUpSnackBar();
                }
              },
              child: const Text("가입하기"),
            )
          ],
        ),
      ),
    );
  }
}
