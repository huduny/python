package CHAPTER11.chapter11_0915;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import oracle.jdbc.driver.OracleDriver;

public class JDBCExample {

	public static void main(String[] args) throws Exception {
		// JDBC(java database connection)
	
//	1. 데이터베이스 접속
//	1-1 접속 드라이버 로딩: 임포트한 문장을 전부다 써야된다
	Class.forName("oracle.jdbc.driver.OracleDriver");
	//DriverManager.registerDriver(new OracleDriver);
//	1-2 드라이버 매니저로 접속-주소,아이디,패스워드//assign해라
	Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","OYK93","java");
//	2. 쿼리문 작성
//	2-1 sql developer의 워크시트 생성, 명령문을 작성할 공간을 만든다.
	Statement statement = connection.createStatement();
//	3 쿼리문 작성, 전송-쿼리문 실행, resulset은 결과집합+목록 형태
	ResultSet resultSet = statement.executeQuery("select * from member");
	
//	4. 쿼리문 확인(컬럼에 해당하는 값을 써주면 그 값으로 반환해준다.)
	while (resultSet.next()) {
		String string = resultSet.getString("mem_id");
		String string2 = resultSet.getString("mem_id");
		String string3 = resultSet.getString("mem_hp");
		String string4 = resultSet.getString("mem_mail");
		System.out.printf("%s\t%s\t%s\t%s\n", string, string2, string3, string4);
		
	}
//	5. 결과 확인
	
//	6. 접속 해제
	resultSet.close();
	statement.close();
	connection.close();
	}
}
