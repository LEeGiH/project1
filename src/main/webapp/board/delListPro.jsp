<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>

<%
	int result = 1;
	String katenum= request.getParameter("kategorienum");
	String linum = request.getParameter("listnum");
	String Step2 = request.getParameter("Step2");
	String Step1 = request.getParameter("Step1");
	ListDAO listdao = new ListDAO();
	ListDTO listdto = new ListDTO();
	if(Step2 != null){
		listdto = listdao.searchlist(Step2);
	}else if(katenum != null && linum != null){
		listdto = listdao.nlist(Integer.parseInt(katenum),Integer.parseInt(linum));
	}
	result = listdao.delList(listdto);
	if(result == 0){
		listdao.delsub(listdto.getKategorienum(), listdto.getListnum());
%>	<h3><%=listdto.getListname()%> 삭제 완료</h3>
		<button onclick="bosspage()">관리자 페이지로</button>
		<button onclick="selfClose()">닫기</button>
<%	}
%>
<script>
	function selfClose(){
		self.close();
		opener.window.location='/project/board/listkategorienum.jsp?kategorienum'+<%=katenum%>;
	}	
	function bosspage(){
		window.location='/project/board/boss.jsp';
		opener.window.location='/project/board/listkategorienum.jsp?kategorienum'+<%=katenum%>;
	}
</script>