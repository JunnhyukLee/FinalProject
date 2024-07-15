package parking.car.project.parkingsearch.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import parking.car.project.comment.entity.Comment;
import parking.car.project.comment.repository.CommentRepository;
import parking.car.project.parking.entity.Parking;
import parking.car.project.parkingsearch.repository.ParkingSearchRepository;

import java.util.List;

@Service
@Transactional
public class ParkingSearchService {

    private final ParkingSearchRepository parkingSearchRepository;
    private final CommentRepository commentRepository;

    @Autowired
    public ParkingSearchService(ParkingSearchRepository parkingSearchRepository, CommentRepository commentRepository) {
        this.parkingSearchRepository = parkingSearchRepository;
        this.commentRepository = commentRepository;
    }

    public List<Parking> getAllParkings() {
        return parkingSearchRepository.findAll();
    }

    public Parking getParkingByCode(int parking_code) {
        return parkingSearchRepository.findByParkingCode(parking_code);
    }

    public List<Comment> findCommentsByParkingCode(int parking_code) {
        return commentRepository.findCommentsByParkingCode(parking_code);
    }
}