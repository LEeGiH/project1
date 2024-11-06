<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>

<%
	String listname = request.getParameter("listname");
	int katenum = Integer.parseInt(request.getParameter("kategorienum"));

	ListDAO lsitdao = new ListDAO();
	int listnum = lsitdao.listch(katenum) + 1;
	ListDTO dto = new ListDTO();
	dto.setKategorienum(katenum);
	dto.setListnum(listnum);
	dto.setListname(listname);
	lsitdao.addList(dto);
	lsitdao.addsub(katenum, listnum);
%>		<h3><%=listname %> 리스트 추가</h3>
		<button onclick="bosspage()">관리자 페이지로</button>
		<button onclick="selfClose()">닫기</button>


<%	
%>
<script>
	function selfClose(){
		self.close();
		opener.window.location='/project/board/list.jsp?kategorienum=<%=katenum%>';
	}
	function bosspage(){
		window.location='/project/board/boss.jsp';
		opener.window.location='/project/board/list.jsp?kategorienum=<%=katenum%>';
	}
</script>


