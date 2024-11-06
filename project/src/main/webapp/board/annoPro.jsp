<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.dao.*" %>
<%@ page import = "web.bean.dto.*" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	String subject = request.getParameter("subject");
	String conten = request.getParameter("conten");
	AnnouncementDTO dto = new AnnouncementDTO();
	dto.setSubject(subject);
	dto.setConten(conten);
	ManagerDAO managerdao = new ManagerDAO();
	managerdao.annowrite(dto);
	%>
<script >
	alert("공지사항 등록 완료");
	self.close();
</script>
