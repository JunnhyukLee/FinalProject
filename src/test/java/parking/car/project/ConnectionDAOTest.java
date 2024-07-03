package parking.car.project;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class ConnectionDAOTest {
	
	private static final Logger logger = LogManager.getLogger(ConnectionDAOTest.class);
	
	@Autowired
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		
		try(Connection connection = dataSource.getConnection()) {
			logger.info("커넥션 확인 - " + connection);
		} catch (SQLException e) {
			logger.info("커넥션 예외 확인 - " + e);
		}
	}
}