<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="java.util.List"%>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../resources/css/remote.css">
</head>
<body>
<%
   ListDAO listdao = new ListDAO();
   UserDAO userdao = new UserDAO();
   List katelist = null;
   List listlist = null;
   ListDTO katedto = null;
   ListDTO listdto = null;
   int kate = 0;
   int katenum = 0;
   int listcount = 0;
%>

<%
   kate = listdao.getKate();
   if(kate > 0){
      katelist = listdao.kateList(kate);
%>
<div class="overallKategorie">
<button class="control">모두보기</button><br/>
<div class="choiceKategorie">
<% for (int i = 0; i < katelist.size(); i++) {
       katedto = (ListDTO) katelist.get(i);
       katenum = katedto.getKategorienum();
       listcount = listdao.getList(katenum);
       listlist = listdao.listList(katenum, listcount);
%>
    <div class="KategorieNumber<%= katedto.getKategorienum() %> Kategories">
        <a href="/project/board/list.jsp?kategorienum=<%= katedto.getKategorienum() %>"><%= katedto.getKategoriename() %></a>
        <div class="selectlists">
            <% for (int j = 0; j < listlist.size(); j++) {
                   listdto = (ListDTO) listlist.get(j);
            %>
            <a href="/project/board/list.jsp?kategorienum=<%= katenum %>&listnum=<%= listdto.getListnum() %>"><%= listdto.getListname() %></a><br/>
            <% } %>
        </div>
    </div>
<% } %>
</div>
</div>
<%}%>
</body>
<script src="../resources/js/jquery-1.12.4.js"></script>
<script>
$('.control').click(function() {
    $('.choiceKategorie').slideToggle();
    var buttonText = $(this).text();
    if (buttonText === "모두보기") {
        $(this).text("닫기");
    } else {
        $(this).text("모두보기");
    }
});
</script>
