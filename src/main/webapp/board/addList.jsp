<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%
	String katenum = request.getParameter("kategorienum");
%>
<form action="addListPro.jsp" method="post">
<%
	if(katenum == null){
		ListDAO listdao = new ListDAO();
		int katecount = listdao.getKate();
		List katelist = new ArrayList();
		katelist = listdao.kateList(katecount);
%>
	<select name="kategorienum">
		<option value="0">카테고리 선택</option>
<%
		for(int i = 0; i<katelist.size(); i++){
			ListDTO listdto = (ListDTO)katelist.get(i);
%>
			<option value="<%=listdto.getKategorienum()%>"><%=listdto.getKategoriename() %></option>
<%			
		}
%>	
	</select><br/>
<%		
	}else{
		int kategorienum = Integer.parseInt(katenum);
%>
	<input type="hidden" name="kategorienum" value="<%=kategorienum %>"/>
<%
	} 
%>
	<input type="text" name="listname"/>
	<input type="submit" value ="추가">
</form>



