package parking.car.project.ticket.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.ticket.dto.TicketDTO;
import parking.car.project.ticket.entity.Ticket;
import parking.car.project.ticket.service.TicketService;

@Controller
@RequiredArgsConstructor
public class TicketController {
    private static final Logger logger = LogManager.getLogger(TicketController.class);
    @Inject
    private final TicketService ticketService;

    @GetMapping("/TicketSearch")
    public String TicketList(Model model) {
        model.addAttribute("TicketList", ticketService.ticketSearch());
        logger.info("전체 티켓조회: {}", model);
        return "ticket/ticket_search";
    }

    @GetMapping("/TicketDetailSearch")
    public String TicketDetailSearch(Model model, @RequestParam("ticket_code") Integer ticket_code) {
        model.addAttribute("TicketDetailSearch", ticketService.ticketDetailSearch(ticket_code));
        logger.info("티켓 상세조회: {}", model);
        return "ticket/ticket_search_detail";
    }

    @GetMapping("/TicketListDays")
    public String TicketListDays(Model model) {
        model.addAttribute("TicketListDays", ticketService.ticketListDays());
        logger.info("월권 조회: {}", model);
        return "ticket/ticket_purchase_listdays";
    }

    @GetMapping("/TicketListTime")
    public String TicketListTime(Model model) {
        model.addAttribute("TicketListTime", ticketService.ticketListTime());
        logger.info("시간권 조회: {}", model);
        return "ticket/ticket_purchase_listtime";
    }

    @GetMapping("/TicketInsert")
    public String TicketInsert() {
        return "ticket/ticket_insert";
    }

    @PostMapping("/TicketInsert")
    public String TicketInsert(Model model, TicketDTO ticketDTO) {
        Ticket ticket = new Ticket();
        ticket.setTicket_type(ticketDTO.getTicket_type());
        ticket.setTicket_name(ticketDTO.getTicket_name());
        ticket.setTicket_days(ticketDTO.getTicket_days());
        ticket.setTicket_time(ticketDTO.getTicket_time());
        ticket.setTicket_price(ticketDTO.getTicket_price());
        model.addAttribute("TicketInsert", ticketService.ticketSearch());
        ticketService.saveTicket(ticket);
        return "ticket/ticket_insert_view";
    }

    @GetMapping("/TicketUpdate")
    public String TicketUpdate(Model model, @RequestParam("ticket_code") Integer ticket_code) {
        Ticket ticket = ticketService.ticketDetailSearch(ticket_code);
        if (ticket != null) {
            TicketDTO ticketDTO = new TicketDTO();
            ticketDTO.setTicket_code(ticket.getTicket_code());
            ticketDTO.setTicket_type(ticket.getTicket_type());
            ticketDTO.setTicket_name(ticket.getTicket_name());
            ticketDTO.setTicket_days(ticket.getTicket_days());
            ticketDTO.setTicket_time(ticket.getTicket_time());
            ticketDTO.setTicket_price(ticket.getTicket_price());
            model.addAttribute("TicketUpdate", ticketDTO);
        }
        return "ticket/ticket_update";
    }

    @PostMapping("/TicketUpdate")
    public String TicketUpdate(TicketDTO ticketDTO) {
        Ticket ticket = new Ticket();
        ticket.setTicket_code(ticketDTO.getTicket_code());
        ticket.setTicket_type(ticketDTO.getTicket_type());
        ticket.setTicket_name(ticketDTO.getTicket_name());
        ticket.setTicket_days(ticketDTO.getTicket_days());
        ticket.setTicket_time(ticketDTO.getTicket_time());
        ticket.setTicket_price(ticketDTO.getTicket_price());
        ticketService.saveTicket(ticket);
        return "ticket/ticket_update_view";
    }

    @GetMapping("/TicketDelete")
    public String TicketDelete() {
        return "ticket/ticket_delete";
    }

    @PostMapping("/TicketDelete")
    public String TicketDelete(@RequestParam("ticket_code") Integer ticket_code) {
        ticketService.ticketDelete(ticket_code);
        return "ticket/ticket_delete_view";
    }
}