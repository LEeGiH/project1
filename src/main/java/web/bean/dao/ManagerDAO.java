package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.AnnouncementDTO;

public class ManagerDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	private String sql = null;
	//관리자 ( 회원등급 변경 )
	public void changeGrade(String nick, int grade) {
		try {
			conn = OracleConnection.getConnection();
			sql="update member set grade=? where nick=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,grade);
			pstmt.setString(2,nick);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//공지사항 작성
	public void annowrite(AnnouncementDTO dto) {
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into announcement values (anno_seq.nextval,?,?,sysdate)");        
			pstmt.setString(1, dto.getSubject() );
			pstmt.setString(2, dto.getConten());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//공지사항 총 갯수 확인
	public int anno() {
		int count = 0;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select count(*) from announcement ");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  count;
	}
	//공지사항 갯수만큼 공지사항 리스트 가져오기
	public List annoList(int count) {
		List annoList = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from announcement order by num desc");
			rs = pstmt.executeQuery();
			annoList = new ArrayList(count);
			while(rs.next()) {
				AnnouncementDTO dto = new AnnouncementDTO();
				dto.setNum(rs.getInt("NUM"));
				dto.setSubject(rs.getString("SUBJECT"));
				dto.setConten(rs.getString("CONTEN"));
				dto.setCrdate(rs.getString("CRDATE"));
				annoList.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  annoList;
	}
	//공지사항넘버로 공지사항 내용 가져오기
	public AnnouncementDTO anno(int num) {
		AnnouncementDTO dto = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from announcement where num=? ");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new AnnouncementDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setConten(rs.getString("conten"));
				dto.setCrdate(rs.getString("crdate"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  dto;
	}
	//사용 주의 (커뮤니티 리셋);
	public void reset() {						
		try {			
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select 'drop SEQUENCE '||table_name||'_seq' from user_TABLES where table_name like 'NOTICE%' "
					+ "or ( TABLE_NAME like 'COMMENT%' AND TABLE_NAME NOT LIKE '%ROG')");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pstmt = conn.prepareStatement(rs.getString(1));
	            pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement("select 'drop table '||table_name||'' from user_tables where table_name like 'NOTICE%' "
					+ "or  TABLE_NAME like 'GNB%' or  TABLE_NAME like 'FILE%' or  TABLE_NAME like 'IMG%' or (TABLE_NAME like 'COMMENT%' AND TABLE_NAME NOT LIKE '%ROG')");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pstmt = conn.prepareStatement(rs.getString(1));
	            pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement("DELETE FROM announcement");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM commentdeleterog");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM commentupdaterog");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM deleted_user");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM editnotice");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM kategorie");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM list");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM member");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DELETE FROM nickchange");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DROP SEQUENCE member_seq");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DROP SEQUENCE kat_seq");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("DROP SEQUENCE anno_seq");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("CREATE SEQUENCE member_seq");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("CREATE SEQUENCE kat_seq");
            pstmt.executeUpdate();
            pstmt = conn.prepareStatement("CREATE SEQUENCE anno_seq");
            pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}

}
