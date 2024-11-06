package web.bean.dto;

public class ContentDTO {

	
	private int kategorienum;
	private int listnum;
	private int num;
	private String subject;
	private String conten;
	private String id;
	private String nick;
	private String writedate;
	private int goodnum;
	private int badnum;
	private int commentcount;
	private int filecount;
	private int imgcount;
	private int updatecount;
	private int readcount;
	
	
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public int getReadcount() {
		
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getUpdatecount() {
		return updatecount;
	}
	public void setUpdatecount(int updatecount) {
		this.updatecount = updatecount;
	}
	public int getFilecount() {
		return filecount;
	}
	public void setFilecount(int filecount) {
		this.filecount = filecount;
	}
	public int getImgcount() {
		return imgcount;
	}
	public void setImgcount(int imgcount) {
		this.imgcount = imgcount;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public int getCommentcount() {
		return commentcount;
	}
	public void setCommentcount(int commentcount) {
		this.commentcount = commentcount;
	}
	public int getGoodnum() {
		return goodnum;
	}
	public void setGoodnum(int goodnum) {
		this.goodnum = goodnum;
	}
	public int getBadnum() {
		return badnum;
	}
	public void setBadnum(int badnum) {
		this.badnum = badnum;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getKategorienum() {
		return kategorienum;
	}
	public void setKategorienum(int kategorienum) {
		this.kategorienum = kategorienum;
	}
	public int getListnum() {
		return listnum;
	}
	public void setListnum(int listnum) {
		this.listnum = listnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getConten() {
		return conten;
	}
	public void setConten(String conten) {
		this.conten = conten;
	}
	
	
}
