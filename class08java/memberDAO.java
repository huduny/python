package CHAPTER11.chapter11_0915;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleDriver;

// dao (data access object)-디 에이 오
// gui (구이)
// div 
public class memberDAO {
//	등록(insert)
	
//	수정(update)
	
//	삭제(delete)
	
//	목록보기(select)
	public List<MemberVO> getMemberList() throws Exception{
		List<MemberVO> list = new ArrayList<MemberVO>();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "OYK93", "java");
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery("SELECT MEM_ID,MEM_NAME,MEM_HP,MEM_MAIL FROM MEMBER");
		
		while (resultSet.next()) {
			String memid = resultSet.getString("mem_id");
			String memname = resultSet.getString("mem_name");
			String memhp = resultSet.getString("mem_hp");
			String memmail = resultSet.getString("mem_mail");
			list.add(new MemberVO(memid,memname,memhp,memmail));
			
		}
		resultSet.close();
		statement.close();
		connection.close();
		return list;
	}
	
//	상세보기(select)
	public MemberVO getMember(String userId) throws Exception{
//		방법2
		DriverManager.registerDriver(new OracleDriver());
		Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "OYK93", "java");
		Statement statement = connection.createStatement();
		ResultSet resultSet = statement.executeQuery(String.format("SELECT MEM_ID,MEM_NAME,MEM_HP,MEM_MAIL FROM MEMBER where mem_id = '%s'", userId));
		if (resultSet.next()) {
			String memid = resultSet.getString("mem_id");
			String memname = resultSet.getString("mem_name");
			String memhp = resultSet.getString("mem_hp");
			String memmail = resultSet.getString("mem_mail");
		}
		
		return null;
	}
	
	
}
