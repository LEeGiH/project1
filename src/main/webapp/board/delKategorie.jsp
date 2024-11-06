<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>


<%

ListDAO listdao = new ListDAO();
List katelist = null;
ListDTO katedto = null;
int kate = 0;

kate = listdao.getKate();
if(kate > 0){
   katelist = listdao.kateList(kate);
	for (int i = 0; i < katelist.size(); i++) {
    katedto = (ListDTO) katelist.get(i);
%>
<%=katedto.getKategoriename()%> <a href="delKategoriePro.jsp?kategorienum=<%=katedto.getKategorienum()%>">[삭제]</a><br/>
<%	}
}
%>