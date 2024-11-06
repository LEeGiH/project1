<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "web.bean.dto.*" %>
<%@ page import = "web.bean.dao.*" %>
<%@ page import = "java.util.List" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="menubar.jsp" flush="true" />
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 정보</title>
    <link rel="stylesheet" type="text/css" href="../resources/css/user.css">
</head>

<body class="user-page">
    <div class="alluser">
        <div class="user-container">
            <%
            String sid = (String)session.getAttribute("sid");
            String nick = request.getParameter("nick");
            UserDAO userdao = new UserDAO();
            BoardDAO boarddao = new BoardDAO();
            UserDTO searchuser = userdao.getUserInfo(nick);
            UserDTO using = new UserDTO();
            String id = searchuser.getId();
            int noticecount  = boarddao.noti_num(id);
            int commentcount = boarddao.com_num(id);
            List notilist = null;
            List comenlist = null;
        	String usergrade="";
            int grade = 0;
            if(sid != null){
				using = userdao.user(sid);
				grade= using.getGrade();
            }
            if(searchuser.getGrade()==1){
            	usergrade="일반회원";
            }else if (searchuser.getGrade()==2){
            	usergrade="관리자";
            }else if (searchuser.getGrade()==0){
            	usergrade="제제된 회원";
            }else if (searchuser.getGrade()==3){
            	usergrade="총 관리자";
            }
            
                if(searchuser.getId() == null){   
            %>
                <script>
                    alert("닉네임 다시 확인하세요");
                    history.go(-1);
                </script>   
            <%      
                }else{
            %>
                <h2>사용자 정보</h2>
                <div class="user-profile-image">
                	<img src="/project/user/<%=searchuser.getImg()%>" alt="프로필 이미지"/><br/>
<%					if(sid != null && searchuser.getId().equals(using.getId())){
%>
						<button class="user-button" onclick="window.location='imgChange.jsp'">사진 변경</button>
<%					} 
%>
                </div>
                <div class="user-info">
                    <strong>이름 :</strong> <%=searchuser.getUsername()%><br/>
                    <strong>아이디 :</strong> <%=searchuser.getId()%><br/>
                    <strong>생일 :</strong> <%=searchuser.getBirth().split(" ")[0]%><br/>
                    <strong>성별 :</strong> <%=searchuser.getSex()%><br/>
                    <strong>회원등급 :</strong> <%=usergrade%><br/>
                </div>
<%
			}
%>
            <div class="user-button-container">
<%				if(grade == 3){ 
%>
                    <h3>사용자 등급 선택 :</h3>
                    <button onclick="userGrade();" class="user-button">유저등급 선택</button>
<%
				}
				if(sid != null && searchuser.getId().equals(using.getId())){
					%>
					<button class="user-button" onclick="window.location='userUpdate.jsp'">회원정보 수정</button>
					<button class="user-button" onclick="window.location='userDelete.jsp'">회원탈퇴</button>
<% 				}
%>
            </div>
		</div>
        <div>
        <h3>작성글</h3>
<%
		if(noticecount > 0){
			notilist = boarddao.notice_num(id,1,noticecount);
			for(int i = 0; i<notilist.size(); i++){
				ContentDTO sub = (ContentDTO)notilist.get(i);
%>
				<a href="content.jsp?kategorienum=<%=sub.getKategorienum()%>&listnum=<%=sub.getListnum()%>&num=<%=sub.getNum()%>"><%=sub.getSubject()%></a><br/>
<% 			}
			if(noticecount>10){
%>
				<button onclick="userWrite();">작성 게시글 모두 보기</button>
<%			
			}
		}else{ %>
		<h1>글 없음</h1>
<% 
		} 
%>
		</div>
		<div>
        <h3>작성 댓글</h3>		
<%
		if(commentcount>0){
			comenlist = boarddao.comen_num(id,1,10);
			for(int i = 0; i<comenlist.size(); i++){
				CommentDTO comment = (CommentDTO)comenlist.get(i);
%>
				<a href="content.jsp?kategorienum=<%=comment.getKategorienum()%>&listnum=<%=comment.getListnum()%>&num=<%=comment.getNum()%>">
				<%=comment.getCommen() %></a><br/>
<% 			}
			if(commentcount>10){
%>
				<button onclick="userComment();">작성 댓글 모두 보기</button>
<%		
			
			}
		}else{ %>
		<h1>댓글 없음</h1>
<% 
		} 
%>
		</div>
    </div>

<script>
	function userGrade(){
		window.location="selectGrade.jsp?nick=<%=nick%>";
	}
	function userWrite(){
		open("userWrite.jsp?id=<%=searchuser.getId()%>", "", "width=600,height=400");
	}
	function userComment(){
		open("userComment.jsp?id=<%=searchuser.getId()%>", "", "width=600,height=400");
	}
</script>
</body>

</html>
