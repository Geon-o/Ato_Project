package personal_project.ato_project.member.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import personal_project.ato_project.member.entity.Member;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {
}
