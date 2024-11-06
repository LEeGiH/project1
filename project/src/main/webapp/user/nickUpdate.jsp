<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String sid = (String)session.getAttribute("sid");
%>
<form action="nickUpdatePro.jsp" method="post">
변경할 닉네임 : 	<input type="text" name="nick">
	<input type="hidden" name="id" value="<%=sid %>">
	<input type="submit" value="변경">

</form>

