package personal_project.ato_project.member.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import personal_project.ato_project.member.service.MemberService;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

@Slf4j
@RestController
@RequestMapping("/account")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @PostMapping("/sing-up")
    public boolean SignUp(@RequestBody AccountSignUpRequest accountSignUpRequest) {
        log.info(String.valueOf(accountSignUpRequest));

        return memberService.signUp(accountSignUpRequest);
    }
}
