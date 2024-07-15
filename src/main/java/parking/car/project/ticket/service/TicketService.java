package parking.car.project.ticket.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jakarta.inject.Inject;
import parking.car.project.ticket.entity.Ticket;
import parking.car.project.ticket.repository.TicketRepository;

@Service
public class TicketService {
	@Inject
	private TicketRepository ticketRepository;
	@Transactional
	public Ticket saveTicket(Ticket ticket) {
	    return ticketRepository.save(ticket);
	}

	@Transactional(readOnly = true) 
	public List<Ticket> ticketSearch() {
		return ticketRepository.findAll();
	}
	@Transactional(readOnly = true)
	public Ticket ticketDetailSearch(Integer ticket_code) {
		return ticketRepository.findById(ticket_code).orElse(null);
	}
	@Transactional
	public void ticketDelete(Integer ticket_code) {
		ticketRepository.deleteById(ticket_code);
	}
	public boolean existsByTicketCode(Integer ticket_code) {
		return ticketRepository.existsById(ticket_code);
	}
	@Transactional
	public List<Ticket> ticketListDays() {
		return ticketRepository.ticketListDays();
	}
	@Transactional
	public List<Ticket> ticketListTime() {
		return ticketRepository.ticketListTime();
	}
}