package web.bean.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import web.bean.dto.*;

public class BoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ResultSet rs1 = null;
	private String sql = null;

	public int noti_num(String id) {						//ID로 작성된 게시글 개수
		int notinum = 0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select TABLE_NAME from tabs where TABLE_NAME like 'NOTICE%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				pstmt = conn.prepareStatement("select count(*) from "+rs.getString(1)+" where id=?");
				pstmt.setString(1, id);
				rs1 = pstmt.executeQuery();
				while(rs1.next()) {
					notinum += rs1.getInt(1);
				}
				OracleConnection.close(rs1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {   
			OracleConnection.close(rs,pstmt,conn);
		}
		return notinum;
	}
	//ID로 작성된 게시글 리스트 만들기
	public List notice_num(String id, int startnum,int endnum) {
		List notinum = null;
		sql = "";
		ListDAO listdao = new ListDAO();
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select tabLe_name from tabs where table_name like 'NOTICE%'");
			rs = pstmt.executeQuery();
			notinum = new ArrayList(endnum - startnum);
			while(rs.next()) {
				if(sql.equals("")) {
					sql = "SELECT id, kategorienum, listnum,num,writedate FROM "+rs.getString(1);
				}else {
					sql += " UNION SELECT id, kategorienum, listnum,num,writedate FROM "+rs.getString(1);
				}
			}
			OracleConnection.close(rs);
			pstmt = conn.prepareStatement("select * from (select kategorienum, listnum, num, writedate, id, rownum r from ("
					+sql+ ")where id=? order by writedate desc) where r>=? and r<= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, startnum);
			pstmt.setInt(3, endnum);				
			rs1 = pstmt.executeQuery();
			while(rs1.next()) {
				ContentDTO sub = new ContentDTO();
				sub = listdao.content(rs1.getInt("KATEGORIENUM"),rs1.getInt("LISTNUM"),rs1.getInt("NUM"));
				notinum.add(sub);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {   
			OracleConnection.close(rs1,pstmt,conn);
		}
		return notinum;
	}   
	//ID로 작성된 댓글 개수
	public int com_num(String id) {                  
	      int notinum = 0;
	      try {
	         conn = OracleConnection.getConnection();
	         pstmt = conn.prepareStatement("select TABLE_NAME from tabs where (TABLE_NAME like 'COMMENT%' AND TABLE_NAME NOT LIKE '%ROG')");
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            pstmt = conn.prepareStatement("select count(*) from "+rs.getString(1)+" where id=?");
	            pstmt.setString(1, id);
	            rs1 = pstmt.executeQuery();
	            while(rs1.next()) {
	               notinum += rs1.getInt(1);
	            }
	            OracleConnection.close(rs1);
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {   
	         OracleConnection.close(rs,pstmt,conn);
	      }
	      return notinum;
	   }
	   public List comen_num(String id, int startnum,int endnum) {         //ID로 작성된 게시글 리스트 만들기
	      List notinum = null;
	      sql = "";
	      UserDAO dao = new UserDAO();
	      UserDTO user = new UserDTO();
	      user = dao.user(id);
	      String nick = user.getNick();
	      try {
	    	conn = OracleConnection.getConnection();
	    	pstmt = conn.prepareStatement("select TABLE_NAME from tabs where (TABLE_NAME like 'COMMENT%' AND TABLE_NAME NOT LIKE '%ROG')");
	    	rs = pstmt.executeQuery();
	    	notinum = new ArrayList(endnum - startnum);
	    	while(rs.next()) {
	    		if(sql.equals("")) {
	    			sql = "SELECT id, kategorienum, listnum, num, writedate, commentnum, commen, updatecount FROM "+rs.getString(1);
				}else {
					sql += " UNION SELECT id, kategorienum, listnum, num, writedate, commentnum, commen, updatecount FROM "+rs.getString(1);
				}
	    	}
	    	OracleConnection.close(rs);
	    	pstmt = conn.prepareStatement("select * from (select "
	    		+ "id, kategorienum, listnum, num, writedate, commentnum, commen, updatecount, rownum r from ("
	    		+sql+")where id=? order by writedate desc) where r>=? and r<= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, startnum);
			pstmt.setInt(3, endnum);				
			rs1 = pstmt.executeQuery();
			while(rs1.next()) {
				CommentDTO commen = new CommentDTO();
				commen.setCommen(rs1.getString("COMMEN"));
				commen.setCommentnum(rs1.getInt("COMMENTNUM"));
				commen.setId(rs1.getString("ID"));
				commen.setKategorienum(rs1.getInt("KATEGORIENUM"));
				commen.setListnum(rs1.getInt("LISTNUM"));
				commen.setNick(nick);
				commen.setNum(rs1.getInt("NUM"));
				commen.setUpdatecount(rs1.getInt("UPDATECOUNT"));
				commen.setWritedate(rs1.getString("WRITEDATE"));
				notinum.add(commen);
			}
			OracleConnection.close(rs1);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {   
	         OracleConnection.close(rs,pstmt,conn);
	      }
	      return notinum;
	   }
	   
	//게시글 작성
	public int write(ContentDTO dto,int katenum,int listnum) {   
		int result = 0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into notice"+katenum+"_"+listnum+
					" (kategorienum, listnum, num, subject, conten, Id, filecount, imgcount,writedate)"+
					" values(?,?,notice"+katenum+"_"+
					listnum+"_seq.nextval,?,?,?,?,?,sysdate)");      //카테고리 넘버와 리스트넘버를 사용해서 시퀀스로 글넘버작성    dto 객체에서 내용 아이디 등 입력
			pstmt.setInt(1, dto.getKategorienum());
			pstmt.setInt(2, dto.getListnum());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getConten());
			pstmt.setString(5, dto.getId());
			pstmt.setInt(6, dto.getFilecount());
			pstmt.setInt(7, dto.getImgcount());
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select num from notice"+katenum+"_"+listnum+" where kategorienum = ? and "+
					"listnum = ? and subject = ? and conten = ? and Id = ? and filecount = ? and imgcount = ? order by num desc");
			pstmt.setInt(1, dto.getKategorienum());
			pstmt.setInt(2, dto.getListnum());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getConten());
			pstmt.setString(5, dto.getId());
			pstmt.setInt(6, dto.getFilecount());
			pstmt.setInt(7, dto.getImgcount());
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
	   //게시글이 다른 게시판일때 수정 로그
	   public int editwrite(ContentDTO newsub, int katenum, int listnum, int num) {  
	       int result = 0;                                          
	       ContentDTO ori = new ContentDTO();
	       try {
	           conn = OracleConnection.getConnection();
	           pstmt = conn.prepareStatement("select * from notice"+katenum+"_"+listnum+" where num = ?");
	           pstmt.setInt(1, num);
	           rs = pstmt.executeQuery();
	           if(rs.next()) {
	               ori.setKategorienum(rs.getInt("KATEGORIENUM"));
	               ori.setListnum(rs.getInt("LISTNUM"));
	               ori.setNum(rs.getInt("NUM"));
	               ori.setSubject(rs.getString("SUBJECT"));
	               ori.setConten(rs.getString("CONTEN"));
	               ori.setId(rs.getString("ID"));
	               ori.setGoodnum(rs.getInt("GOODNUM"));
	               ori.setBadnum(rs.getInt("BADNUM"));
	               ori.setCommentcount(rs.getInt("COMMENTCOUNT"));
	               ori.setFilecount(rs.getInt("FILECOUNT"));
	               ori.setImgcount(rs.getInt("IMGCOUNT"));
	               ori.setUpdatecount(rs.getInt("UPDATECOUNT"));
	               ori.setReadcount(rs.getInt("READCOUNT"));
	               ori.setWritedate(rs.getString("writedate"));
	           }
	           pstmt = conn.prepareStatement("insert into editnotice values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	           pstmt.setInt(1, ori.getKategorienum());
	           pstmt.setInt(2, ori.getListnum());
	           pstmt.setInt(3, ori.getNum());
	           pstmt.setString(4, ori.getSubject());
	           pstmt.setString(5, ori.getConten());
	           pstmt.setString(6, ori.getId());
	           pstmt.setInt(7, ori.getGoodnum());
	           pstmt.setInt(8, ori.getBadnum());
	           pstmt.setInt(9, ori.getCommentcount());
	           pstmt.setInt(10, ori.getFilecount());
	           pstmt.setInt(11, ori.getImgcount());
	           pstmt.setInt(12, ori.getUpdatecount());
	           pstmt.setInt(13, ori.getReadcount());

	           // SimpleDateFormat를 사용하여 문자열 형식의 날짜를 java.sql.Timestamp로 변환
	           String dateString = ori.getWritedate();
	           SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	           java.util.Date parsedDate = dateFormat.parse(dateString);
	           java.sql.Timestamp sqlTimestamp = new java.sql.Timestamp(parsedDate.getTime());
	           pstmt.setTimestamp(14, sqlTimestamp);

	           pstmt.executeUpdate();
	           pstmt = conn.prepareStatement("insert into notice"+newsub.getKategorienum()+"_"+newsub.getListnum()
	           + " (kategorienum, listnum, num, subject, conten, id, filecount, imgcount,updatecount,readcount,writedate) "
	           + "    values(?,?,notice"+newsub.getKategorienum()+"_"+newsub.getListnum()+"_seq.nextval,?,?,?,?,?,?,?,?)");
	           pstmt.setInt(1, newsub.getKategorienum());
	           pstmt.setInt(2, newsub.getListnum());
	           pstmt.setString(3, newsub.getSubject());
	           pstmt.setString(4, newsub.getConten());
	           pstmt.setString(5, newsub.getId());
	           pstmt.setInt(6, newsub.getFilecount());
	           pstmt.setInt(7, newsub.getImgcount());
	           pstmt.setInt(8, ori.getUpdatecount() + 1);
	           pstmt.setInt(9, ori.getReadcount());

	           // 현재 날짜를 가져와서 java.sql.Timestamp로 변환하여 설정
	           java.util.Date currentDate = new java.util.Date();
	           java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(currentDate.getTime());
	           pstmt.setTimestamp(10, currentTimestamp);

	           pstmt.executeUpdate();
	           pstmt = conn.prepareStatement("delete from notice"+katenum+"_"+listnum+" where num = ?");
	           pstmt.setInt(1, num);
	           pstmt.executeUpdate();
	           pstmt = conn.prepareStatement("select num from notice"+newsub.getKategorienum()+"_"+newsub.getListnum()
	           +" where kategorienum=? and listnum=? and subject = ? and conten = ? and Id = ?");
	           pstmt.setInt(1, newsub.getKategorienum());
	           pstmt.setInt(2, newsub.getListnum());
	           pstmt.setString(3, newsub.getSubject());
	           pstmt.setString(4, newsub.getConten());
	           pstmt.setString(5, newsub.getId());
	           rs = pstmt.executeQuery();
	           if(rs.next()) {
	               result = rs.getInt(1);         
	           }
	       } catch(Exception e) {
	           e.printStackTrace();
	       } finally {
	           OracleConnection.close(rs, pstmt, conn);
	       }
	       return result;
	   }

	    //게시글 수정이 같은 리스트일때
	   public void editwritechange(ContentDTO newsub) { 
	      ContentDTO ori = new ContentDTO();
	      try {
	         conn = OracleConnection.getConnection();
	         pstmt = conn.prepareStatement("select * from notice"+newsub.getKategorienum()+"_"+newsub.getListnum()+" where num = ?");
	         pstmt.setInt(1, newsub.getNum());
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            ori.setKategorienum(rs.getInt("KATEGORIENUM"));
	            ori.setListnum(rs.getInt("LISTNUM"));
	            ori.setNum(rs.getInt("NUM"));
	            ori.setSubject(rs.getString("SUBJECT"));
	            ori.setConten(rs.getString("CONTEN"));
	            ori.setId(rs.getString("ID"));
	            ori.setGoodnum(rs.getInt("GOODNUM"));
	            ori.setBadnum(rs.getInt("BADNUM"));
	            ori.setCommentcount(rs.getInt("COMMENTCOUNT"));
	            ori.setFilecount(rs.getInt("FILECOUNT"));
	            ori.setImgcount(rs.getInt("IMGCOUNT"));
	            ori.setUpdatecount(rs.getInt("UPDATECOUNT"));
	            ori.setReadcount(rs.getInt("READCOUNT"));
	            ori.setWritedate(rs.getString("WRITEDATE"));
	         }
	         pstmt = conn.prepareStatement("insert into editnotice values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	         pstmt.setInt(1, ori.getKategorienum());
	         pstmt.setInt(2, ori.getListnum());
	         pstmt.setInt(3, ori.getNum());
	         pstmt.setString(4, ori.getSubject());
	         pstmt.setString(5, ori.getConten());
	         pstmt.setString(6, ori.getId());
	         pstmt.setInt(7, ori.getGoodnum());
	         pstmt.setInt(8, ori.getBadnum());
	         pstmt.setInt(9, ori.getCommentcount());
	         pstmt.setInt(10, ori.getFilecount());
	         pstmt.setInt(11, ori.getImgcount());
	         pstmt.setInt(12, ori.getUpdatecount());
	         pstmt.setInt(13, ori.getReadcount());
	         pstmt.setString(14, ori.getWritedate());
	         pstmt.executeUpdate();
	         pstmt = conn.prepareStatement("update notice"+newsub.getKategorienum()+"_"+newsub.getListnum()+" set"            
	               + "   subject=?, conten=?, filecount=?,imgcount=?,updatecount= updatecount+1 where num=?");
	         pstmt.setString(1, newsub.getSubject());
	         pstmt.setString(2, newsub.getConten());
	         pstmt.setInt(3, newsub.getFilecount());
	         pstmt.setInt(4, newsub.getImgcount());
	         pstmt.setInt(5, newsub.getNum());
	         pstmt.executeUpdate();
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally {
	         OracleConnection.close(rs, pstmt, conn);
	      }
	   }
	//같은 리스트일때 게시글의 카운트 넘버 가져오기
	public int edituploadcount(String type,int katenum, int linum, int num ) {
		int count = 0;																
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select countnum from "+type+katenum+"_"+linum+" where num=? order by countnum desc");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
		return count;
	}
	//검색 종류와 검색 단어로 게시글 총 갯수검색			05.23
	public int subj(String search,String searchmenu) {		
		int searchlist = 0;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select TABLE_NAME from tabs where TABLE_NAME like 'NOTICE%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				switch (searchmenu) {
				case "subject":
					sql = "SELECT count(*) FROM "+rs.getString(1)+" WHERE SUBJECT LIKE '%" + search + "%'";
					break;
				case "conten":
					sql = "SELECT count(*) FROM "+rs.getString(1)+" WHERE CONTEN LIKE '%" + search + "%'";
					break;
				case "nick":
					sql = "SELECT count(*) FROM "+rs.getString(1)+" WHERE ID LIKE '%" + search + "%'";
					break;
				case "subject_conten":
					sql = "SELECT count(*) FROM "+rs.getString(1)+" WHERE SUBJECT LIKE '%" + search + "%' OR CONTEN LIKE '%" + search + "%'";
					break;
				default:
					sql = "SELECT count(*) FROM "+rs.getString(1);
					break;
				}
				pstmt = conn.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				if(rs1.next()) {
					searchlist += rs1.getInt(1);
				}
				OracleConnection.close(rs1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			OracleConnection.close(rs,pstmt,conn);
		}
		return searchlist;
	}
	// 검색한 갯수로 게시글 리스트 가져오기
	public List subj_num(String search,String searchmenu,int start, int end) {
		ListDAO listdao = new ListDAO();
		UserDAO userdao = new UserDAO();
		List searchlist_num = null;
		searchlist_num = new ArrayList(end - start);
		sql = "";
		if(searchmenu.equals("nick")) {
			search = userdao.getUserInfo(search).getId();
			searchmenu = "ID";
		}
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select TABLE_NAME from tabs where TABLE_NAME like 'NOTICE%'");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(sql.equals("")) {
					sql ="SELECT kategorienum,"+searchmenu+",listnum,num,writedate FROM "+rs.getString(1)+" ";
				}else {
					sql += " UNION SELECT kategorienum,"+searchmenu+",listnum,num,writedate FROM "+rs.getString(1)+" ";
				}
			}
			if(searchmenu.equals("subject_conten")) {
				sql += " WHERE SUBJECT LIKE '%" + search + "%' OR CONTEN LIKE '%" + search + "%' ";
					
			}else if(searchmenu.equals("subject")||searchmenu.equals("conten")||searchmenu.equals("ID")) {
				sql += ") WHERE "+searchmenu+" LIKE '%"+search+"%' ";
			}else {
				sql ="select * from "+rs.getString(1);
			}
			sql = "select * from (select kategorienum,"+searchmenu+", listnum, num, writedate, rownum r from ("
					+sql + " order by writedate desc) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs1 = pstmt.executeQuery();
			while(rs1.next()) {
				ContentDTO dto = new ContentDTO();
				dto = listdao.content(rs1.getInt("KATEGORIENUM"), rs1.getInt("LISTNUM"), rs1.getInt("NUM"));
				if(dto != null) {
					searchlist_num.add(dto);
				}
			}
			OracleConnection.close(rs1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	
			OracleConnection.close(rs,pstmt,conn);
		}
		return searchlist_num;
	} 
	//아이디로 추천 또는 비추천 여부 확인
	public int gnbnum(ContentDTO dto, String id) {     
		int gnbnum = 0;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select gnb from gnb"+dto.getKategorienum()+"_"+dto.getListnum() +
					" where num=? and id=?");
			pstmt.setInt(1,dto.getNum());
			pstmt.setString(2,id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				gnbnum = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {   
			OracleConnection.close(rs,pstmt,conn);
		}
		return gnbnum;
	}
	//추천 또는 비추천 적용
	public void gnb(ContentDTO dto, String id, int gnb, int gnbcount) {	
		String goodnbad = null;
		if(gnb == 1) {
			goodnbad = "goodnum";
		}else if(gnb == 2) {
			goodnbad = "badnum";
		}
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into gnb"+dto.getKategorienum()+"_"+dto.getListnum()+" values (?,?,?)");
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, id);
			pstmt.setInt(3, gnb);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("update notice"+dto.getKategorienum()+"_"+dto.getListnum()+
					" set "+goodnbad+"=? where num =?");
			pstmt.setInt(1,gnbcount);
			pstmt.setInt(2,dto.getNum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {   
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//추천 또는 비추천 해제
	public void gnbcancel(ContentDTO dto, String id, int gnb, int gnbcount) {		
		String goodnbad = null;
		if(gnb == 1) {
			goodnbad = "goodnum";
		}else if(gnb == 2) {
			goodnbad = "badnum";
		}
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("delete from gnb"+dto.getKategorienum()+"_"+dto.getListnum()+" where num=? and id=? and gnb=?");
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, id);
			pstmt.setInt(3, gnb);
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("update notice"+dto.getKategorienum()+"_"+dto.getListnum()+
					" set "+goodnbad+"=? where num =?");
			pstmt.setInt(1,gnbcount);
			pstmt.setInt(2,dto.getNum());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {   
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//다른 게시판 추천 비추천 이동 
	public void editgnb(int orikatenum, int orilistnum, int orinum, ContentDTO content, int newnum) {      
	      List gnblist = null;                                                   
	      int count = 0;                                                      
	      GnbDTO gnbdto = null;
	      try {
	         conn=OracleConnection.getConnection();
	         pstmt = conn.prepareStatement("select count(*) from gnb"+orikatenum+"_"+orilistnum+" where num=?");
	         pstmt.setInt(1, orinum);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            count = rs.getInt(1);
	         }
	         OracleConnection.close(rs);
	         pstmt = conn.prepareStatement("select * from gnb"+orikatenum+"_"+orilistnum+" where num=?");
	         pstmt.setInt(1, orinum);
	         rs = pstmt.executeQuery();
	         gnblist = new ArrayList(count);
	         while(rs.next()) {
	            gnbdto = new GnbDTO();
	            gnbdto.setNum(rs.getInt("NUM"));
	            gnbdto.setId(rs.getString("ID"));
	            gnbdto.setGnb(rs.getInt("GNB"));
	            gnblist.add(gnbdto);
	         }
	         OracleConnection.close(rs);
	         pstmt = conn.prepareStatement("insert into gnb"+content.getKategorienum()+"_"+content.getListnum()+" values (?,?,?)");
	         for(int i=0; i<gnblist.size(); i++) {
	            gnbdto = (GnbDTO)gnblist.get(i);
	            pstmt.setInt(1, newnum);
	            pstmt.setString(2, gnbdto.getId());
	            pstmt.setInt(3, gnbdto.getGnb());
	            pstmt.executeUpdate();
	         }
	         pstmt = conn.prepareStatement("delete from gnb"+orikatenum+"_"+orilistnum+" where num=?");
	         pstmt.setInt(1, orinum);
	         pstmt.executeUpdate();
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         OracleConnection.close(rs,pstmt,conn);
	      }
	   }
	//게시글의 댓글 갯수 가져오기
	public int commentcount(ContentDTO dto) {		
		int count = 0;
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select count(*) from notice"+dto.getKategorienum()+"_"+dto.getListnum()
			+" n,comment"+dto.getKategorienum()+"_"+dto.getListnum()+" c where n.num=c.num and c.num="+dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
		return count;
	}

	//게시글 댓글갯수만큼 댓글 목록 가져오기
	public List commentlist(int katenum,int listnum,int num,int count) {		
		List commen = null;
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from (select n.*,c.nick from comment"+katenum+"_"+listnum
					+" n,member c where n.id=c.id) where num =? order by commentnum desc");
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			commen = new ArrayList(count);
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setCommentnum(rs.getInt("commentnum"));
				dto.setCommen(rs.getString("commen"));
				dto.setNick(rs.getString("nick"));
				dto.setId(rs.getString("id"));
				dto.setWritedate(rs.getString("writedate"));
				commen.add(dto);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}return commen;
	}
	//게시글에 댓글 추가
	public void addcomment(int katenum, int listnum ,CommentDTO dto) {		
		try {
			conn = OracleConnection.getConnection();
			pstmt = conn.prepareStatement("insert into comment"+katenum+"_"+listnum+
					" values(?,?,?,comment"+katenum+"_"+listnum+"_seq.nextval, ?, ?,0,sysdate)");
			pstmt.setInt(1,katenum);
			pstmt.setInt(2,listnum);
			pstmt.setInt(3,dto.getNum());
			pstmt.setString(4, dto.getCommen());
			pstmt.setString(5,dto.getId());
			pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs, pstmt, conn);
		}
	}
	//댓글 수정 및 로그기록
	public void commentUpdate(String commen,CommentDTO comdto) {						
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("update comment"+comdto.getKategorienum()+"_"+comdto.getListnum() +" set Updatecount=Updatecount+1 where commentnum=? ");
			pstmt.setInt(1, comdto.getCommentnum());
			pstmt.executeUpdate();
			pstmt = conn.prepareStatement("select * from comment"+comdto.getKategorienum()+"_"+comdto.getListnum() +" where commentnum=? ");
			pstmt.setInt(1, comdto.getCommentnum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comdto.setCommen(rs.getString("commen"));
				comdto.setUpdatecount(rs.getInt("updatecount")-1);
				comdto.setId(rs.getString("id"));

				pstmt = conn.prepareStatement("insert into commentUpdateRog values (?,?,?,?,?,?,sysdate,?,?)");
				pstmt.setInt(1, comdto.getKategorienum());
				pstmt.setInt(2, comdto.getListnum());
				pstmt.setInt(3, comdto.getNum());
				pstmt.setInt(4, comdto.getCommentnum());
				pstmt.setString(5, comdto.getCommen());
				pstmt.setInt(6, comdto.getUpdatecount());
				pstmt.setString(7, commen);
				pstmt.setString(8, comdto.getId());
				pstmt.executeUpdate();

				pstmt = conn.prepareStatement("update comment"+comdto.getKategorienum()+"_"+comdto.getListnum() +" set commen=? where commentnum=?");
				pstmt.setString(1, commen);
				pstmt.setInt(2, comdto.getCommentnum());
				pstmt.executeUpdate();
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}
	//댓글 삭제 및 로그기록
	public void commentDelete(CommentDTO comdto) {									
		try {
			conn=OracleConnection.getConnection();
			pstmt = conn.prepareStatement("select * from comment"+comdto.getKategorienum()+"_"+comdto.getListnum() +" where commentnum=? ");
			pstmt.setInt(1, comdto.getCommentnum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comdto.setCommen(rs.getString("commen"));
				comdto.setUpdatecount(rs.getInt("Updatecount"));

				pstmt = conn.prepareStatement("insert into commentDeleteRog values (?,?,?,?,?,?,sysdate)");
				pstmt.setInt(1, comdto.getKategorienum());
				pstmt.setInt(2, comdto.getListnum());
				pstmt.setInt(3, comdto.getNum());
				pstmt.setInt(4, comdto.getCommentnum());
				pstmt.setString(5, comdto.getCommen());
				pstmt.setInt(6, comdto.getUpdatecount());
				pstmt.executeUpdate();

				pstmt = conn.prepareStatement("delete from comment"+comdto.getKategorienum()+"_"+comdto.getListnum() +" where commentnum=?");
				pstmt.setInt(1, comdto.getCommentnum());
				pstmt.executeUpdate();
			}

		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			OracleConnection.close(rs,pstmt,conn);
		}
	}

}
