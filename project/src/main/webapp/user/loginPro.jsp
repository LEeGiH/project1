<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>


<jsp:useBean id="userdto" class="web.bean.dto.UserDTO" />
<jsp:setProperty name="userdto" property="*" />
<jsp:useBean id="userdao" class="web.bean.dao.UserDAO" />


<%
	Cookie [] cookies = request.getCookies();
	String cid = null, cpw = null, cauto = null;
	if(cookies != null){
		for(Cookie c : cookies){
			if(c.getName().equals("cid")){cid=c.getValue();}
			if(c.getName().equals("cpw")){cpw=c.getValue();}
			if(c.getName().equals("cauto")){cauto=c.getValue();}
		}
	}
	if(cid != null && cpw != null && cauto != null){
		userdto.setId(cid);
		userdto.setPasswd(cpw);
		userdto.setAuto(cauto);
	}

	int result = userdao.loginCheck(userdto);
	   if(result > 0){
	      session.setAttribute("sid", userdto.getId());
	      String id = (String)session.getAttribute("sid");
	      userdto = userdao.user(id);
	      session.setAttribute("snick", userdto.getNick());
	      
	      if(userdto.getAuto() != null){
	         Cookie cooid = new Cookie("cid",userdto.getId());
	         Cookie coopw = new Cookie("cpw",userdto.getPasswd());
	         Cookie cooauto = new Cookie("cauto",userdto.getAuto());
	         cooid.setMaxAge(60*60*24);
	         coopw.setMaxAge(60*60*24);
	         cooauto.setMaxAge(60*60*24);
	         response.addCookie(cooid);
	         response.addCookie(coopw);
	         response.addCookie(cooauto);   
	      }
	%>
<script>
	   opener.window.location="/project/board/main.jsp";
	   self.close();
	</script>
<%
	   }else if (result == 0){
	%>
<script>
	         alert("관리자에 의해 제제된 회원입니다.");
	         history.go(-1);
	      </script>
<%   
	   }else{
	%>
<script>
	         alert("아이디 또는 패스워드를 확인해주세요");
	         history.go(-1);
	      </script>
<%   
	   }%>%>
