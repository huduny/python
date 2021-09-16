package CHAPTER11.chapter11_0915;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import oracle.jdbc.driver.OracleDriver;

public class JDBCEXMAPLE1 {

	public static void main(String[] args) throws Exception {
		
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {

			Class.forName("oracle.jdbc.driver.OracleDriver");
			connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "OYK93", "java");
			statement = connection.createStatement();
			resultSet = statement.executeQuery("select * from member");

			while (resultSet.next()) {
				String string = resultSet.getString("mem_id");
				String string2 = resultSet.getString("mem_id");
				String string3 = resultSet.getString("mem_hp");
				String string4 = resultSet.getString("mem_mail");
				System.out.printf("%s\t%s\t%s\t%s\n", string, string2, string3, string4);

			}
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally { // finally 안에 close를 무조건 해줘야 자원 반납이 된

			if (resultSet != null && statement != null && connection != null) {
				try {
					resultSet.close();
					statement.close();
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
//		crud(등록,읽기,수정,삭제)-기능별로 메소드를 만든다.










