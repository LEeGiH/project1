<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet"  href="../resources/css/main.css">
    <title>게시판</title>
</head>



<div class="main1block">
<div class="log">
<a href="/project/board/main.jsp"><img src="/project/resources/image/log.png" width="287px" height="70px" ></a>
</div>
<div class="list Search">
    <form action="/project/board/search.jsp">
        <select name="searchmenu">
            <option value="subject">제목</option>
            <option value="content">게시글</option>
            <option value="nick">닉네임</option>
            <option value="subject_content">제목&게시글</option>
        </select>
        <input type="text" name="search" />
        <input type="submit" value="검색" />
    </form>
</div>
</div>
<body class="main-body">

<%
   String sid = (String)session.getAttribute("sid");
   String kategorienum = request.getParameter("kategorienum");
   String listnum = request.getParameter("listnum");
   ListDAO listdao = new ListDAO();
   UserDAO userdao = new UserDAO();
   List katelist = null;
   List listlist = null;
   ListDTO katedto = null;
   ListDTO listdto = null;
   int kate = 0;
   int katenum =0;
   int listcount = 0;
   int grade = 0;
%>

<div class="loginBlock">

<%
   if(sid == null){%>
<button onclick="login()">로그인</button>
<button onclick="input()">회원가입</button>
<%   }else{%>
<button onclick="window.location='/project/user/logOut.jsp'">로그아웃</button>
<button onclick="window.location='/project/board/main.jsp'">메인페이지</button>
<button onclick="window.location='/project/board/writeform.jsp?kategorienum=<%=kategorienum%>&listnum=<%=listnum%>'">글쓰기</button>
<%   
	UserDTO userdto = userdao.user(sid);
	
	grade = userdto.getGrade();
   
%>
<button onclick="window.location='/project/board/announcement.jsp'">공지사항</button>
<%if(grade == 3){
    %>
    <button onclick="boss()">보스페이지</button>
<%}%>

<a href="/project/board/userSearch.jsp?nick=<%=userdto.getNick() %>">[<%=userdto.getNick() %>]</a>
  <% }
%>
</div>
<%
   kate = listdao.getKate();
   if(kate > 0){
      katelist = listdao.kateList(kate);
%>

<jsp:include page="remote.jsp" flush="true" />
<div class="allKategorie">
<button class="scroll-left"></button>
<div class="selectKategorie">
<% for (int i = 0; i < katelist.size(); i++) {
       katedto = (ListDTO) katelist.get(i);
       katenum = katedto.getKategorienum();
       listcount = listdao.getList(katenum);
       listlist = listdao.listList(katenum, listcount);
%>
    <div class="Kategorie<%= katedto.getKategorienum() %> Kategorie">
        <a href="/project/board/list.jsp?kategorienum=<%= katedto.getKategorienum() %>"><%= katedto.getKategoriename() %></a>
        </div>
<% } %>
</div>
<button class="scroll-right"></button>
</div>
<%   }else if(kate == 0 ){
%>
<h3>글이 없음</h3>
<%   }%>

<script>
    function boss(){
        open("/project/board/boss.jsp", "보스페이지", "width=600, height=400");
    }
    function login(){
        open("/project/user/login.jsp", "로그인", "width=600, height=400");
    }
    function input(){
    	open("/project/user/agree.jsp","사전동의" , "width=600, height=800");
    }
</script>

<script src="../resources/js/jquery-1.12.4.js"></script>

<script>
$(document).ready(function() {
    // 오른쪽으로 스크롤
    $('.scroll-right').on('click', function() {
        $('.selectKategorie').animate({
            scrollLeft: '+=200' // 200px 만큼 오른쪽으로 스크롤
        }, 500);
    });

    // 왼쪽으로 스크롤
    $('.scroll-left').on('click', function() {
        $('.selectKategorie').animate({
            scrollLeft: '-=200' // 200px 만큼 왼쪽으로 스크롤
        }, 500);
    });
});

</script>
</body>
</html>
