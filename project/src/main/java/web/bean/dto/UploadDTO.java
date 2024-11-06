package web.bean.dto;

public class UploadDTO {
	
	private int num;
	private String type;
	private String systemname;
	private String originalname;
	private int countnum;
	
	public int getCountnum() {
		return countnum;
	}
	public void setCountnum(int countnum) {
		this.countnum = countnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSystemname() {
		return systemname;
	}
	public void setSystemname(String systemname) {
		this.systemname = systemname;
	}
	public String getOriginalname() {
		return originalname;
	}
	public void setOriginalname(String originalname) {
		this.originalname = originalname;
	}

}
