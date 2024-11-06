<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="web.bean.dto.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Best</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/bestNotice.css">
</head>
<body>
    <div class="container">
        <%
        ListDAO listdao = new ListDAO();					// 필요한 DAO와 DTO의 객체의 생성 선언
        ContentDTO rctsub = new ContentDTO();
        ContentDTO bnsub = new ContentDTO();
        ContentDTO bntitle = new ContentDTO();
        List rctlist = listdao.readcountTop();				// 전체 게시글 중에 조회수가 가장 많은 게시판의 최신 게시글 List를 가져오는 sql문		(베스트 게시글)
        List bnlist = listdao.bestNotice();					// 게시글이 가장많은 게시판의 최신 게시글들을 가져 오는 sql문으로 만든 게시글 List		(베스트 게시판)
        ListDTO rctdto = new ListDTO();
        ListDTO bndto = new ListDTO();
        if(bnlist != null){
            bntitle = (ContentDTO) bnlist.get(0);				// 베스트 게시판의 게시판 이름을 가져오기 위한 선언문
        }
        bndto = listdao.nlist(bntitle.getKategorienum(), bntitle.getListnum());
        if(rctlist != null && bnlist != null){
        %>
        <div class="mainlist">
            <div class="bestcontent">
                <h2>베스트 게시글</h2>
                <div class="bcsubject">
                    <%
                    for (int i = 0; i < rctlist.size(); i++) {			// 베스트 게시판의 게시글들을 가져온 List를 반복문으로 펼치면서 노출
                        rctsub = (ContentDTO) rctlist.get(i);
                        rctdto = listdao.nlist(rctsub.getKategorienum(), rctsub.getListnum());
                    %>
                    <div class="post-item">
                        <a href="/project/board/content.jsp?kategorienum=<%= rctsub.getKategorienum() %>&listnum=<%= rctsub.getListnum() %>&num=<%= rctsub.getNum() %>">
                           [<%= rctdto.getListname() %>]<%= rctsub.getSubject() %>
                        </a> 
                       <span><a href="userSearch.jsp?nick=<%=rctsub.getNick()%>">작성자 :<%= rctsub.getNick() %> </a>&nbsp; 조회수:<%= rctsub.getReadcount() %></span>
                    </div>
                    <%
                    }
                    %>
                </div>
            </div>
            <div class="centerline"></div>
            <div class="bestlist">
                <h2><a href="/project/board/list.jsp?kategorienum=<%= bndto.getKategorienum() %>&listnum=<%= bndto.getListnum() %>">베스트 게시판 [<%= bndto.getListname() %>]</a></h2>
                <div>
                    <%
                    for (int i = 0; i < bnlist.size(); i++) {			// 베스트 게시판의 최신 게시글 List를 반복문으로 펼치면서 노출
                        bnsub = (ContentDTO) bnlist.get(i);
                    %>
                    <div class="post-item">
                        <a href="/project/board/content.jsp?kategorienum=<%= bnsub.getKategorienum() %>&listnum=<%= bnsub.getListnum() %>&num=<%= bnsub.getNum() %>">
                             제목 : <%= bnsub.getSubject() %>
                        </a>
                       <span> <a href="userSearch.jsp?nick=<%=bnsub.getNick()%>">작성자 :<%= bnsub.getNick() %> </a></span>
                    </div>
                    <%
                    }
                    %>
                </div>
            </div>
        </div>
<%		}else{%>
			
			<h1>조 = NULL;</h1>
<%		}
%>
    </div>
</body>
</html>
