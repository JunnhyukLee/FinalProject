package parking.car.project.termrepository;

import org.springframework.data.jpa.repository.JpaRepository;
import parking.car.project.termentity.Term;

public interface TermRepository extends JpaRepository<Term, Integer> {
}