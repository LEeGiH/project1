<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="web.bean.dto.*"%>
<%@ page import="web.bean.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>


<%
	String path = request.getRealPath("board/content");
	String enc = "UTF-8";
	int max = 1024 * 1024 * 100;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	BoardDAO boarddao = new BoardDAO();
	ListDAO listdao = new ListDAO();
	FileimgDAO fileimgdao = new FileimgDAO();
	ContentDTO subj = new ContentDTO();
	ListDTO listdto = null;
	UploadDTO upload = null;
	int kategorienum = 0;
	int listnum = 0;
	int result = 0;
	String sid = (String)session.getAttribute("sid");
	String katenum = mr.getParameter("kategorienum");
	String linum = mr.getParameter("listnum");
	int fcount = Integer.parseInt(mr.getParameter("filecount"));
	int icount = Integer.parseInt(mr.getParameter("imgcount"));
	if(linum == null){
		linum = "null";
	}
	String Step2 = mr.getParameter("Step2");
	if(Step2 == null){
		Step2 = "0";
	}
	String Step3 = mr.getParameter("Step3");
	if(Step3 == null){
		Step3 = "0";
	}
	String subject = mr.getParameter("subject");
	String conten = mr.getParameter("conten");
	if(linum.equals("null")){
		listnum = Integer.parseInt(Step3);
	}else{
		listnum = Integer.parseInt(linum);
	}
	if(Step2.equals("0") && Step3.equals("0") && linum.equals("0")){
%>
<script>
	alert("카테고리를 선택 해주세요");
	history.go(-1);
</script>		
<%	}else if(Step2.equals("0") && Step3.equals("0") && linum.equals("null")){
%>
<script>
	alert("리스트를 선택 해주세요");
	history.go(-1);
</script>		
<%	
	}else if(subject.equals("")){
%>
<script>
	alert("제목을 입력 해주세요");
	history.go(-1);
</script>		
<%			
	}else if(conten.equals("")){
%>
<script>
	alert("내용을 입력 해주세요");
	history.go(-1);
</script>		
<%			
	}else{
	if(Step2.equals("0") && Step3.equals("0")){
		kategorienum = Integer.parseInt(katenum);
		listdto = listdao.nlist(kategorienum, listnum);
	}else if(Step2.equals("0")){
		kategorienum = Integer.parseInt(katenum);
		listdto = listdao.nlist(kategorienum, listnum);;
	}else{
		listdto = listdao.searchlist(Step2);
	}
	List<String> filesystemnamelist = new ArrayList<>();
	List<String> fileorinamelist = new ArrayList<>();
	List<String> imgsystemnamelist = new ArrayList<>();
	List<String> imgorinamelist = new ArrayList<>();
	int filecount = 0;
	int imgcount = 0;
	int imgcheckcount = 0;
	String type = "";
	String itype = "";
	if(icount > 0){
		for(int i = 0; i<icount; i++){
			itype = mr.getContentType("img"+i);
			itype = itype.split("/")[0];
			if(itype.equals("image")){
				imgcheckcount += 0;
			}else{
				imgcheckcount += 1;
			}					
		}
		if(imgcheckcount != 0){
			Enumeration<String> allFileNames = mr.getFileNames();
				while(allFileNames.hasMoreElements()){
					String inputnames = allFileNames.nextElement();
					String systemname = mr.getFilesystemName(inputnames);
					if(systemname != null){
						File f = new File(path+"//"+systemname);
						f.delete();
					}
				}
%>
<script>
	alert("사진등록은 이미지파일만 가능");
	history.go(-1);
</script>				
<%				
		}
	}
	subj.setKategorienum(listdto.getKategorienum());
	subj.setListnum(listdto.getListnum());
	subj.setSubject(subject);
	subj.setConten(conten);
	subj.setId(sid);
	subj.setFilecount(fcount);
	subj.setImgcount(icount);
	result = boarddao.write(subj, listdto.getKategorienum(), listdto.getListnum());
	if(fcount+icount >0){
		Enumeration<String> allFileNames = mr.getFileNames();
		while(allFileNames.hasMoreElements()){
			String inputnames = allFileNames.nextElement();
			String systemname = mr.getFilesystemName(inputnames);
			String oriname = mr.getOriginalFileName(inputnames);
			if(systemname != null){
				if(inputnames.startsWith("file")){
					filesystemnamelist.add(systemname);
					fileorinamelist.add(oriname);
					filecount++;
				}else if(inputnames.startsWith("img")){
					imgsystemnamelist.add(systemname);
					imgorinamelist.add(oriname);
					imgcount++;
				}
			}			
		}
	}
	if(filecount>0){
		type = "file";
		for(int i=0; i<filecount;i++){
			upload = new UploadDTO();
			upload.setType(type);
			upload.setNum(result);
			upload.setOriginalname(fileorinamelist.get(i));
			upload.setSystemname(filesystemnamelist.get(i));
			upload.setCountnum(i+1);
			fileimgdao.upload(upload, result, listdto.getKategorienum(), listdto.getListnum());
		}
	}
	if(imgcount>0){
		type = "img";
		for(int i=0; i<imgcount;i++){
			upload = new UploadDTO();
			upload.setType(type);
			upload.setNum(result);
			upload.setOriginalname(imgorinamelist.get(i));
			upload.setSystemname(imgsystemnamelist.get(i));
			upload.setCountnum(i+1);
			fileimgdao.upload(upload, result, listdto.getKategorienum(), listdto.getListnum());
		}
	}	
	if(result != 0){
	%>
	<script>
		alert("작성완료");
		window.location="content.jsp?kategorienum=<%=listdto.getKategorienum()%>&listnum=<%=listdto.getListnum()%>&num=<%=result%>"
	</script>		
<%
	}}
%>
	
