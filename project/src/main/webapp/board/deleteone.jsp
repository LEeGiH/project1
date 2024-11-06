<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<script language="JavaScript" src="write.js"></script>
<%
	int katenum = Integer.parseInt(request.getParameter("kategorienum"));
	int linum = Integer.parseInt(request.getParameter("listnum"));
	int num = Integer.parseInt(request.getParameter("num"));
	String fsn = request.getParameter("fsn");
	String isn = request.getParameter("isn");
	FileimgDAO fileimgdao = new FileimgDAO();
	String type="";
	String name="";
	if(fsn == null){
		type= "img";
		name = isn;
	}else{
		type= "file";
		name = fsn;
	}
	fileimgdao.filedeleteOne(katenum, linum, num, name, type);
%>
<script>
	alert("삭제완료");
	opener.location.reload();
	self.close(); 
</script>