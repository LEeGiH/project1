<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dto.UserDTO" %>
<%@ page import="web.bean.dao.UserDAO" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 정보 확인</title>
    <link rel="stylesheet" href="../resources/css/user.css">
</head>
    <jsp:include page="../board/menubar.jsp" flush="true" />
<body class="user-page">
<div class="alluser">
    <div class="user-container">
        <%
            request.setCharacterEncoding("UTF-8");
            String id = (String) session.getAttribute("sid");
            UserDTO userdto = new UserDTO();
            UserDAO userdao = new UserDAO();
            userdto = userdao.user(id);
        %>
        <div class="user-profile-image">
            <img src="/project/user/<%= userdto.getImg() %>" alt="User Image"/>
        </div>
        <button class="user-button" onclick="window.location='imgChange.jsp'">사진 변경</button>
        <div class="user-info">
            <strong>아이디:</strong> <%= userdto.getId() %><br/>
            <strong>이름:</strong> <%= userdto.getUsername() %><br/>
            <strong>닉네임:</strong> <%= userdto.getNick() %><br/>
            <strong>생일:</strong> <%= userdto.getBirth() %><br/>
            <strong>전화번호:</strong> <%= userdto.getPhone() %><br/>
            <strong>성별:</strong> <%= userdto.getSex() %><br/>
            <strong>가입날짜:</strong> <%= userdto.getReg()%><br/>
        </div>
        <div class="user-button-container">
            <button class="user-button" onclick="window.location='userUpdate.jsp'">회원정보 수정</button>
            <button class="user-button" onclick="window.location='userDelete.jsp'">회원탈퇴</button>
        </div>
    </div>
    </div>
</body>
</html>
