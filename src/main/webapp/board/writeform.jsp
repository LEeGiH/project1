<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.SimpleDateFormat"%>

<jsp:include page="menubar.jsp" flush="true" />
<script language="JavaScript" src="../resources/js/write.js"></script>

<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/write.css">
</head>
<body>
    <div class="write-container">
        <%
            String sid = (String)session.getAttribute("sid");
            if(sid == null){%>
        <script>
            alert("로그인 필요");
            window.location="main.jsp";
        </script>
        <%
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String kategorienum = request.getParameter("kategorienum");
            String listnum = request.getParameter("listnum");
            ListDAO listdao = new ListDAO();
            List katelist = null;
            List listlist = null;
            ListDTO katedto = null;
            ListDTO listdto = null;
            int katecount = 0;
            int listcount = 0;
            int katenum = 0;
            int linum = 0;
            String linames ="";
            katecount = listdao.getKate();
            if(katecount > 0){
                katelist = listdao.kateList(katecount);
            }
        %>
        <form name='form' id="form" action="writePro.jsp" method="post" enctype="multipart/form-data">
            <div class="selection-row">
                <% if(kategorienum == null || kategorienum.equals("null")){
                    kategorienum = "0";
                    listnum = "0";
                %>
                <select name='Step1' onchange='changes1Step(value)'>
                    <option value="0">카테고리 목록</option>
                    <% for(int i = 0; i < katelist.size(); i++){
                        katedto = (ListDTO)katelist.get(i);
                        listcount = listdao.getList(katedto.getKategorienum());
                        if(listcount > 0){
                            listlist = listdao.listList(katedto.getKategorienum(), listcount);
                            for(int j = 0; j < listlist.size(); j++){
                                listdto = (ListDTO)listlist.get(j);
                                if(linames.equals("")){
                                    linames = listdto.getListname();
                                } else {
                                    linames += "," + listdto.getListname();
                                    
                                }
                            }
                            
                    %>
                    <option value="<%=linames %>"><%=katedto.getKategoriename() %></option>
                    <% } linames = ""; } %>
                </select>
                <select name='Step2' id='Step2'>
                    <option value="0" selected>리스트 목록</option>
                </select>
                <% } else {
                    katenum = Integer.parseInt(kategorienum);
                    katedto = listdao.nkate(katenum);
                %> <%=katedto.getKategoriename() %>
                <% if(listnum == null || listnum.equals("null")){
                    listcount = listdao.getList(katenum);
                    if(listcount > 0){
                        listlist = listdao.listList(katenum, listcount);
                %>
                <select name="Step3" id="Step3">
                    <option value="0" selected>리스트 선택</option>
                    <% for(int i = 0; i < listlist.size(); i++){
                        listdto = (ListDTO)listlist.get(i);
                    %>
                    <option value="<%=listdto.getListnum()%>"><%=listdto.getListname() %></option>
                    <% } %>
                </select>
                <% } } else {
                    linum = Integer.parseInt(listnum);
                    listdto = listdao.nlist(katenum, linum);
                %> <%=listdto.getListname() %>
                <% } } %>
            </div>
            <br/>
            <label for="subject">제목:</label>
            <input type="text" name="subject" id="subject"><br/>
            <label for="conten">내용:</label>
            <textarea name="conten" id="conten" rows="10"></textarea><br/>
            <label for="filecount">파일 등록:</label>
            <select name="filecount" id="filecount" onchange='changesfiles(value)'>
                <option value="0">첨부할 파일 갯수 (최대 5개)</option>
                <% for(int i = 1; i <= 5; i++){ %>
                <option value="<%=i%>"> <%=i %> 개</option>
                <% } %>
            </select><br/>
            <div id="thisfilelist"></div>
            <label for="imgcount">사진 등록:</label>
            <select name="imgcount" id="imgcount" onchange='changesimg(value)'>
                <option value="0">이미지 갯수 (최대 5개)</option>
                <% for(int i = 1; i <= 5; i++){ %>
                <option value="<%=i%>"> <%=i %> 개</option>
                <% } %>
            </select>
            <div id="thisimglist"></div>
            <input type="hidden" name="kategorienum" value="<%=kategorienum%>">
            <input type="hidden" name="listnum" value="<%=listnum%>">
            <input type="hidden" name="thisfilenames" id="thisfilenames">
            <input type="hidden" name="thisimgnames" id="thisimgnames"><br/>
            <input type="submit" value="게시글 등록" onclick="names();">
        </form>
    </div>
    <button onclick="history.go(-1);">뒤로가기</button>
</body>
</html>
