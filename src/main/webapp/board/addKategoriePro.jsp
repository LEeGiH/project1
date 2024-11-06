<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>

<%
	String katename = request.getParameter("katename");
%>
<%
	ListDAO listdao = new ListDAO();
	int katecheck = listdao.checkkate(katename);
	if(katecheck == 0){
		listdao.addkate(katename);
%>		<h3><%=katename %> 카테고리 추가</h3>
		<button onclick="bosspage()">관리자 페이지로</button>
		<button onclick="selfClose()">닫기</button>


<%	}	
%>
<script>
	function selfClose(){
		self.close();
		opener.window.location='/project/board/main.jsp';
	}	
	function bosspage(){
		window.location='/project/board/boss.jsp';
		opener.window.location='/project/board/main.jsp';
	}
</script>
