<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중복 확인</title>
    <link rel="stylesheet" href="../resources/css/duplicheck.css">
</head>
<body>
    <%
        String nick = request.getParameter("nick");
        String id = request.getParameter("id");
        String dupli = "";
        String checkname = "";
        String names = "";
        int result = 0;
        if (nick != null) {
            dupli = "nick";
            checkname = nick;
            names = "닉네임";
        } else if (id != null) {
            dupli = "id";
            checkname = id;
            names = "ID";
        }

        if (checkname.equals("")) {
            result = -1;
        } else {
            result = userdao.duplicheck(dupli, checkname);
        }
    %>
        
    <div class="container">
        <%
            if (result == -1) {
        %>
        <p><%= names %>를 입력해주세요.</p>
        <%
            } else if (id != null && !id.matches("^[a-zA-Z0-9]+$")) {
        %>
        <h2><%= names %>는 영어와 숫자만 사용 가능합니다.</h2>
        <%
            } else if (nick != null && !nick.matches("^[a-zA-Z0-9가-힣]*$")) {
                %>
        <h2><%= names %> 형식에 맞게 작성 해주세요.</h2>
                <%
            } else if (id != null && (id.length() > 8 || id.length() < 4)) {
        %>
        <h2><%= names %>는 4~8 사이로 입력해주세요.</h2>
        <%
            } else if (nick != null && (nick.length() > 8 || nick.length() < 4)) {
        %>
        <h2>[<%= checkname %>]은 4~8 사이로 입력해주세요.</h2>
        <%
            } else if (result == 0) {
        %>
        <h2>[<%= checkname %>] 사용 가능한 <%= names %>입니다.</h2>
        <%
            } else {
        %>
        <h2>[<%= checkname %>] 중복된 <%= names %>입니다.</h2>
        <%
            }
        %>
        <form action="duplicheck.jsp">
            <label for="checkname"><%= names %>:</label>
            <input type="text" name="<%= dupli %>" id="checkname" />
            &nbsp;
            <input type="submit" value="중복 확인" />
        </form>
        <div class="button-container">
            <button onclick="selfClose();">닫기</button>
        </div>
    </div>
    <script>
        function selfClose() {
            opener.document.getElementById("<%= dupli %>").value = "<%= checkname %>";
            self.close();
        }
    </script>
</body>
</html>
