<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <script language="JavaScript" src="../resources/js/find.js"></script>
    <link rel="stylesheet" href="../resources/css/find.css">
</head>
<body>

<div class="form-container">
    <form action="findPwPro.jsp" method="get" onsubmit="return findpw()">
        <div class="form-group">
            <label for="id"><span class="required">*</span>아이디:</label>
            <input type="text" id="id" name="id" placeholder="아이디를 입력하세요." required>
        </div>

        <div class="form-group">
            <label for="phone"><span class="required">*</span>전화번호:</label>
            <input name="phone1" id="phone1" type="number" size="3" maxlength="3" value="010"/> -
            <input name="phone2" id="phone2" type="number" size="5" maxlength="4" /> -
            <input name="phone3" id="phone3" type="number" size="5" maxlength="4" />
        </div>

        <p class="required-note">*표시된 항목은 필수로 입력해야하는 항목입니다.</p>
        <input type="submit" value="비밀번호 찾기" class="submit-button">
    </form> 
    <a href="login.jsp">로그인</a>
    <span>|</span>
    <a href="findId.jsp">아이디 찾기</a>
</div>
    

</body>
</html>
