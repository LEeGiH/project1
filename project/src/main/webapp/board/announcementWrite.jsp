<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.*" %>
<%@ page import="web.bean.dto.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 작성</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/write.css">
</head>
<body>
<%
    String sid = (String)session.getAttribute("sid");
    UserDAO userdao = new UserDAO();
    UserDTO user = new UserDTO();
    user = userdao.user(sid);
    int grade = 0;
    if(sid != null){
        grade = user.getGrade();
    } else { %>
        <script>
            alert("관리자만 가능합니다");
            history.go(-1);
        </script>
<% } 

    if(grade == 3) { %>
        <form id="annoForm" action="annoPro.jsp" method="post">
            제목: <input type="text" name="subject"><br/>
            내용: <input type="text" name="conten"><br/>
            <input type="submit" value="입력">
        </form>
<% } %>
<script>
    // 창 닫기 함수
    function closeWindow() {
        window.close();
    }
</script>
</body>
</html>
