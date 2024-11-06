<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%request.setCharacterEncoding("UTF-8");%>
    <%
    session.removeAttribute("sid");
    session.invalidate();
    
 	Cookie [] cookies = request.getCookies();
 	String cid = null ,cpw= null ,cauto = null;
 		if(cookies != null){
 		   for(Cookie c : cookies){ //[cid,cpw,cauto,jsess]
 			   if(c.getName().equals("cid")){c.setMaxAge(0);response.addCookie(c);}
 			   if(c.getName().equals("cpw")){c.setMaxAge(0);response.addCookie(c);}
 			   if(c.getName().equals("cauto")){c.setMaxAge(0);response.addCookie(c);}
 		   }
 	   }
	response.sendRedirect("/project/board/main.jsp");
	%>