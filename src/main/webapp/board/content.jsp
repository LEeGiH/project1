<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>

<jsp:include page="menubar.jsp" flush="true" />

<link rel="stylesheet" type="text/css" href="../resources/css/content.css">
<%
String sid = (String) session.getAttribute("sid");
int kategorienum = Integer.parseInt(request.getParameter("kategorienum"));
int listnum = Integer.parseInt(request.getParameter("listnum"));
int num = Integer.parseInt(request.getParameter("num"));
ListDAO listdao = new ListDAO();
FileimgDAO flieimgdao = new FileimgDAO();
BoardDAO boarddao = new BoardDAO();
UserDAO userdao = new UserDAO();
ContentDTO dto = new ContentDTO();
UserDTO writer = new UserDTO();
UserDTO user = new UserDTO();
List comment = null;
List filelist = null; // 05.09 성진 추가
List imglist = null; // 05.09 성진 추가
UploadDTO upload = null; // 05.12 성진 수정
String filenamelist = ""; // 05.10 성진 추가
String imgnamelist = ""; // 05.10 성진 추가
CommentDTO comdto = null;
dto = listdao.readcontent(kategorienum, listnum, num);
String writerid = dto.getId();
writer = userdao.user(writerid);
int gnb = boarddao.gnbnum(dto, sid);

if (dto != null) {
%>
<div class="container">
    <h1>제목 : <%=dto.getSubject() %></h1>

    <h3>작성자 : <a href="userSearch.jsp?nick=<%=writer.getNick() %>"><%=writer.getNick() %></a></h3>

    <h2>내용 : <%=dto.getConten() %></h2>

    <div class="attachment-list">
        <% 
        if (dto.getFilecount() > 0) {
            filelist = flieimgdao.uploadlist(dto, "file");
            for (int i = 0; i < filelist.size(); i++) {
                upload = (UploadDTO) filelist.get(i);
        %>
        <a href="/project/board/content/<%=upload.getSystemname() %>"><%=upload.getOriginalname() %></a>
        <br />
        <% }
            } %>
    </div>

    <div class="image-list">
        <% if (dto.getImgcount() > 0) {
            imglist = flieimgdao.uploadlist(dto, "img");
            for (int i = 0; i < imglist.size(); i++) {
                upload = (UploadDTO) imglist.get(i);
        %>
        <img src="/project/board/content/<%=upload.getSystemname() %>" width="" height="" />
        <br />
        <% }
            } %>
    </div>

    <p>추천수 <%=dto.getGoodnum() %></p>
    <p>비추천수 <%=dto.getBadnum() %></p>
	<p>조회수 <%=dto.getReadcount() %></p>
    <div class="vote-buttons">
        <% if (sid != null) {
            if (gnb == 1) { %>
        <form action="gnb.jsp" method="post">
            <input type="hidden" name="kategorienum" value="<%=kategorienum%>">
            <input type="hidden" name="listnum" value="<%=listnum%>">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="gnb" value="1">
            <input type="submit" value="추천취소">
        </form>
        <% } else if (gnb == 2) { %>
        <form action="gnb.jsp" method="post">
            <input type="hidden" name="kategorienum" value="<%=kategorienum%>">
            <input type="hidden" name="listnum" value="<%=listnum%>">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="gnb" value="2">
            <input type="submit" value="비추천 취소">
        </form>
        <% } else { %>
        <form action="gnb.jsp" method="post">
            <input type="hidden" name="kategorienum" value="<%=kategorienum%>">
            <input type="hidden" name="listnum" value="<%=listnum%>">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="gnb" value="1">
            <input type="submit" value="추천">
        </form>
        <form action="gnb.jsp" method="post">
            <input type="hidden" name="kategorienum" value="<%=kategorienum%>">
            <input type="hidden" name="listnum" value="<%=listnum%>">
            <input type="hidden" name="num" value="<%=num%>">
            <input type="hidden" name="gnb" value="2">
            <input type="submit" value="비추천">
        </form>
        <% }
            if (writerid.equals(sid)) { %>
        <div class="edit-button">
            <form action="editwriteform.jsp" method="post">
                <input type="hidden" name="orikatenum" value="<%=kategorienum%>">
                <input type="hidden" name="orilistnum" value="<%=listnum%>">
                <input type="hidden" name="orinum" value="<%=num%>">
                <input type="hidden" name="subject" value="<%=dto.getSubject() %>">
                <input type="hidden" name="conten" value="<%=dto.getConten() %>">
                <input type="hidden" name="fnames" value="<%=filenamelist %>">
                <input type="hidden" name="inames" value="<%=imgnamelist %>">
                <input type="submit" value="글 수정">
            </form>
        </div>
        <%
            }
        }
        %>
    </div>

    <div class="comment-section">
        <h3>댓글</h3>
        <hr />

        <div class="comment-list">
            <% int commentcount = boarddao.commentcount(dto); %>
            댓글 수 [<%= commentcount %>]
            <br />
            <% if (commentcount > 0) {
                comment = boarddao.commentlist(kategorienum, listnum, num, commentcount);
                for (int i = 0; i < comment.size(); i++) {
                    comdto = (CommentDTO) comment.get(i);
            %>
           
            <a href="userSearch.jsp?nick=<%=comdto.getNick()%>"><%= comdto.getNick() %></a>: <%= comdto.getCommen() %>
            
            <% if (comdto.getId().equals(sid)) { %>
		<div class="comment-buttons">
            <a href="commentdelete.jsp?kategorienum=<%= kategorienum %>&listnum=<%= listnum %>&num=<%= num %>&commentnum=<%= comdto.getCommentnum() %>">[삭제]</a> / 
            <a href="commentUpdateForm.jsp?kategorienum=<%= kategorienum %>&listnum=<%= listnum %>&num=<%= num %>&commentnum=<%= comdto.getCommentnum() %>">[수정]</a>
        </div>
            <% } %>
            <br />
            <% } %>
            <% } else if (commentcount == 0) { %>
            <h3>댓글 없음</h3>
            <% } %>
        </div>

        <div class="comment-form">
            <form action="comment.jsp" method="get">
                <input type="text" name="commen" /> 
                <input type="hidden" name="kategorienum" value="<%= kategorienum %>"> 
                <input type="hidden" name="listnum" value="<%= listnum %>"> 
                <input type="hidden" name="num" value="<%= num %>"> 
                <input type="submit" value="등록" />
            </form>
        </div>
    </div>
</div>
<%
}
%>
        