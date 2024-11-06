<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%request.setCharacterEncoding("UTF-8"); %>   
<%
	String nick = request.getParameter("nick");
%>


<form action="selectGradePro.jsp">
	<select name="grade">
		<option value="0">제제회원</option>
		<option value="1">일반회원</option>
		<option value="2">관리자</option>
	</select>
	<input type="hidden" name="nick" value="<%=nick %>">
	<input type= "submit" value="변경">
</form>