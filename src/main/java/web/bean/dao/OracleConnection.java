package web.bean.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleConnection {
	
	public static Connection getConnection() {
		Connection conn = null;
		try {
			// H2 Driver 로드
			Class.forName("org.h2.Driver");

			// H2 데이터베이스 URL, 사용자명, 비밀번호 설정
			String dbURL = "jdbc:h2:~/test";  // H2 URL
			String user = "sa";               // H2 기본 사용자명
			String dbpw = "";                 // H2 기본 비밀번호는 빈 문자열

			// H2 데이터베이스에 연결
			conn = DriverManager.getConnection(dbURL, user, dbpw);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		if(rs != null) {
			try {rs.close();} catch(SQLException s) {s.printStackTrace();}
		}
		if(pstmt != null) {
			try {pstmt.close();} catch(SQLException s) {s.printStackTrace();}
		}
		if(conn != null) {
			try {conn.close();} catch(SQLException s) {s.printStackTrace();}
		}
	}
	
	public static void close(ResultSet rs1) {
		if(rs1 != null) {
			try {rs1.close();} catch(SQLException s) {s.printStackTrace();}
		}
	}
}



