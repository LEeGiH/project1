<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<%@ page import = "web.bean.dao.*" %>

 <% 
        // 올바른 비밀번호 설정 (임의로 "password123"으로 설정)
        String correctPassword = "chrlghk";
        ManagerDAO managerdao = new ManagerDAO();
        // 비밀번호가 올바른지 확인
        String inputPassword = request.getParameter("password");
        if (inputPassword != null && inputPassword.equals(correctPassword)) {
            // 올바른 비밀번호인 경우 DAO 다시로드 요청 보내기
            // 여기서는 간단히 alert으로 표시하지만, 필요에 따라 AJAX를 사용하여 서버에 요청을 보낼 수 있습니다.
    %>
            <script>
                alert("비밀번호가 확인되었습니다. 초기화를 진행합니다.");
            </script>
            
    <% 		managerdao.reset();%>
    <script>
    		self.close();
    		opener.window.location='/project/user/logOut.jsp';
	</script>
      <%  } else if (inputPassword != null) {
            // 잘못된 비밀번호인 경우 메시지 표시
    %>
            <p style="color: red;">잘못된 비밀번호입니다. 다시 입력해주세요.</p>
    <% 
        }
    %>
    <h1> 초기화가 진행 됩니다!!!! </h1>
    <form action="" method="post">
        <label for="password">비밀번호:</label>
        <input type="password" id="password" name="password">
        <button type="submit">확인</button>
    </form>
</body>
</html>