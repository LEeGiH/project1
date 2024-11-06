<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <script language="JavaScript" src="/project/resources/js/write.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/write.css">
</head>
<body>
<jsp:include page="menubar.jsp" flush="true" />

<%
    ListDAO listdao = new ListDAO();
    FileimgDAO fileimgdao = new FileimgDAO();
    int num = 0;
    String orikatenum = request.getParameter("orikatenum");
    String orilistnum = request.getParameter("orilistnum");
    String orinum = request.getParameter("orinum");
    int kategorienum = Integer.parseInt(orikatenum);
    int listnum = Integer.parseInt(orilistnum);

    num = Integer.parseInt(orinum);
    ListDTO katedto = listdao.nkate(kategorienum);
    ListDTO listdto = listdao.nlist(kategorienum, listnum);
    ContentDTO subj = listdao.content(kategorienum, listnum, num);
    String subject = request.getParameter("subject");
    String conten = request.getParameter("conten");
    int fcount = subj.getFilecount();
    int icount = subj.getImgcount();
    List filelist = null;
    List imglist = null;
    UploadDTO upload = null;
%>
<input type="text" value="<%=katedto.getKategoriename()%>"
    id="readkate" readonly>
&nbsp; &nbsp;
<input type="text" value="<%=listdto.getListname()%>" id="readlist"
    readonly>
<br />
<input type="button" value="카테고리 변경" onclick="changekate();">
<br />
<form action="editwritepro.jsp" method="post" enctype="multipart/form-data" onsubmit="changelist();" class="write-container">
    <label for="subject">제목:</label>
    <input type="text" name="subject" id="subject" value="<%=subject%>"><br />
    <label for="conten">내용:</label>
    <textarea name="conten" id="conten" rows="8" cols="80"><%=conten%></textarea><br />
    <label for="filecount">파일 등록:</label>
    <select name="filecount" id="filecount" onchange='changesfiles(value)'>
        <option value="0">첨부할 파일 갯수 (최대 5개)</option>
        <% for (int i = 1; i <= 5 - fcount; i++) { %>
            <option value="<%=i%>"><%=i%> 개</option>
        <% } %>
    </select><br />
    <div id="thisfilelist"></div>
    <br />
    <% if (fcount > 0) { %>
        <p>첨부파일 목록 :</p>
        <% filelist = fileimgdao.uploadlist(subj, "file");
        for (int i = 0; i < fcount; i++) {
            upload = (UploadDTO) filelist.get(i); %>
            <p><a href="/project/board/content/<%=upload.getSystemname()%>"><%=upload.getOriginalname()%></a>
            <a href='deleteone.jsp?kategorienum=<%=orikatenum%>&listnum=<%=orilistnum%>&num=<%=orinum%>&fsn=<%=upload.getSystemname()%>'
            onclick="window.open(this.href, '_blank', 'width=600, height=400'); return false;">[삭제]</a></p>
        <% } %>
    <% } %><br />
    <label for="imgcount">사진 등록:</label>
    <select name="imgcount" id="imgcount" onchange='changesimg(value)'>
        <option value="0">이미지 갯수 (최대 5개)</option>
        <% for (int i = 1; i <= 5 - icount; i++) { %>
            <option value="<%=i%>"><%=i%> 개</option>
        <% } %>
    </select><br />
    <div id="thisimglist"></div>
    <br />
    <% if (icount > 0) {
        imglist = fileimgdao.uploadlist(subj, "img");
        for (int i = 0; i < icount; i++) {
            upload = (UploadDTO) imglist.get(i); %>
        <img src="/project/board/content/<%=upload.getSystemname()%>" width="150" height="150">
        <a href='deleteone.jsp?kategorienum=<%=orikatenum%>&listnum=<%=orilistnum%>&num=<%=orinum%>
                &isn=<%=upload.getSystemname()%>'
            onclick="window.open(this.href, '_blank', 'width=600, height=400'); return false;">[삭제]</a>
        <br />
        <% }
    } %>
    <input type="hidden" name="orikatenum" value="<%=orikatenum%>">
    <input type="hidden" name="orilistnum" value="<%=orilistnum%>">
    <input type="hidden" name="orinum" value="<%=orinum%>">
    <input type="hidden" name="thisfilenames" id="thisfilenames"> 
    <input type="hidden" name="thisimgnames" id="thisimgnames">
    <input type="hidden" name="changelistname" id="changelistname">
    <input type="submit" value="게시글 수정" class="submit-button">
</form>

<button onclick="history.go(-1);">뒤로가기</button>
<button onclick="window.location='main.jsp'">메인으로</button>
</body>
</html>
