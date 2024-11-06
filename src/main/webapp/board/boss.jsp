<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.dao.*" %>
<%@ page import = "web.bean.dto.*" %>
<button onclick="window.location='/project/board/addKategorie.jsp'">카테고리 추가</button>
<button onclick="window.location='/project/board/addList.jsp'">리스트 추가</button>
<br/>
<button onclick="window.location='/project/board/delKategorie.jsp'">카테고리 삭제</button>
<button onclick="window.location='/project/board/delList.jsp'">리스트 삭제</button>
<br/>
<a href="announcementWrite.jsp">공지사항 작성</a>

<form action="userSearch.jsp" method="post" target="parent" onsubmit="closeCurrentWindow()"> <!-- onsubmit 속성 추가 -->
    회원 닉네임 검색: <br /> <input type="text" autocomplete="off" name="nick"
        placeholder="닉네임을 입력해 주세요." data-keyword="">
    <button type="submit" class="btn-submit">검색</button>
</form>
<% ManagerDAO managerdao = new ManagerDAO();%>
<button onclick="window.location='/project/board/alllllllllllllllldelete.jsp'">주의! 커뮤니티 초기화</button>

<script>
    // 현재 창을 닫는 함수
    function closeCurrentWindow() {
    	window.opener.location.href = "userSearch.jsp";
        window.close();
    }
</script>

<br/>
<a href="announcementWrite2.jsp">에러페이지 404</a>
<br/>
<a href="errorcode500.jsp">에러페이지 500</a>