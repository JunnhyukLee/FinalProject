package parking.car.project.comment.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import parking.car.project.comment.entity.Comment;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Integer> {
	
	@Query("SELECT c FROM Comment c WHERE c.parking_code = :parking_code ORDER BY c.comment_code ASC")
	List<Comment> findCommentsByParkingCode(@Param("parking_code") int parking_code);
	
	@Query("SELECT c FROM Comment c WHERE c.member_code = :member_code ORDER BY c.comment_code ASC")
    List<Comment> findCommentsByMemberCode(@Param("member_code") int member_code);
	
    @Query("SELECT MAX(c.comment_code) FROM Comment c")
    Integer findMaxCommentCode();
    
	@Query("SELECT c FROM Comment c ORDER BY c.comment_code ASC")
    List<Comment> findAllComments();
}