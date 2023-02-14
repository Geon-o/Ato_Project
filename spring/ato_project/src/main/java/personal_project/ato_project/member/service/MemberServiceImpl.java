package personal_project.ato_project.member.service;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import personal_project.ato_project.member.entity.Authentication;
import personal_project.ato_project.member.entity.BasicAuthentication;
import personal_project.ato_project.member.entity.Member;
import personal_project.ato_project.member.repository.AuthenticationRepository;
import personal_project.ato_project.member.repository.MemberRepository;
import personal_project.ato_project.member.service.request.AccountSignUpRequest;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private AuthenticationRepository authenticationRepository;

    @Override
    public Boolean signUp(AccountSignUpRequest accountSignUpRequest) {
        final Member member = accountSignUpRequest.setMember();
        memberRepository.save(member);

        final BasicAuthentication authentication = new BasicAuthentication(member,
                Authentication.BASIC_AUTH, accountSignUpRequest.getPassword());
        authenticationRepository.save(authentication);

        return true;
    }
}
