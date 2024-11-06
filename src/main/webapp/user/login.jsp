<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="../resources/css/login.css">
</head>
<body>

<%
    Cookie [] cookies = request.getCookies();
    String cid = null, cpw = null, cauto = null;
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("cid")){cid=c.getValue();}
            if(c.getName().equals("cpw")){cpw=c.getValue();}
            if(c.getName().equals("cauto")){cauto=c.getValue();}
        }
    }
    if(cid != null && cpw != null && cauto != null){
        response.sendRedirect("loginPro.jsp");
    }
%>

<form action="loginPro.jsp" method="post">
    <label for="id">ID:</label>
    <input type="text" id="id" name="id" required>
    <br>
    <label for="passwd">Password:</label>
    <input type="password" id="passwd" name="passwd" required>
    <br>
    <input type="checkbox" id="auto" name="auto" value="1">
    <label for="auto">자동로그인</label>
    <br>
    <input type="submit" value="Login">
</form>

<div class="links">
    <a href="#" onclick="openWindow('agree.jsp')">회원가입</a>
    <span>|</span>
    <a href="findId.jsp">ID 찾기</a>
    <span>|</span>
    <a href="findPw.jsp">비밀번호 찾기</a>
</div>

<script>
function openWindow(url) {
    window.open(url, 'inputWindow', 'width=600, height=800');
    window.close(); // 현재 창 닫기
}
</script>

</body>
</html>
