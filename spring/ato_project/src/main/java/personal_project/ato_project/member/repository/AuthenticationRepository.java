package personal_project.ato_project.member.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import personal_project.ato_project.member.entity.Authentication;

@Repository
public interface AuthenticationRepository extends JpaRepository<Authentication, Long> {
}
