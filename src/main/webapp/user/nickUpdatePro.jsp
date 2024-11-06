<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.*" %>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />


<%
	String id = request.getParameter("id");
	String aftnick = request.getParameter("nick");
	UserDTO userdto = userdao.user(id);
	int updatenum = userdao.changeNick(userdto);
	int afterupdatenum = updatenum +1;
	userdao.updatenick(userdto,aftnick,afterupdatenum);
%>

<script>
	alert("변경완료")
	window.location='user.jsp';
</script>
