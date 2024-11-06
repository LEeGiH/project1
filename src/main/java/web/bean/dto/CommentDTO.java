package web.bean.dto;

public class CommentDTO {

	private int num;
	private int commentnum;
	private int kategorienum;
	private int listnum;
	private String commen;
	private String id;
	private String nick;
	private String writedate;
	private int updatecount;
	public int getNum() {
		return num;
	}
	public int getCommentnum() {
		return commentnum;
	}
	public int getKategorienum() {
		return kategorienum;
	}
	public int getListnum() {
		return listnum;
	}
	public String getCommen() {
		return commen;
	}
	public String getId() {
		return id;
	}
	public String getNick() {
		return nick;
	}
	public String getWritedate() {
		return writedate;
	}
	public int getUpdatecount() {
		return updatecount;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public void setCommentnum(int commentnum) {
		this.commentnum = commentnum;
	}
	public void setKategorienum(int kategorienum) {
		this.kategorienum = kategorienum;
	}
	public void setListnum(int listnum) {
		this.listnum = listnum;
	}
	public void setCommen(String commen) {
		this.commen = commen;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public void setUpdatecount(int updatecount) {
		this.updatecount = updatecount;
	}
	
	

}
