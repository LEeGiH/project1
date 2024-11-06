<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page contentType = "text/html; charset=utf-8" %>
<html>
<head><title>파라미터 출력</title></head>
<body>

name 파라미터 값: <%= request.getParameter("name").toUpperCase() %>

<button onclick="main()">메인페이지</button>
</body>
</html>
<script>
    // 현재 창을 닫는 함수
    function main() {
    	window.opener.location.href = "/project/board/main.jsp";
        window.close();
    }
</script>