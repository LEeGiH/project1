<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%  
int kategorienum = Integer.parseInt(request.getParameter("kategorienum"));
int listnum = Integer.parseInt(request.getParameter("listnum"));
int num = Integer.parseInt(request.getParameter("num"));
int commentnum = Integer.parseInt(request.getParameter("commentnum"));

%> 
<form action = "commentUpdate.jsp" method="get">
				<input type="text" name="commentUpdate">
				<input type="hidden" name="kategorienum" value="<%=kategorienum%>">
				<input type="hidden" name="listnum" value="<%=listnum%>">
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="commentnum" value="<%=commentnum %>">
				<input type="submit" value="댓글 수정">
			</form>