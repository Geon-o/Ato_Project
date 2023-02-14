package personal_project.ato_project.member.service.request;

import lombok.*;
import personal_project.ato_project.member.entity.Member;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AccountSignUpRequest {

    private String email;
    private String password;
    private String name;

    public Member setMember(){
        return new Member(email, name);
    }
}
