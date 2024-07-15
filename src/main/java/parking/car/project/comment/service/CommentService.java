package parking.car.project.comment.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import parking.car.project.comment.entity.Comment;
import parking.car.project.comment.repository.CommentRepository;
import jakarta.inject.Inject;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class CommentService {

    @Inject
    private CommentRepository commentRepository;

    @Transactional
    public Comment saveComment(Comment comment) {
        if (comment.getComment_code() == 0) {
            comment.setComment_code(generateUniqueCommentCode());
        }
        if (comment.getComment_date() == null) {
            comment.setComment_date(new Date());
        }
        return commentRepository.save(comment);
    }
    
    @Transactional(readOnly = true)
    public List<Comment> findCommentsByMemberCode(int member_code) {
        return commentRepository.findCommentsByMemberCode(member_code);
    }
    
    @Transactional(readOnly = true)
    public List<Comment> findCommentsByParkingCode(int parking_code) {
        return commentRepository.findCommentsByParkingCode(parking_code);
    }
  
    @Transactional(readOnly = true)
    public List<Comment> findAllComments() {
        return commentRepository.findAllComments();
    }
    
    @Transactional(readOnly = true)
    public Optional<Comment> findCommentById(int comment_code) {
        return commentRepository.findById(comment_code);
    }

    @Transactional
    public void deleteComment(int comment_code) {
        commentRepository.deleteById(comment_code);
    }

    @Transactional
    public Comment updateComment(int comment_code, Comment commentDetails) {
        Comment comment = commentRepository.findById(comment_code)
                .orElseThrow(() -> new RuntimeException("Comment not found"));
        comment.setComment_content(commentDetails.getComment_content());
        comment.setComment_date(new Date());
        comment.setParking_code(commentDetails.getParking_code());
        return commentRepository.save(comment);
    }

    private int generateUniqueCommentCode() {
        Integer maxCode = commentRepository.findMaxCommentCode();
        return (maxCode != null ? maxCode : 0) + 1;
    }
}