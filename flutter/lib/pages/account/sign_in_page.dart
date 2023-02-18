import 'package:ato/component/account/sign_in/sign_in_form.dart';
import 'package:ato/pages/account/sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Color(0xffffffff)
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, MediaQuery.of(context).size.height*0.05, 30, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Text("로그인", style: TextStyle(fontFamily: "jua", fontSize: 40), textAlign: TextAlign.center,),
                SizedBox(height: 50),
                SignInForm(),
                Divider(height: 40, thickness: 1,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("아직 회원이 아니신가요? | "),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignUpPage());
                      },
                      child: Text(
                        "회원가입",
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ),
      ),
    );
  }
}