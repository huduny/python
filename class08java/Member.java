package com.ddit401.Bus_login.Console;

import java.util.Objects;

public class Member {
	String mem_id;
	String mem_pw;
	
	public Member() {
		
	}
	
	public Member(String mem_id, String mem_pw) {
		super();
		this.mem_id = mem_id;
		this.mem_pw = mem_pw;
	}
	
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	@Override
	public String toString() {
		return "Member [mem_id=" + mem_id + ", mem_pw=" + mem_pw + "]";
	}
	@Override
	public int hashCode() {
		return Objects.hash(mem_id, mem_pw);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(mem_id, other.mem_id) && Objects.equals(mem_pw, other.mem_pw);
	}
	
	
}
