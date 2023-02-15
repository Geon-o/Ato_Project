package personal_project.ato_project.member.service;

import personal_project.ato_project.member.service.request.AccountSignUpRequest;

public interface MemberService {

    Boolean signUp(AccountSignUpRequest accountSignUpRequest);

    Boolean emailDuplicateCheck(String email);

    Boolean nicknameDuplicateCheck(String name);
}
