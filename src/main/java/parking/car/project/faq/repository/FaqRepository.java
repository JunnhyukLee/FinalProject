package parking.car.project.faq.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import parking.car.project.faq.entity.Faq;

public interface FaqRepository extends JpaRepository<Faq, Integer> {
	@Query("SELECT f FROM Faq f WHERE " +
		       "(:faq_title IS NULL OR f.faq_title LIKE %:faq_title%) AND " +
		       "(:member_name IS NULL OR f.member_name LIKE %:member_name%) " +
		       "ORDER BY f.faq_code ASC")
	Page<Faq> searchByTitleOrMemberName(@Param("faq_title") String faq_title, @Param("member_name") String member_name, Pageable pageable);

    @Query("SELECT COALESCE(MAX(f.faq_code), 0) FROM Faq f")
    Integer findMaxFaqCode();
    
    @Query("SELECT f FROM Faq f ORDER BY f.faq_code ASC")
    Page<Faq> findFaqAll(Pageable pageable);
    
    @Modifying
    @Transactional
    @Query("UPDATE Faq f SET f.faq_view = f.faq_view + 1 WHERE f.faq_code = :faq_code")
    void incrementFaqView(@Param("faq_code") int faq_code);
}