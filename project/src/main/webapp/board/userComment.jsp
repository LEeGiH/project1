<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%request.setCharacterEncoding("UTF-8");%>

<%	
	String id = request.getParameter("id");
	String pagenum = request.getParameter("pagenum");
	if(pagenum == null){
		pagenum = "1";
	}
    BoardDAO boarddao = new BoardDAO();
    ListDAO listdao = new ListDAO();
	int thispage = Integer.parseInt(pagenum);
	int pagesize = 10;
	int liststart = (thispage - 1) * pagesize + 1;
	int listend = thispage * pagesize;
	int userCommentCount = boarddao.com_num(id);
	
	List userCommentList = boarddao.comen_num(id,liststart,listend);
	
	for(int i = 0; i<userCommentList.size(); i++){
		CommentDTO comment = (CommentDTO)userCommentList.get(i);
%>
		<a href="/project/board/list.jsp?kategorienum=<%=comment.getKategorienum()%>&listnum=<%=comment.getListnum()%>"
		onclick="opener.location.href=this.href; return false;">
		[<%=listdao.nlist(comment.getKategorienum(), comment.getListnum()).getListname() %>]</a>
		<a href="/project/board/content.jsp?kategorienum=<%=comment.getKategorienum()%>&listnum=<%=comment.getListnum()%>&num=<%=comment.getNum()%>"
		onclick="opener.location.href=this.href; return false;">
		<%=comment.getCommen()%></a><br/>
<%		
	}
    if (userCommentCount > 0) {
        int pageCount = userCommentCount / pagesize + ( userCommentCount % pagesize == 0 ? 0 : 1);
        int startPage = (int)(thispage/pagesize)*pagesize+1;
		int pageBlock=pagesize;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        if (startPage > pagesize) {    
%>
			<a href="/project/board/userComment.jsp?id=<%=id%>&pagenum=<%= startPage - 10 %>">[이전]</a>
<%					}
        for (int i = startPage ; i <= endPage ; i++) {  %>
			<a href="/project/board/userComment.jsp?id=<%=id%>&pagenum=<%= i %>">[<%= i %>]</a>
<%
        }
        if (endPage < pageCount) {  %>
			<a href="/project/board/userComment.jsp?id=<%=id%>&pagenum=<%= startPage + 10 %>">[다음]</a>
<%
        }
    }
%>
<button onclick="self.close();">닫기</button>