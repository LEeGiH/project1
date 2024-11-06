<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO"/>
<link rel="stylesheet" href="../resources/css/find.css">
<%
    String username = request.getParameter("username");
    String phone = request.getParameter("phone");
    String id = userdao.findId(username, phone);
    if(id != null){
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 결과</title>
    <link rel="stylesheet" href="../resources/css/result.css">
</head>
<body>
    <div class="container">
        <h2>아이디 찾기 결과</h2>
        <p>회원님의 아이디는: <%= id %></p>
      
    <a href="login.jsp">로그인</a>
    <span>|</span>
    <a href="findPw.jsp">비밀번호 찾기</a>
    </div>
    
</body>
</html>
<%
    } else {
%>
<script>
    alert("입력하신 정보와 일치하는 아이디가 없습니다.");
    history.go(-1);
</script>
<%
    }
%>
