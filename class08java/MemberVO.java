package com.ddit401.Bus_login.Console;

public class MemberVO {
	private String id;
	private String name;
	private String pwd;
	private int age;
	private String address;
	private String mail;
	private String phone;
	private String mileage;
	private int balance;
	private int inputNoticeMenu;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMileage() {
		return mileage;
	}
	public void setMileage(String mileage) {
		this.mileage = mileage;
	}
	public int getBalance() {
		return balance;
	}
	public void setBalance(int balance) {
		this.balance = balance;
	}
	public int getInputNoticeMenu() {
		return inputNoticeMenu;
	}
	public void setInputNoticeMenu(int inputNoticeMenu) {
		this.inputNoticeMenu = inputNoticeMenu;
	}
	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", name=" + name + ", pwd=" + pwd + ", age=" + age + ", address=" + address
				+ ", mail=" + mail + ", phone=" + phone + ", mileage=" + mileage + ", balance=" + balance
				+ ", inputNoticeMenu=" + inputNoticeMenu + "]";
	}
	
	
	
}
