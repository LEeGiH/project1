<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); // port방식 인코딩 %>
<%@ page import="web.bean.dto.*" %>

<jsp:useBean id="newdto" class="web.bean.dto.UserDTO" />
<jsp:setProperty name="newdto" property="*" />
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />

<%
String phone = request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
String id = request.getParameter("id");
newdto.setPhone(phone);
String afnick = newdto.getNick();
UserDTO user = userdao.user(id);

try {
	Integer.parseInt(request.getParameter("phone1"));
	Integer.parseInt(request.getParameter("phone2"));
	Integer.parseInt(request.getParameter("phone3"));
	int result = userdao.nickcheck(newdto);
	if(result==0){
		int updatenum = userdao.changeNick(newdto);
		int afterupdatenum = updatenum + 1;
		userdao.updatenick(user,afnick,afterupdatenum);
		userdao.userUpdate(newdto);	
	%>
	<script>
		alert("변경 완료");
		window.location="user.jsp"
	</script>
	<%
	}else if(afnick.equals(user.getNick())){
		userdao.userUpdate(newdto);	
	%>
	<script>
		alert("변경 완료");
		window.location="user.jsp"
	</script>
	<%
	}else{%>
	<script>
		alert("닉네임 중복됩니다");
		history.go(-1);
	</script>
	<%}
}catch(Exception e){
%>
<script>
alert("휴대폰은 번호만 입력 가능합니다.");
history.go(-1);
</script>	
<%	
}
%>