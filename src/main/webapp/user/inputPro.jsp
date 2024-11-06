<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.*" %>
<%@ page import="web.bean.dto.UserDTO" %>

<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="dto" class="web.bean.dto.UserDTO" />
<jsp:setProperty name="dto" property="*" />

<%
String phone = request.getParameter("phone1")+
            "-"+request.getParameter("phone2")+
            "-"+request.getParameter("phone3");
UserDAO userdao = new UserDAO();
dto.setPhone(phone);

try {
   Integer.parseInt(request.getParameter("phone1"));
   Integer.parseInt(request.getParameter("phone2"));
   Integer.parseInt(request.getParameter("phone3"));
int result = userdao.userInput(dto);
if (result > 0 ) {
%>
<script>
    alert("아이디 혹은 닉네임 중복확인 해주세요.");
    history.go(-1);
</script>
<% } else { %>
<script>
    alert("가입되었습니다");
      self.close();
</script>
<% } 
}catch(Exception e){
   %>
   <script>
   alert("핸드폰 번호는 번호만 입력 가능합니다.");
   history.go(-1);
   </script>   
   <%   
   }
   %>