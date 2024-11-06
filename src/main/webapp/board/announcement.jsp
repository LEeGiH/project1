<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "web.bean.dao.*" %>
<%@ page import = "web.bean.dto.*" %>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<jsp:include page="menubar.jsp" flush="true" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="../resources/css/list.css">
</head>
<body>
    <div class="container">
        <h1 class="category-title">공지사항</h1>
        <div class="results">
            <%
                String sid = (String)session.getAttribute("sid");
                String annonum = request.getParameter("annonum");
                ManagerDAO managerdao = new ManagerDAO();
                UserDAO userdao = new UserDAO();
                UserDTO user = userdao.user(sid);
                int count = managerdao.anno();
                List annoList = null;
                int grade = 0;
                int num = 0;
                if (sid != null) {
                    grade = user.getGrade();
                }

                if (count == 0) {
            %>
            <h3>현재 공지사항이 없습니다.</h3>
            <%
                } else {
                    annoList = managerdao.annoList(count);
                    if (annonum == null) {
                        for (int i = 0; i < annoList.size(); i++) {
                            AnnouncementDTO dto = (AnnouncementDTO) annoList.get(i);
            %>
            <ul class="post-list">
                <li class="post-item">
                    <a href="announcement.jsp?annonum=<%= dto.getNum() %>" class="post-link">
                        <span>제목: <%= dto.getSubject() %></span>
                    </a>
                </li>
            </ul>
            <%
                        }
                    } else {
                        num = Integer.parseInt(annonum);
                        AnnouncementDTO dto = managerdao.anno(num);
            %>
            <div class="announcement-detail">
                <h2 class="post-title">제목: <%= dto.getSubject() %></h2>
                <p class="post-content">내용: <%= dto.getConten() %></p>
                <p class="post-date">작성일시: <%= dto.getCrdate() %></p>
            </div>
            <%
                    }
                }
                if (grade == 3) {
            %>
            <button onclick="announcementWrite()" class="button">공지사항 추가</button>
            <%
                }
            %>
        </div>
    </div>
</body>
</html>

<script>
function announcementWrite(){   
	open("announcementWrite.jsp","","width=600,height=400");
}
</script>
