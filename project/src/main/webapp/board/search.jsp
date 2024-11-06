<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<jsp:include page="menubar.jsp" flush="true" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색 결과</title>
<link rel="stylesheet" type="text/css" href="../resources/css/list.css">
</head>
<body>
    <div class="container">
        <h1 class="category-title">검색 결과</h1>
        <div class="results">
            <%
                ContentDTO dto = new ContentDTO();
                UserDTO user = new UserDTO();
                BoardDAO boarddao = new BoardDAO();
                UserDAO userdao = new UserDAO();
                ListDAO listdao = new ListDAO();
                List list_num = null;
            	int liststart = 0;
            	int listend = 0;
            	int thispage = 0;													
            	int pagesize = 10;
                String search = request.getParameter("search");
                String searchmenu = request.getParameter("searchmenu");
                String pagenum = request.getParameter("pagenum");
                if(pagenum==null){
                	pagenum="1";
                }
                thispage = Integer.parseInt(pagenum);
                liststart = (thispage - 1) * pagesize + 1;
    			listend = thispage * pagesize;
                int count = boarddao.subj(search, searchmenu);
            	list_num = boarddao.subj_num(search, searchmenu, liststart, listend);
                if (list_num != null && !list_num.isEmpty()) {
                    for (int i = 0; i < list_num.size(); i++) {
                        dto = (ContentDTO)list_num.get(i);
                        user = userdao.user(dto.getId());
                        int comcount = boarddao.commentcount(dto);
            %>
            <ul class="post-list">
                <li class="post-item">
                    <a href="content.jsp?kategorienum=<%= dto.getKategorienum() %>&listnum=<%= dto.getListnum() %>&num=<%= dto.getNum() %>" class="post-link">
                        [<%=listdao.nlist(dto.getKategorienum(), dto.getListnum()).getListname() %>]
                        <span>제목: <%= dto.getSubject() %></span>
                        <% if (dto.getFilecount() > 0) { %>
                        <img src="<%= request.getContextPath() %>/resources/image/files.png" width="15" height="15" alt="첨부파일 아이콘"/>
                        <% } if (dto.getImgcount() > 0) { %>
                        <img src="<%= request.getContextPath() %>/resources/image/imges.jpg" width="15" height="15" alt="이미지 아이콘"/>
                        <% } %>
                        [<%= comcount %>]
                    </a>
                </li>
            </ul>
            <%
                    }
%>			<div class="pagelist">
<%
				if (count > 0) {
					int pageCount = count / pagesize + ( count % pagesize == 0 ? 0 : 1);
					int startPage = (int)(thispage/10)*10+1;
					int pageBlock=10;
					int endPage = startPage + pageBlock-1;
					if (endPage > pageCount) endPage = pageCount;
					if (startPage > 10) {    
%>
						<a href="search.jsp?searchmenu=<%=searchmenu%>&search=<%=search%>&pagenum=<%= startPage - 10 %>">[이전]</a>
<%					}
					for (int i = startPage ; i <= endPage ; i++) {  %>
						<a href="search.jsp?searchmenu=<%=searchmenu%>&search=<%=search%>&pagenum=<%= i %>">[<%= i %>]</a>
<%
					}
					if (endPage < pageCount) {  
%>
						<a href="search.jsp?searchmenu=<%=searchmenu%>&search=<%=search%>&pagenum=<%= startPage + 10 %>">[다음]</a>
<%
					}
				}
%>
			</div>
<%
                } else {
%>
            <h3>검색 결과가 없습니다.</h3>
            <%
                }
            %>
        </div>
        <button class="btn-main" onclick="window.location='main.jsp'">메인으로</button>
    </div>
</body>
</html>
