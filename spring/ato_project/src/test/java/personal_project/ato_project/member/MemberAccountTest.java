package personal_project.ato_project.member;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import personal_project.ato_project.member.service.MemberService;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

@SpringBootTest
public class MemberAccountTest {

    @Autowired
    private MemberService memberService;

    @Test
    void memberSignUp(){
        AccountSignUpRequest accountSignUpRequest = new AccountSignUpRequest("geon@naver.com", "gggg", "테스트용");

        memberService.signUp(accountSignUpRequest);
    }

    @Test
    void accountEmailDuplicateCheck(){
        String email = "gggg@naver.com";

        System.out.println(memberService.emailDuplicateCheck(email));
    }
}
