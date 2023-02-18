package personal_project.ato_project.member.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import personal_project.ato_project.member.service.MemberService;
import personal_project.ato_project.member.service.request.AccountSignInRequest;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/account")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @PostMapping("/sign-up")
    public boolean SignUp(@RequestBody AccountSignUpRequest accountSignUpRequest) {
        log.info(String.valueOf(accountSignUpRequest));

        return memberService.signUp(accountSignUpRequest);
    }

    @PostMapping("/email-duplicate/{email}")
    public Boolean accountEmailDuplicateCheck(@PathVariable("email") String email) {
        log.info(email);

        return memberService.emailDuplicateCheck(email);
    }

    @PostMapping("/nickname-duplicate/{name}")
    public Boolean accountNicknameDuplicateCheck(@PathVariable("name") String name) {
        log.info(name);

        return memberService.nicknameDuplicateCheck(name);
    }

    @PostMapping("sign-in")
    public Map<String, String> signIn(@RequestBody AccountSignInRequest accountSignInRequest) {
        log.info(String.valueOf(accountSignInRequest));

        return memberService.signIn(accountSignInRequest);
    }
}
