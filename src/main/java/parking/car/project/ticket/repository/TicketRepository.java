package parking.car.project.ticket.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import parking.car.project.ticket.entity.Ticket;

public interface TicketRepository extends JpaRepository<Ticket, Integer> {

    @Query("SELECT t FROM Ticket t WHERE t.ticket_type = '월권'")
    List<Ticket> ticketListDays();

    @Query("SELECT t FROM Ticket t WHERE t.ticket_type = '시간권'")
    List<Ticket> ticketListTime();
}