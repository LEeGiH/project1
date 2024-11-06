<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
	int listresult = 1;
	int kateresult = 1;
	int katenum = Integer.parseInt(request.getParameter("kategorienum"));
	ListDAO listdao = new ListDAO();
	List listlist = null;
	ListDTO katedto = listdao.nkate(katenum);
	ListDTO listdto = null;
	int listcount = 0;
	listcount = listdao.getList(katenum);
	listlist = listdao.listList(katenum, listcount);
	for (int i = 0; i < listlist.size(); i++) {
		listresult = 1;
        listdto = (ListDTO) listlist.get(i);
        listresult = listdao.delList(listdto);
    	if(listresult == 0){
    		listdao.delsub(listdto.getKategorienum(), listdto.getListnum());
    	}
	}
	kateresult = listdao.delKategorie(katedto);
	if(kateresult == 0){
%>	<h3><%=katedto.getKategoriename()%> 삭제 완료</h3>
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


