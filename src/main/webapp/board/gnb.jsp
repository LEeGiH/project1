<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>

<%
String sid = (String)session.getAttribute("sid");
	int kategorienum = Integer.parseInt(request.getParameter("kategorienum"));
	int listnum = Integer.parseInt(request.getParameter("listnum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int gnb = Integer.parseInt(request.getParameter("gnb"));
	int gnbcount = 0;
	BoardDAO boarddao = new BoardDAO();
	ListDAO listdao = new ListDAO();
	String goodnbad = "";
	String cancel = "";
	ContentDTO content = listdao.content(kategorienum, listnum, num);
	int gnbnum = boarddao.gnbnum(content, sid);
	if(gnb == 1){
		gnbcount = content.getGoodnum();
		goodnbad = "추천";
	}else if(gnb == 2){
		gnbcount = content.getBadnum();
		goodnbad = "비추천";
	}
	
	if(gnbnum != 0){
		boarddao.gnbcancel(content, sid, gnb, gnbcount -1);
		cancel = "취소";
	}else{
		boarddao.gnb(content, sid, gnb, gnbcount +1);
	}
%>
<script>
	alert("<%=goodnbad%>" + " <%=cancel%>"+" 완료");
	window.location="content.jsp?kategorienum=<%=kategorienum%>&listnum=<%=listnum%>&num=<%=num%>";
</script>