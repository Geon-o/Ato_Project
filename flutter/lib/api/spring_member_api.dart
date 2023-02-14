import 'dart:convert';

import 'package:ato/api/ip_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringMemberApi {

  signUp(MemberSignUpRequest request) async {
    var body = json.encode(request);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/account/sign-up'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }
  }
}

class MemberSignUpRequest {
  String email;
  String password;
  String nickname;

  MemberSignUpRequest(
      this.email, this.password, this.nickname);

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': nickname
  };
}