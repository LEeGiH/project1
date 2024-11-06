<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO"/>
<link rel="stylesheet" href="../resources/css/find.css">
<%
    String id = request.getParameter("id");
    String phone = request.getParameter("phone");
    String pw = userdao.findpw(id, phone);
    if(pw != null){
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기 결과</title>
    <link rel="stylesheet" href="../resources/css/result.css">
</head>
<body>
    <div class="container">
        <h2>비밀번호 찾기 결과</h2>
        <p>회원님의 비밀번호는: <%=pw%></p>
      
    <a href="login.jsp">로그인</a>
    <span>|</span>
    <a href="findId.jsp">아이디 찾기</a>
    </div>
    
</body>
</html>
<%
    } else {
%>
<script>
    alert("입력하신 정보와 일치하는 정보가 없습니다.");
    history.go(-1);
</script>
<%
    }
%>
      