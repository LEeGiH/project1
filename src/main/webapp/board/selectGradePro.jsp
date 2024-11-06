<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "web.bean.dao.*" %>
  
<%
String nick = request.getParameter("nick");
int grade = Integer.parseInt(request.getParameter("grade"));

ManagerDAO managerdao = new ManagerDAO();
managerdao.changeGrade(nick, grade);

%>

<script>
	alert("변경되었습니다");
	window.location="userSearch.jsp?nick=<%=nick%>";
</script>