package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.*;

public class ListDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	private String sql = null;

	//카테고리 총 갯수 확인
	public int getKate() {							
		int result = 0;
		try {
			conn=OracleConnection.getConnection();
			sql = "select count (*) from kategorie";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return result;
	}

	//카테고리 전체 목록 가져오기
	public List kateList(int count) {			
		List katelist = null;
		try {
			conn=OracleConnection.getConnection();
			sql = "select * from kategorie order by kategorienum asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			katelist = new ArrayList(count);
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setKategoriename(rs.getString("KATEGORIENAME"));
				katelist.add(dto);

			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  katelist;
	}	
	//카테고리 넘버로 리스트 목록 가져오기
	public List listList(int kategorienum, int count) {			
		List listlist = null;
		try {
			conn=OracleConnection.getConnection();
			sql = "select * from list where kategorienum =?order by listnum asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,kategorienum);
			rs = pstmt.executeQuery();
			listlist = new ArrayList(count);
			while(rs.next()) {
				ListDTO dto = new ListDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setListname(rs.getString("LISTNAME"));
				listlist.add(dto);				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  listlist;
	}
	//카테고리 넘버로 리스트 갯수 가져오기
	public int getList(int kategorienum) {				
		int result = 0;
		try {
			conn=OracleConnection.getConnection();
			sql = "select count (*) from list where kategorienum=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,kategorienum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return result;
	}
	//카테고리 넘버 리스트 넘버로 게시글 갯수 가져오기
	public int getSubjCount(int kategorienum, int listnum) {			
		int result = 0;
		try {
			conn=OracleConnection.getConnection();
			sql = "select count (*) from notice"+kategorienum+"_"+listnum+" ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return result;
	}
	//카테고리 넘버 리스트 넘버로 게시글 갯수만큼 게시글 리스트 가져오기
	public List subjList(int kategorienum, int listnum, int count) {		
		List subjlist = null;
		try {
			conn=OracleConnection.getConnection();
			sql = "select n.*,m.nick from notice"+kategorienum+"_"+listnum+" n,member m where n.id = m.id order by num desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			subjlist = new ArrayList(count);
			while(rs.next()) {
				ContentDTO dto = new ContentDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setNum(rs.getInt("NUM"));
				dto.setSubject(rs.getString("SUBJECT"));
				dto.setConten(rs.getString("CONTEN"));
				dto.setId(rs.getString("Id"));
				dto.setFilecount(rs.getInt("FILECOUNT"));
				dto.setImgcount(rs.getInt("IMGCOUNT"));
				dto.setReadcount(rs.getInt("READCOUNT"));
				dto.setWritedate(rs.getString("writedate"));
				dto.setNick(rs.getString("nick"));
				subjlist.add(dto);				
			}
			for(int i =0; i<subjlist.size();i++) {

			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  subjlist;
	}
	// 카테고리,리스트,게시글 넘버로 게시글 정보 dao 호출 활용
	public ContentDTO content(int kategorienum, int listnum, int num) {		
		ContentDTO dto = null;
		UserDTO user = new UserDTO();
		UserDAO udao = new UserDAO();
		try {
			conn = OracleConnection.getConnection();
			sql = "select * from notice"+kategorienum+"_"+listnum+" where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			dto = new ContentDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));;
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setNum(rs.getInt("NUM"));
				dto.setSubject(rs.getString("SUBJECT"));
				dto.setConten(rs.getString("CONTEN"));
				dto.setId(rs.getString("ID"));      // 05.07 수정
				dto.setGoodnum(rs.getInt("GOODNUM"));
				dto.setBadnum(rs.getInt("BADNUM"));
				dto.setCommentcount(rs.getInt("COMMENTCOUNT"));
				dto.setFilecount(rs.getInt("FILECOUNT"));
				dto.setImgcount(rs.getInt("IMGCOUNT"));
				dto.setUpdatecount(rs.getInt("UPDATECOUNT"));
				dto.setReadcount(rs.getInt("READCOUNT"));
				dto.setWritedate(rs.getString("writedate"));
				dto.setNick(udao.user(rs.getString("ID")).getNick());
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return dto;
	}//카테고리,리스트,게시글 넘버로 게시글 표현 dao , 조회수 +1
	public ContentDTO readcontent(int kategorienum, int listnum, int num) {		
		ContentDTO dto = null;
		UserDTO user = new UserDTO();
		UserDAO udao = new UserDAO();
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("update notice"+kategorienum+"_"+listnum+" set readcount = readcount+1 where num =?");
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			sql = "select * from notice"+kategorienum+"_"+listnum+" where num =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			rs.next();
			dto = new ContentDTO();
			dto.setKategorienum(rs.getInt("KATEGORIENUM"));;
			dto.setListnum(rs.getInt("LISTNUM"));
			dto.setNum(rs.getInt("NUM"));
			dto.setSubject(rs.getString("SUBJECT"));
			dto.setConten(rs.getString("CONTEN"));
			dto.setId(rs.getString("ID"));      // 05.07 수정
			dto.setGoodnum(rs.getInt("GOODNUM"));
			dto.setBadnum(rs.getInt("BADNUM"));
			dto.setCommentcount(rs.getInt("COMMENTCOUNT"));
			dto.setFilecount(rs.getInt("FILECOUNT"));
			dto.setImgcount(rs.getInt("IMGCOUNT"));
			dto.setUpdatecount(rs.getInt("UPDATECOUNT"));
			dto.setReadcount(rs.getInt("READCOUNT"));
			dto.setWritedate(rs.getString("writedate"));
			dto.setNick(udao.user(rs.getString("ID")).getNick());

		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return dto;
	}
	//카테고리 이름 중복 체크
	public int checkkate(String katename) {			
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select count (*) from kategorie where kategoriename=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, katename);
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
	//카테고리 추가
	public void addkate(String katename) {		
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into kategorie values(kat_seq.nextval, ?)");
			pstmt.setString(1, katename);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	// 카테고리넘버의 리스트넘버중 가장 큰 숫자
	public int listch(int katenum) {		
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			sql = "select listnum from list where kategorienum=? order by listnum desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, katenum);
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
	//리스트 추가
	public void addList(ListDTO dto) {		
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into list values(?, ?, ?)");
			pstmt.setInt(1, dto.getKategorienum());
			pstmt.setInt(2, dto.getListnum());
			pstmt.setString(3, dto.getListname());
			pstmt.executeUpdate();		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//게시판 추가에 맞춰 테이블 및 시퀀스 추가
	public void addsub(int katenum, int listnum) {
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("create table notice"+katenum+"_" +listnum+" (kategorienum number,"
					+"listnum number, num number, subject varchar2(100), conten varchar2(4000), Id varchar2(100),"
					+" goodnum number default 0, badnum number default 0, commentcount number default 0,"
					+" filecount number, imgcount number, updatecount number default 0,"
					+ " readcount number default 0, writedate date)");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create sequence notice"+katenum+"_"+listnum+"_seq nocache");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create table gnb"+katenum+"_"+listnum+" (num number, id varchar2(100), gnb number)");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create table comment"+katenum+"_" +listnum
					+" (Kategorienum number,Listnum number,num number,commentnum number, commen varchar2(4000), id varchar2(100),"
					+" updatecount number default 0,writedate date)");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create sequence comment"+katenum+"_"+listnum+"_seq nocache");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create table file"+katenum+"_"+listnum
					+" (num number, originalname varchar2(1000),systemname varchar2(1000) primary key, countnum number)");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("create table img"+katenum+"_"+listnum
					+" (num number, originalname varchar2(1000),systemname varchar2(1000) primary key, countnum number)");
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//카테고리 넘버의 카테고리 정보 가져오기
	public ListDTO nkate(int katenum) {			
		ListDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from kategorie where kategorienum = ?");
			pstmt.setInt(1, katenum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ListDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setKategoriename(rs.getString("KATEGORIENAME"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return dto;
	}
	//카테고리넘버 리스트넘버로 리스트 정보 가져오기
	public ListDTO nlist(int katenum, int linum) {			
		ListDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from list where kategorienum = ? and listnum=?");
			pstmt.setInt(1, katenum);
			pstmt.setInt(2, linum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ListDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setListname(rs.getString("LISTNAME"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return dto;
	}
	//리스트 이름으로 리스트 정보 가져오기
	public ListDTO searchlist(String listname) {			
		ListDTO dto = null;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from list where listname=?");
			pstmt.setString(1, listname);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new ListDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setListname(rs.getString("LISTNAME"));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return dto;
	}

	//카테고리 테이블에서 레코드 삭제및 확인
	public int delKategorie(ListDTO kategoriedto) {
		int result = 1;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("delete from kategorie where kategorienum=?");
			pstmt.setInt(1, kategoriedto.getKategorienum());
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select count(*) from kategorie where kategorienum=? and kategoriename=?");
			pstmt.setInt(1, kategoriedto.getKategorienum());
			pstmt.setString(2, kategoriedto.getKategoriename());
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

	//리스트 테이블에서 레코드 삭제및 확인
	public int delList(ListDTO dto) {
		int result = 1;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("delete from list where listname=?");
			pstmt.setString(1, dto.getListname());
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select count(*) from list where kategorienum =? and listnum=?");
			pstmt.setInt(1, dto.getKategorienum());
			pstmt.setInt(2, dto.getListnum());
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
	//게시판 삭제에 맞춰 테이블및 시퀀스 삭제
	public void delsub(int katenum, int listnum) {
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("drop table notice"+katenum+"_" +listnum+" ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop sequence notice"+katenum+"_"+listnum+"_seq ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop table gnb"+katenum+"_"+listnum+" ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop table comment"+katenum+"_" +listnum+" ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop sequence comment"+katenum+"_"+listnum+"_seq ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop table file"+katenum+"_"+listnum+" ");
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("drop table img"+katenum+"_"+listnum+" ");
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//페이지에 따른 게시글 리스트 목록 가져오기
	public List subjpageList(int kategorienum, int listnum, int startnum, int endnum) {		
		List subjlist = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from(select kategorienum, listnum, "
					+ "num, subject, conten, id, goodnum, badnum, commentcount, filecount, "
					+ "imgcount, updatecount,nick,rownum r from((select n.*,m.nick from notice"
					+kategorienum+"_"+listnum+" n,member m where n.id=m.id order by num desc))) where r>= ? and r<=?");
			pstmt.setInt(1, startnum);
			pstmt.setInt(2, endnum);
			rs = pstmt.executeQuery();
			subjlist = new ArrayList(endnum - startnum);
			while(rs.next()) {
				ContentDTO dto = new ContentDTO();
				dto.setKategorienum(rs.getInt("KATEGORIENUM"));
				dto.setListnum(rs.getInt("LISTNUM"));
				dto.setNum(rs.getInt("NUM"));
				dto.setSubject(rs.getString("SUBJECT"));
				dto.setConten(rs.getString("CONTEN"));
				dto.setId(rs.getString("ID"));
				dto.setFilecount(rs.getInt("FILECOUNT"));
				dto.setImgcount(rs.getInt("IMGCOUNT"));
				dto.setNick(rs.getString("nick"));
				subjlist.add(dto);				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return  subjlist;
	}
	//조회수 가장 많은 게시글 호출
	public List readcountTop() {
		List subjlist = null;
		sql = "";
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select TABLE_NAME from tabs where TABLE_NAME like 'NOTICE%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(sql.equals("")) {
					sql = "select readcount, kategorienum, listnum, num from " + rs.getString(1);
				}else {
					sql += " union select readcount, kategorienum, listnum, num from " + rs.getString(1);
				}
			}
			OracleConnection.close(rs);
			if(sql.equals("")) {}else {
				subjlist = new ArrayList();
				pstmt = conn.prepareStatement(sql + " order by readcount desc");
				rs1 = pstmt.executeQuery();
				for(int i =0; i<10; i++) {
					ContentDTO dto = new ContentDTO();
					if(rs1.next()) {
						dto = content(rs1.getInt("KATEGORIENUM"),rs1.getInt("LISTNUM"),rs1.getInt("NUM"));
						subjlist.add(dto);
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs1,pstmt,conn);
		}
		return  subjlist;
	}
	//게시글이 가장 많은 게시판 호출
	public List bestNotice() {
		String listnames = "";
		String[] lists = null;
		int noticecount = 0;
		List contentlist = null;
		ContentDTO content = new ContentDTO();
		ResultSet rs2 = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select TABLE_NAME from tabs where TABLE_NAME like 'NOTICE%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(listnames.equals("")) {
					listnames=rs.getString(1);
				}else {
					listnames+=","+rs.getString(1);
				}
			}
			lists = listnames.split(",");
			OracleConnection.close(rs);
			if(listnames.equals("")) {}else {
			for(int i =0; i<lists.length;i++) {
				pstmt = conn.prepareStatement("select count(*) from " + lists[i]);
				rs1 = pstmt.executeQuery();
				if(rs1.next()) {
					if(rs1.getInt(1)>noticecount) {
						noticecount = rs1.getInt(1);
						listnames = lists[i];
					}
				}
			}
			OracleConnection.close(rs1);
			pstmt = conn.prepareStatement("select * from " + listnames +" order by num desc");
			rs2 = pstmt.executeQuery();
			contentlist = new ArrayList(10);
			for(int i = 0; i<10; i++) {
				ListDTO listdto = new ListDTO();
				if(rs2.next()) {
					content = content(rs2.getInt("KATEGORIENUM"),rs2.getInt("LISTNUM"),rs2.getInt("NUM"));
					contentlist.add(content);
				}
			}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs2,pstmt,conn);
		}
		return contentlist;
	}

}
