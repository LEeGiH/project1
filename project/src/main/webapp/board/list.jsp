<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="../resources/css/list.css">
</head>

<body>
<div class="container">
<%
	String sid = (String)session.getAttribute("sid");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int kategorienum = 0;
	String katenum = request.getParameter("kategorienum");
	String listnum = request.getParameter("listnum");
	ListDAO listdao = new ListDAO();
	BoardDAO boarddao = new BoardDAO();
	UserDAO userdao = new UserDAO();
	UserDTO user =  userdao.user(sid);
	int listcount = 0;
	List katelist = null;
	List listlist = null;
	List subjlist = null;
	CommentDTO comdto = new CommentDTO();
	ListDTO katedto = null;
	ListDTO lidto = null;
	ContentDTO sub = null;
	int listnum2 = 0;
	int subjcount = 0;
	int grade = 0;
	int liststart = 0;
	int listend = 0;
	int thispage = 0;
	int pagesize = 10;
	if (sid != null){ //로그인 확인
		grade = user.getGrade();
	}
	if(katenum != null){ //파라미터 카테고리 넘버가 있을경우
		kategorienum = Integer.parseInt(katenum);
		listcount = listdao.getList(kategorienum);
		katedto = listdao.nkate(kategorienum);
		if(listnum != null){	//파라미터 리스트넘버가 있을경우
			String pagenum = request.getParameter("pagenum");
				if(pagenum == null){ // 페이지 넘버 없을때
				pagenum = "1";
			}
			listnum2 = Integer.parseInt(listnum);
			lidto = listdao.nlist(kategorienum, listnum2);
			subjcount = listdao.getSubjCount(kategorienum, listnum2);
			thispage = Integer.parseInt(pagenum);
			liststart = (thispage - 1) * pagesize + 1;
			listend = thispage * pagesize;
%>
			<h1><%=katedto.getKategoriename()%> 카테고리</h1>
			<h2><%=lidto.getListname()%> 게시판</h2>
			<br />
<%
			if(subjcount > 0 && subjcount <= 10){	 //게시글 10개 이하일경우 전부 가져오기
				subjlist = listdao.subjList(kategorienum, listnum2, subjcount);
			}else if(subjcount >10){ //게시글 10개 초과일경우 페이지 나누기
				subjlist = listdao.subjpageList(kategorienum, listnum2, liststart, listend);
			}

		if(subjlist != null){	// 게시글 있을경우
			for(int i =0; i<subjlist.size();i++){
%>
				<ul class="post-list">
<%
					sub = (ContentDTO)subjlist.get(i);
					int comcount = boarddao.commentcount(sub);
%>
					<li class="post-item">
					<a href="content.jsp?kategorienum=<%= sub.getKategorienum() %>&listnum=<%= sub.getListnum() %>&num=<%= sub.getNum() %>" class="post-link">
					<span><%= sub.getSubject() %></span>
<%
					if(sub.getFilecount() > 0) {
%> 						<img src="/project/resources/image/files.png" width="15" height="15" />
<%
					}
					if(sub.getImgcount() > 0) {
%> 
						<img src="/project/resources/image/imges.jpg" width="15" height="15" />
<%
					}
%> 					[<%= comcount %>]
					</a>
					<div class="post-author">
					<a href="userSearch.jsp?nick=<%=sub.getNick()%>">[<%=sub.getNick() %>]</a>
					</div>
					</li>
			</ul>
<%
					}
	%>			<div class="pagelist">
	<%
				    if (subjcount > 0) {
				        int pageCount = subjcount / pagesize + ( subjcount % pagesize == 0 ? 0 : 1);
				        int startPage = (int)(thispage/pagesize)*pagesize+1;
						int pageBlock=pagesize;
				        int endPage = startPage + pageBlock-1;
				        if (endPage > pageCount) endPage = pageCount;
				        if (startPage > pagesize) {    
	%>
							<a href="list.jsp?kategorienum=<%=katenum%>&listnum=<%=listnum%>&pagenum=<%= startPage - 10 %>">[이전]</a>
	<%					}
	                    for (int i = startPage ; i <= endPage ; i++) {  
	                        if(i==thispage){
	 %>                        <b>
	 <%                  }
	                     %>
	                      <a href="list.jsp?kategorienum=<%=katenum%>&listnum=<%=listnum %>&pagenum=<%= i %>">[<%= i %>]</a>
	 <%                       if(i==thispage){
	 %>                        </b>
	 <%                     }
	                     }
				        if (endPage < pageCount) {  %>
							<a href="list.jsp?kategorienum=<%=katenum%>&listnum=<%=listnum%>&pagenum=<%= startPage + 10 %>">[다음]</a>
	<%
				        }
				    }
	%>
				</div>
<%
			}else{
%>
				<h3>글이 없음</h3>
<%
			}

		}else{ //파라미터 카테고리 유 , 리스트 무
%>
			<h1><%=katedto.getKategoriename()%></h1>
<%
			if(listcount > 0){
				listlist = listdao.listList(kategorienum,listcount);
%>
				<ul class="post-list">
<%
				for(int i =0; i< listlist.size(); i++){
					lidto = (ListDTO)listlist.get(i);
%>
					<li class="post-item">
					<a href="list.jsp?kategorienum=<%=kategorienum%>&listnum=<%=lidto.getListnum()%>" class="post-link"><%=lidto.getListname()%></a>
					</li>
<%				
				}
%>
				</ul>
<%			}

		}
%>
		<br />
<%
	}else{
		int katecount = listdao.getKate();
		if(katecount > 0){
			katelist = listdao.kateList(katecount);
		}
		for(int i =0; i< katelist.size(); i++){
			katedto = (ListDTO)katelist.get(i);
%>
			<a href="list.jsp?kategorienum=<%=katedto.getKategorienum()%>" class="post-link"><%=katedto.getKategoriename()%></a>
			<ul class="post-list">
<% 
			kategorienum = katedto.getKategorienum();
			listcount = listdao.getList(kategorienum);
			listlist = listdao.listList(kategorienum, listcount);
			for(int j = 0; j <listlist.size(); j++){
				lidto = (ListDTO)listlist.get(j);
%>
				<li class="post-item">
				<a href="list.jsp?kategorienum=<%=lidto.getKategorienum()%>&listnum=<%=lidto.getListnum()%>" class="post-link"><%=lidto.getListname()%></a>
				</li>
<% 
			}
%>
			</ul>
<%
		}
	}
%>
</div>
</body>
</html>

