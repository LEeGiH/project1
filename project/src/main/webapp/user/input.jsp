<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script language="JavaScript" src="../resources/js/user.js"></script>
    <link rel="stylesheet" href="../resources/css/input.css">
    <title>회원가입</title>
</head>

<body class="user-page">
    <div class="user-container">
        <h1>회원가입</h1>
        <form action="inputPro.jsp" method="post" onsubmit="return writeSave()">
            <div class="form-group">
        <div class="id-input-container">
            <label for="id">아이디:</label>
            <input type="text" name="id" placeholder="아이디를 입력하세요." id="id" required/>
            <button onclick="dupliCheck('id');" type="button" class="dupli-check-button">ID 중복체크</button>
        </div>
    </div>
            <div class="form-group">
                <label for="pw">비밀번호:</label>
                <input type="password" name="passwd" placeholder="비밀번호를 입력하세요." id="pw" required/>
            </div>
            <div class="form-group">
                <label for="pwRe">비밀번호 확인:</label>
                <input type="password" name="passwd" placeholder="비밀번호를 다시 입력하세요." id="pwRe" required/>
            </div>
            <div class="form-group">
                <label>성별:</label>
                <label><input type="radio" name="sex" id="sex" value="남" required/>남자</label>
                <label><input type="radio" name="sex" id="sex" value="여" required/>여자</label>
            </div>
            <div class="form-group">
                <label for="username">이름:</label>
                <input type="text" name="username" id="username" required/>
            </div>
            <div class="form-group">
        <div class="nick-input-container">
            <label for="nick">닉네임:</label>
            <input type="text" name="nick" id="nick" required  placeholder="특수문자는 사용 불가합니다."/>
            <button onclick="dupliCheck('nick');" type="button" class="dupli-check-button">닉네임 중복체크</button>
        </div>
    </div>
            <div class="form-group">
                <label for="birth">생년월일:</label>
                <input type="date" name="birth" id="birth" required/>
            </div>
            <div class="form-group">
                <label for="phone">전화번호:</label>
                <div class="phone-input">
                    <input name="phone1" id="phone1" type="number" maxlength="3" value="010" required/> - 
                    <input name="phone2" id="phone2" type="number" maxlength="4" required/> - 
                    <input name="phone3" id="phone3" type="number" maxlength="4" required/>
                </div>
            </div>
            <div class="user-button-container">
                <input type="submit" value="가입" class="user-button"/>
            </div>
        </form>
    </div>
    <script>
    function dupliCheck(dupli){
        var checkname = document.getElementById(dupli).value;
        open("duplicheck.jsp?" + dupli + "=" + checkname, "", "width=600,height=400");
    }
    </script>
</body>
</html>
