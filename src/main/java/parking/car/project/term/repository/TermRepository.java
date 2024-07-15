package parking.car.project.term.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import parking.car.project.term.entity.Term;

public interface TermRepository extends JpaRepository<Term, Integer> {
}