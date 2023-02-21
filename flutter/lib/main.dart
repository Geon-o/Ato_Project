import 'package:ato/pages/account/sign_in_page.dart';
import 'package:ato/pages/account/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: "signUp",
        debugShowCheckedModeBanner: false,
        home: const SignInPage(),
        routes: {
          "sign-in": (context) => const SignInPage()
        },
      ),
    );
  }
}
