package personal_project.ato_project.member.service.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import personal_project.ato_project.member.entity.Member;

@Getter
@ToString
@RequiredArgsConstructor
public class AccountSignUpRequest {

    private final String email;
    private final String password;
    private final String name;

    public Member setMember(){
        return new Member(email, name);
    }
}
