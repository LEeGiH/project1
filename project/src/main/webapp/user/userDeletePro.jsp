<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />
<%@ page import="web.bean.dto.*"%>
<% 
   String id = (String)session.getAttribute("sid");
   String pw = request.getParameter("passwd");
   UserDTO dto = new UserDTO();
   dto.setId(id);
   dto.setPasswd(pw);
   int result = userdao.loginCheck(dto);
   if(result == 1){
	   userdao.userDelete(dto);
%>	   <script>
           alert("계정 탈퇴가 완료되었습니다.");
           window.location="logOut.jsp";
       </script>
<%    }else{
%>	   <script>
            alert("비밀번호를 다시 입력하세요.");
            history.go(-1);
       </script> 
<% } %>

