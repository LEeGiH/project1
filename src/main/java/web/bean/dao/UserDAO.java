package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import web.bean.dto.UserDTO;

public class UserDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	private String sql = null;
	//로그인 (회원등급으로 확인)
	public int loginCheck(UserDTO dto) {
		int result = -1;
		try {
			conn=OracleConnection.getConnection();
			sql = "select GRADE from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  result;
	}
	//회원가입
	public int userInput(UserDTO dto) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("SELECT COUNT(*) AS total_count"
					+ " FROM (SELECT id, nick FROM member WHERE id = ? OR nick = ?"
					+ " UNION ALL"
					+ " SELECT id, nick FROM deleted_user WHERE id =? OR nick =?)");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNick());
			pstmt.setString(3, dto.getId());
			pstmt.setString(4, dto.getNick());
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
			if(result == 0) {
				sql="insert into member(id,passwd,username,birth,phone,nick,usernum,reg,sex)"
						+"values(?,?,?,?,?,?,member_seq.nextval,sysdate,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,dto.getId());
				pstmt.setString(2,dto.getPasswd());
				pstmt.setString(3,dto.getUsername());
				pstmt.setString(4,dto.getBirth());
				pstmt.setString(5,dto.getPhone());
				pstmt.setString(6,dto.getNick());
				pstmt.setString(7,dto.getSex());
				pstmt.executeUpdate();
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}
	//ID 찾기
	public String findId(String username,String phone) {
		String result = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select id from member where username=? and phone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, username);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			result = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}

	//비밀번호 찾기
	public String findpw(String id,String phone) {
		String result = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select passwd from member where id=? and phone=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			result = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}
	//닉네임으로 유저 정보 검색
	public UserDTO getUserInfo(String nick) {
		UserDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from member where nick=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nick);
			rs = pstmt.executeQuery();
			dto = new UserDTO();
			if(rs.next()) {   
				dto.setId(rs.getString("id"));
				dto.setUsername(rs.getString("username"));
				dto.setBirth(rs.getString("birth"));
				dto.setImg(rs.getString("img"));
				dto.setGrade(rs.getInt("grade"));
				dto.setSex(rs.getString("sex"));      
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return dto;
	}
	//ID로 유저 정보 꺼내기
	public UserDTO user(String id) {
		UserDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new UserDTO();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setUsername(rs.getString("username"));
				dto.setBirth(rs.getString("birth").split(" ")[0]);
				dto.setPhone(rs.getString("phone"));
				dto.setNick(rs.getString("nick"));
				dto.setGrade(rs.getInt("grade"));
				dto.setUsernum(rs.getInt("usernum"));
				dto.setSex(rs.getString("sex"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setImg(rs.getString("img"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return dto;
	}
	//ID,nick 중복 검사
	public int duplicheck(String dupli, String checkname) {
		int result = 0 ;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count(*) from(SELECT "+dupli+" FROM member UNION SELECT "+dupli +" FROM deleted_user) where "+dupli+"=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,checkname);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}
	//유저탈퇴 ( 로그 남긴후 로그인 정보 삭제 )
	public void userDelete(UserDTO dto) {
		UserDTO deluser = new UserDTO();
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from member where id=? and passwd=?");
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPasswd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				deluser.setBirth(rs.getString("birth"));
				deluser.setGrade(rs.getInt("grade"));
				deluser.setId(rs.getString("id"));
				deluser.setImg(rs.getString("img"));
				deluser.setNick(rs.getString("nick"));
				deluser.setPasswd(rs.getString("passwd"));
				deluser.setPhone(rs.getString("phone"));
				deluser.setReg(rs.getTimestamp("reg"));
				deluser.setSex(rs.getString("sex"));
				deluser.setUsername(rs.getString("username"));
				deluser.setUsernum(rs.getInt("usernum"));
			}
			pstmt = conn.prepareStatement("insert into deleted_user values(?,?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, deluser.getBirth());
			pstmt.setInt(2, deluser.getGrade());
			pstmt.setString(3, deluser.getId());
			pstmt.setString(4, deluser.getImg());
			pstmt.setString(5, deluser.getNick());
			pstmt.setString(6, deluser.getPasswd());
			pstmt.setString(7, deluser.getPhone());
			pstmt.setTimestamp(8, deluser.getReg());
			pstmt.setString(9, deluser.getSex());
			pstmt.setString(10, deluser.getUsername());
			pstmt.setInt(11, deluser.getUsernum());   
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("delete from member where id=?");
			pstmt.setString(1,dto.getId());
			pstmt.executeUpdate();         
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//닉네임 변경
	public int changeNick(UserDTO dto) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();		
			pstmt = conn.prepareStatement("select changenum from nickchange where id=? order by changenum desc");
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}
	
	//닉네임 변경
	public void updatenick(UserDTO dto, String nick, int changenum) {
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into nickchange values (?,?,?,?)");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNick());
			pstmt.setString(3, nick);
			pstmt.setInt(4, changenum);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("update member set nick = ? where id=?");
			pstmt.setString(1, nick);
			pstmt.setString(2, dto.getId());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	// 회원정보 변경
	public void userUpdate(UserDTO dto) {				
		try {
			conn = OracleConnection.getConnection();
			sql="update member set passwd=?,username=?,birth=?,phone=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,dto.getPasswd());
			pstmt.setString(2,dto.getUsername());
			pstmt.setString(3,dto.getBirth());   
			pstmt.setString(4,dto.getPhone());
			pstmt.setString(5,dto.getId());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}

	public int nickcheck(UserDTO dto) {
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("SELECT COUNT(*) AS total_count"
					+ " FROM (SELECT nick FROM member WHERE nick = ?"
					+ " UNION ALL"
					+ " SELECT nick FROM deleted_user WHERE nick =?)");
			pstmt.setString(1, dto.getNick());
			pstmt.setString(2, dto.getNick());
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt(1);
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return result;
	}
	
}
