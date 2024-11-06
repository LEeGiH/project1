<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import ="java.io.File" %>

<jsp:useBean id="fileimgdao" class="web.bean.dao.FileimgDAO" />
<%
   String path = request.getRealPath("/user");
   int max = 1024*1024*10;
   String enc = "UTF-8";
   DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); // 같은 이름이 중복되면 이름앞 1을 붙여 중복되지않게 만들어줌.
   MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
   
   String sysName = mr.getFilesystemName("img"); // 업로드된 파일 이름.
   String type = mr.getContentType("img");// image/jpg, image/png 등  앞이 파일면 뒤가 확장자
   type = type.split("/")[0];
   if(type.equals("image")){
      String id = (String)session.getAttribute("sid");
      fileimgdao.imgChange(sysName, id);
      response.sendRedirect("user.jsp");
   }else{
      //삭제
      File f = new File(path+"//"+sysName);
      f.delete();
%>      <script>
         alert("사진만 등록이 가능합니다.");
         history.go(-1);
      </script>
   <% } %>