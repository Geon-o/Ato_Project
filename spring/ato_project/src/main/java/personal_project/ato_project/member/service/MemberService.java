package personal_project.ato_project.member.service;

import personal_project.ato_project.member.service.request.AccountSignInRequest;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

import java.util.Map;

public interface MemberService {

    Boolean signUp(AccountSignUpRequest accountSignUpRequest);

    Boolean emailDuplicateCheck(String email);

    Boolean nicknameDuplicateCheck(String name);

    Map<String, String> signIn(AccountSignInRequest accountSignInRequest);
}
