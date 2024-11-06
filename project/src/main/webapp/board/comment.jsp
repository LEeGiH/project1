<%@page import="org.apache.catalina.ant.jmx.JMXAccessorQueryTask"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="web.bean.dto.CommentDTO" />
<jsp:useBean id="dao" class="web.bean.dao.BoardDAO" />

<%
String sid = (String)session.getAttribute("sid");
String commen = request.getParameter("commen");
int kategorienum = Integer.parseInt(request.getParameter("kategorienum"));
int listnum = Integer.parseInt(request.getParameter("listnum"));
int num = Integer.parseInt(request.getParameter("num"));

if(commen == ""){
	%> 
	<script>
	alert("내용을 입력해주세요.");
	history.go(-1);
	</script> <%
}else{
	if (sid != null){
	dto.setNum(num);
	dto.setCommen(commen);
	dto.setId(sid);
	dao.addcomment(kategorienum, listnum, dto);
%> 
<script>
alert("댓글 등록.");
window.location="/project/board/content.jsp?kategorienum=<%=kategorienum %>&listnum=<%=listnum%>&num=<%=num %>";
</script>

<%}else {
	%> 
	<script>
	alert("로그인 이후 이용 가능합니다");
	history.go(-1);
	</script> <%
	
} 
	
}
%>
