package personal_project.ato_project.member.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import personal_project.ato_project.member.entity.Authentication;
import personal_project.ato_project.member.entity.BasicAuthentication;
import personal_project.ato_project.member.entity.Member;
import personal_project.ato_project.member.repository.AuthenticationRepository;
import personal_project.ato_project.member.repository.MemberRepository;
import personal_project.ato_project.member.service.request.AccountSignInRequest;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;
import personal_project.ato_project.member.service.security.RedisService;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Autowired
    private RedisService redisService;

    @Override
    public Boolean signUp(AccountSignUpRequest accountSignUpRequest) {
        final Member member = accountSignUpRequest.setMember();
        memberRepository.save(member);

        final BasicAuthentication authentication = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, accountSignUpRequest.getPassword());
        authenticationRepository.save(authentication);

        return true;
    }

    @Override
    public Boolean emailDuplicateCheck(String email) {
        Optional<Member> maybeEmail = memberRepository.findByEmail(email);

        if (maybeEmail.isEmpty()) {
            return false;
        }
        return true;
    }

    @Override
    public Boolean nicknameDuplicateCheck(String name) {
        Optional<Member> maybeNickname = memberRepository.findByNickname(name);

        if (maybeNickname.isEmpty()) {
            return false;
        }
        return true;
    }

    @Override
    public Map<String, String> signIn(AccountSignInRequest accountSignInRequest) {
        Optional<Member> maybeSignUpAccount = memberRepository.findByMemberEmail(accountSignInRequest.getEmail());

        if (maybeSignUpAccount.isPresent()) {
            Member member = maybeSignUpAccount.get();

            if (!member.isRightPassword(accountSignInRequest.getPassword())) {

                throw new RuntimeException("WRONG PASSWORD");
            }


            UUID memberToken = UUID.randomUUID();

            redisService.deleteByKey(memberToken.toString());
            redisService.setKeyAndValue(memberToken.toString(), member.getId());

            Map<String, String> memberInfo = new HashMap<>();
            memberInfo.put("memberValue", memberToken.toString());
            memberInfo.put("accountEmail", member.getEmail());
            memberInfo.put("accountNickname", member.getName());

            return memberInfo;
        }
        throw new RuntimeException("THIS IN AN UNREGISTERED ACCOUNT");
    }
}
