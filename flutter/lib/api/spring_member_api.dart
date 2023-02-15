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

  Future<DuplicateEmailResponse> emailDuplicateCheck(
      DuplicateEmailRequest request) async {
    var data = {"email": request.email};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/account/duplicate/${request.email}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }

    if (response.body == "true") {
      return DuplicateEmailResponse(true);
    } else {
      return DuplicateEmailResponse(false);
    }
  }

  Future<DuplicateNicknameResponse> nickNameDuplicateCheck(
      DuplicateNicknameRequest request) async {
    var data = {"name": request.name};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/account/duplicate/${request.name}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }

    if (response.body == "true") {
      return DuplicateNicknameResponse(true);
    } else {
      return DuplicateNicknameResponse(false);
    }
  }
}

class MemberSignUpRequest {
  String email;
  String password;
  String name;

  MemberSignUpRequest(
      this.email, this.password, this.name);

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'name': name
  };
}

class DuplicateEmailResponse {
  bool? success;

  DuplicateEmailResponse(this.success);
}

class DuplicateEmailRequest {
  String email;

  DuplicateEmailRequest(this.email);
}

class DuplicateNicknameResponse {
  bool? success;

  DuplicateNicknameResponse(this.success);
}

class DuplicateNicknameRequest {
  String name;

  DuplicateNicknameRequest(this.name);
}