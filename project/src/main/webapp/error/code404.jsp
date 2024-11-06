<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page isErrorPage = "true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>요청하신 페이지를 찾을수없습니다.</title>
</head>
<body>

요청 하신 페이지를 찾을 수 없습니다.<br>

<p> </p>

<button onclick="main()">메인으로</button>
<button onclick="back()">뒤로가기</button>
</body>
</html>

<script>
    // 현재 창을 닫는 함수
    function main() {
    	window.opener.location.href = "/project/board/main.jsp";
        window.close();
    }    
    function back() {
        history.go(-1);
    }
</script>