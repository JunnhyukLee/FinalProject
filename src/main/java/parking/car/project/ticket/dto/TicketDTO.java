
package parking.car.project.ticket.dto;

import lombok.Data;

@Data
public class TicketDTO {
	private int ticket_code;
	private String ticket_type;
	private String ticket_name;
	private String ticket_days;
	private String ticket_time;
	private String ticket_price;
}
