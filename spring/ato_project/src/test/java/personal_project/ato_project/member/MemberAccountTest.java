package personal_project.ato_project.member;


import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import personal_project.ato_project.member.service.MemberService;
import personal_project.ato_project.member.service.request.AccountSignInRequest;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

@SpringBootTest
public class MemberAccountTest {

    @Autowired
    private MemberService memberService;

    @Test
    void memberSignUp(){
        AccountSignUpRequest accountSignUpRequest = new AccountSignUpRequest("geon@ggg.com", "gggg", "테스트용");

        memberService.signUp(accountSignUpRequest);
    }

    @Test
    void accountEmailDuplicateCheck(){
        String email = "gggg@naver.com";

        System.out.println(memberService.emailDuplicateCheck(email));
    }

    @Test
    void accountNicknameDuplicateCheck(){
        String name = "테스트";

        System.out.println(memberService.nicknameDuplicateCheck(name));
    }

    @Test
    void memberSignIn(){
        AccountSignInRequest accountSignInRequest = new AccountSignInRequest("geo@ggg.com", "gggg");

        memberService.signIn(accountSignInRequest);
    }
}
