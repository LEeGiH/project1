package web.bean.dto;

import java.sql.Timestamp;
public class UserDTO {
	
	private int usernum;
	private String id;
	private String passwd;
	private String username;
	private String nick;
	private String phone;
	private String birth;
	private Timestamp reg;
	private int grade;
	private String img;
	private String auto;
	private String sex;
	
	public int getUsernum() {
		return usernum;
	}
	public String getId() {
		return id;
	}
	public String getPasswd() {
		return passwd;
	}
	public String getUsername() {
		return username;
	}
	public String getNick() {
		return nick;
	}
	public String getPhone() {
		return phone;
	}
	public String getBirth() {
		return birth;
	}
	public Timestamp getReg() {
		return reg;
	}
	public int getGrade() {
		return grade;
	}
	public String getImg() {
		return img;
	}
	public String getAuto() {
		return auto;
	}
	public String getSex() {
		return sex;
	}
	public void setUsernum(int usernum) {
		this.usernum = usernum;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public void setAuto(String auto) {
		this.auto = auto;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
}
