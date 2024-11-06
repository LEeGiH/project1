<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h1>회원정보 수정</h1>
<jsp:useBean id="userdto" class="web.bean.dto.UserDTO" />
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />

<%
   String id = (String)session.getAttribute("sid");
   userdto = userdao.user(id);
   String[] phones=userdto.getPhone().split("-");
%>
<form action="userUpdatePro.jsp" method="post">
     id : <%=id%> <br />
       <input type="hidden" name="id" value="<%=id%>" />
    pw : <input type="password" name="passwd" value="<%=userdto.getPasswd()%>" /> <br />
    birth : <input type="date" name="birth" value="<%=userdto.getBirth().split(" ")[0]%>"/> <br />
    전화번호 : &nbsp; &nbsp; &nbsp; 
         <input name="phone1" id="phone1" type="number" size="3" maxlength="3" value="<%=phones[0]%>"/> - 
         <input name="phone2" id="phone2" type="number" size="5" maxlength="4" value="<%=phones[1]%>"/> - 
         <input name="phone3" id="phone3" type="number" size="5" maxlength="4" value="<%=phones[2]%>"/><br />
    닉네임 : <input type="text" name="nick" id="nick" value="<%=userdto.getNick()%>"/> <br />
         <input type="submit" value="정보 수정"/>
	
         
</form>