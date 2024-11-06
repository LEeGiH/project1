<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<script language="JavaScript" src="write.js"></script>

<%	
ListDAO listdao = new ListDAO();
ListDTO listdto = null;
ListDTO katedto = null;
List katelist = null;
List listlist = null;
int katecount = 0;
int listcount = 0;
int katenum = 0;
int linum = 0;
String linames ="";
katecount = listdao.getKate();
if(katecount > 0){
	katelist = listdao.kateList(katecount);
} %>

<form name='form' id ="form" action="writePro.jsp" method="post" enctype="multipart/form-data">
	<select name='Step1' id='Step1' onchange='changes1Step(value)'>
				<option value="0" >카테고리 목록</option>
<%				for(int i = 0; i< katelist.size();i++){
					katedto = (ListDTO)katelist.get(i);
					listcount = listdao.getList(katedto.getKategorienum());
					if(listcount>0){
						listlist = listdao.listList(katedto.getKategorienum(), listcount);
						for(int j =0; j<listlist.size();j++){
							listdto = (ListDTO)listlist.get(j);
							if(linames.equals("")){
								linames = listdto.getListname();
							}else{
								linames += ","+listdto.getListname();
							}
						}
%>						<option value="<%=linames %>"><%=katedto.getKategoriename() %></option>
<%					}
					linames = "";
				}
%>	</select> 
	<select name='Step2' id='Step2'>
		<option value="0" selected>리스트 목록</option>
	</select>
</form>

<input type="button" value="카테고리 변경" onclick="selectchange();">