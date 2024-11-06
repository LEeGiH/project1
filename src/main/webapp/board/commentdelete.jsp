<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "web.bean.dao.BoardDAO" %>
<%@ page import = "web.bean.dto.CommentDTO" %>
<% 
int kategorienum = Integer.parseInt(request.getParameter("kategorienum"));
int listnum = Integer.parseInt(request.getParameter("listnum"));
int num = Integer.parseInt(request.getParameter("num"));
int commentnum = Integer.parseInt(request.getParameter("commentnum"));
String commen = request.getParameter("commentUpdate");


BoardDAO boarddao = new BoardDAO();
CommentDTO comdto = new CommentDTO();
comdto.setKategorienum(kategorienum);
comdto.setListnum(listnum);
comdto.setNum(num);
comdto.setCommentnum(commentnum);
boarddao.commentDelete(comdto);
%>
<script>
	alert("수정 완료");
		window.location="content.jsp?kategorienum=<%=kategorienum%>&listnum=<%=listnum%>&num=<%=num%>";
	</script>