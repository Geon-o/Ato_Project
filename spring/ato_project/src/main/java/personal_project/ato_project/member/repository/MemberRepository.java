package personal_project.ato_project.member.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import personal_project.ato_project.member.entity.Member;

import java.util.Optional;

@Repository
public interface MemberRepository extends JpaRepository<Member, Long> {

    @Query("select m from Member m where m.email = :email")
    Optional<Member> findByEmail(@Param("email") String email);

    @Query("select m from Member m where m.name = :name")
    Optional<Member> findByNickname(@Param("name") String name);

    @Query("select m from Member m join fetch m.authentications where m.email = :email")
    Optional<Member> findByMemberEmail(@Param("email") String email);
}
