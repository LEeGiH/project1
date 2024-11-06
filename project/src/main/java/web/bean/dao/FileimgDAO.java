package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.ContentDTO;
import web.bean.dto.UploadDTO;
//파일 또는 이미지 업로드
public class FileimgDAO {	
	
private Connection conn = null;
private PreparedStatement pstmt = null;
private ResultSet rs = null;
private ResultSet rs1 = null;
private String sql = null;

	public void upload(UploadDTO dto,int num,int katenum, int listnum) {         
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into "+dto.getType()+katenum+"_"+listnum+" values (?,?,?,?)");
			pstmt.setInt(1, num);
			pstmt.setString(2, dto.getOriginalname());
			pstmt.setString(3, dto.getSystemname());
			pstmt.setInt(4, dto.getCountnum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//파일 또는 이미지의 목록 가져오기
	public List uploadlist(ContentDTO subj, String type) {         
		List filelist = null;
		int count = 0;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from "+type+subj.getKategorienum()+"_"+subj.getListnum()+" where num=? order by countnum asc");
			pstmt.setInt(1, subj.getNum());
			rs = pstmt.executeQuery();
			if(type.equals("file")) {
				count = subj.getFilecount();
			}else if(type.equals("img")) {
				count = subj.getImgcount();
			}
			filelist = new ArrayList(count);
			while(rs.next()) {
				UploadDTO dto = new UploadDTO();
				dto.setNum(rs.getInt("NUM"));
				dto.setOriginalname(rs.getString("ORIGINALNAME"));
				dto.setSystemname(rs.getString("SYSTEMNAME"));
				dto.setCountnum(rs.getInt("COUNTNUM"));
				filelist.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  filelist;
	}
	//파일 한개씩 삭제하기
	public void filedeleteOne(int katenum, int listnum, int num, String name, String type) {
		try {																					
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("update notice"+katenum+"_"+listnum+" set "+type+"count="+type+"count-1 where num=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("delete from "+type+katenum+"_"+listnum+" where num=? and systemname=?");
			pstmt.setInt(1, num);
			pstmt.setString(2, name);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//게시글 수정후 첨부파일 이미지 갯수 정리
	public void uploadedit(ContentDTO subj,String type, int count) {
		try {														
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("update notice"+subj.getKategorienum()+"_"+subj.getListnum()
			+" set "+type+"count = ? where num =?");
			pstmt.setInt(1, count);
			pstmt.setInt(2, subj.getNum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}

	//다른 리스트일때 게시글에 맞춰 파일 이미지 옮기기
	public void editupload(String type,int orikatenum, int orilistnum, int orinum, int newkatenum, int newlistnum, int newnum ) {
		List uploadlist = null;																//05.12 성진수정	
		int count = 0;																		
		UploadDTO updto = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select count(*) from "+type+orikatenum+"_"+orilistnum+" where num=?");
			pstmt.setInt(1, orinum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			pstmt = conn.prepareStatement("select * from "+type+orikatenum+"_"+orilistnum+" where num=?");
			pstmt.setInt(1, orinum);
			rs = pstmt.executeQuery();
			uploadlist = new ArrayList(count);
			while(rs.next()) {
				updto = new UploadDTO();
				updto.setNum(rs.getInt("NUM"));
				updto.setOriginalname(rs.getString("ORIGINALNAME"));
				updto.setSystemname(rs.getString("SYSTEMNAME"));
				updto.setCountnum(rs.getInt("countnum"));
				uploadlist.add(updto);
			}
			pstmt = conn.prepareStatement("insert into "+type+newkatenum+"_"+newlistnum+" values (?,?,?,?)");
			for(int i=0; i<uploadlist.size(); i++) {
				updto = (UploadDTO)uploadlist.get(i);
				pstmt.setInt(1, newnum);
				pstmt.setString(2, updto.getOriginalname());
				pstmt.setString(3, updto.getSystemname());
				pstmt.setInt(4, updto.getCountnum());
				pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement("delete from "+type+orikatenum+"_"+orilistnum+" where num=?");
			pstmt.setInt(1, orinum);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//이미지 변경
	public void imgChange(String img,String id) {
		try {
			conn = OracleConnection.getConnection();
			sql="update member set img=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,img);
			pstmt.setString(2,id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
}
