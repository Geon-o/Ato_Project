import 'package:ato/component/account/social/social_sign_in_platform.dart';
import 'package:ato/pages/account/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class SocialSignIn extends StatefulWidget {
  SocialSignIn({Key? key}) : super(key: key);

  @override
  State<SocialSignIn> createState() => _SocialSignInState();
}


class _SocialSignInState extends State<SocialSignIn> {
  NaverLoginResult? _loginResult;

  void signInWithNaver() async {
    final NaverLoginResult? result = await FlutterNaverLogin.logIn();

    if (result?.status == NaverLoginStatus.loggedIn) {
      setState(() {
        _loginResult = result;
      });
    } else {
      print("Login failed with error: ${result?.errorMessage}");
    }
    // final NaverLoginResult naverLoginResult = await FlutterNaverLogin.logIn();
    //
    // if (naverLoginResult?.status == NaverLoginStatus.loggedIn) {
    //   print('accessToken = ${naverLoginResult.accessToken}');
    //   print('id = ${naverLoginResult.account.id}');
    //   print('email = ${naverLoginResult.account.email}');
    //   print('name = ${naverLoginResult.account.name}');
    //
    //   setState(() {
    //     _socialPlatForm = SocialPlatForm.naver;
    //   });
    //   Get.to(SignUpPage());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _signInButton('naver_sign_in_logo',signInWithNaver)
          ],
        ),
      ),
    );
  }

  Widget _signInButton(String path, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink.image(
        image: AssetImage('asset/social_icon_image/$path.png'),
        width: 40,
        height: 40,
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(35.0)),
          onTap: onTap,
        ),
      ),
    );
  }
}
