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
	ListDAO listdao = new ListDAO();
	BoardDAO boarddao = new BoardDAO();
	FileimgDAO fileimgdao = new FileimgDAO();
	String path = request.getRealPath("board/content");
	String enc = "UTF-8";
	int max = 1024 * 1024 * 100;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request,path,max,enc,dp);
	
	String sid = (String)session.getAttribute("sid");
	int kategorienum = Integer.parseInt( mr.getParameter("orikatenum"));
	int listnum = Integer.parseInt(mr.getParameter("orilistnum"));
	int num = Integer.parseInt(mr.getParameter("orinum"));
	String editlistname = mr.getParameter("changelistname");
	String subject = mr.getParameter("subject");
	String conten = mr.getParameter("conten");
	if(subject.equals("")){
	%>
<script>
	alert("제목 입력");
	history.go(-1);
</script>		
<%			
	}else if(conten.equals("")){
%>
<script>
	alert("내용 입력");
	history.go(-1);
</script>		
<%			
	}else if(editlistname.equals("0")){
%>		
<script>
		alert("카테고리 선택");
		history.go(-1);
</script>
<%
}
	
	int checklistname = 0;
	int result = 0;
	int typecount = 0;
	int fcount = 0;
	int icuont = 0;
	ListDTO orilist = listdao.nlist(kategorienum, listnum);
	ListDTO editlist = new ListDTO();
	ContentDTO subj = listdao.content(kategorienum, listnum, num);
	ContentDTO newsubj = new ContentDTO();
	UploadDTO upload = new UploadDTO();
	int filepluscount = Integer.parseInt(mr.getParameter("filecount"));
	int filecount = subj.getFilecount();
	int imgpluscount = Integer.parseInt(mr.getParameter("imgcount"));
	int imgcount = subj.getImgcount();
	if(editlistname.equals(orilist.getListname())){
		editlist = listdao.nlist(kategorienum, listnum);
		checklistname = 1;
	}else{
		editlist = listdao.searchlist(editlistname);
	}
	List<String> filesystemnamelist = new ArrayList<>();
	List<String> fileorinamelist = new ArrayList<>();
	List<String> imgsystemnamelist = new ArrayList<>();
	List<String> imgorinamelist = new ArrayList<>();
	int imgcheckcount = 0;
	String itype = "";
	String type = "";
	
	if(imgpluscount > 0){
		for(int i = 0; i<imgpluscount; i++){
			itype = mr.getContentType("img"+ i);
			itype = itype.split("/")[0];
			if(itype.equals("image")){
				imgcheckcount += 0;
			}else{
				imgcheckcount += 1;
			}					
		}
	}
	if(imgcheckcount!=0){
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
	}else{
		Enumeration<String> allFileNames = mr.getFileNames();
		while(allFileNames.hasMoreElements()){
			String inputnames = allFileNames.nextElement();
			String systemname = mr.getFilesystemName(inputnames);
			String oriname = mr.getOriginalFileName(inputnames);
			if(systemname != null){
				if(inputnames.startsWith("file")){
					filesystemnamelist.add(systemname);
					fileorinamelist.add(oriname);
					fcount++;
				}else if(inputnames.startsWith("img")){
					imgsystemnamelist.add(systemname);
					imgorinamelist.add(oriname);
					icuont++;
				}
			}
		}
	}
	int filesumcount = filepluscount + filecount;
	int imgsumcount = imgpluscount + imgcount;
	newsubj.setKategorienum(editlist.getKategorienum());
	newsubj.setListnum(editlist.getListnum());
	newsubj.setSubject(subject);
	newsubj.setConten(conten);
	newsubj.setId(sid);
	newsubj.setFilecount(filesumcount);
	newsubj.setImgcount(imgsumcount);
	if(checklistname == 0){
		result = boarddao.editwrite(newsubj, kategorienum, listnum , num);
		boarddao.editgnb(kategorienum, listnum, num, newsubj, result);
	}else{
		result = num;
		newsubj.setNum(result);
		boarddao.editwritechange(newsubj);
	}
	if(filesumcount>0){
		type = "file";
		typecount = boarddao.edituploadcount(type, kategorienum, listnum, num);
		if(checklistname == 0 && filecount >0){
			fileimgdao.editupload(type, kategorienum, listnum, num, editlist.getKategorienum(), editlist.getListnum(), result);
		}
		if(fcount > 0){
			for(int i=0; i<fcount;i++){
				typecount++;
				upload = new UploadDTO();
				upload.setType(type);
				upload.setNum(result);
				upload.setOriginalname(fileorinamelist.get(i));
				upload.setSystemname(filesystemnamelist.get(i));
				upload.setCountnum(typecount);
				fileimgdao.upload(upload, result, editlist.getKategorienum(), editlist.getListnum());
			}
		}
	}
	if(imgsumcount>0){
		type = "img";
		typecount = boarddao.edituploadcount(type, kategorienum, listnum, num);
		if(checklistname == 0 && imgcount >0){
			fileimgdao.editupload(type, kategorienum, listnum, num, editlist.getKategorienum(), editlist.getListnum(), result);
		}
		if(icuont>0){
			for(int i=0; i<icuont;i++){
				typecount++;
				upload = new UploadDTO();
				upload.setType(type);
				upload.setNum(result);
				upload.setOriginalname(imgorinamelist.get(i));
				upload.setSystemname(imgsystemnamelist.get(i));
				upload.setCountnum(typecount);
				fileimgdao.upload(upload, result, editlist.getKategorienum(), editlist.getListnum());
			}
		}
	}
	
%>		
<script>
	alert("수정 완료");
	window.location="content.jsp?kategorienum=<%=editlist.getKategorienum()%>&listnum=<%=editlist.getListnum()%>&num=<%=result%>"
</script>
		

	
	



	