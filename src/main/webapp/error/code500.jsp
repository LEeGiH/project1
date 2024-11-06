<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page isErrorPage = "true" %>
<html>
<head><title>에러 발생</title></head>
<body>

요청 처리 과정에서 에러가 발생하였습니다.<br>
빠른 시간 내에 문제를 해결하도록 하겠습니다.

<p>코드오류 500

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