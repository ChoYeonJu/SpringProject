package com.cafe.member.model;

public class MemberDto {

	private String userid;
	private String username;
	private String userpwd;
	private String emailid;
	private String emaildomain;
	private String profile;
	private String joindate;
	private int role;//0 : 관리자, 1 : 일반회원, 2 : 블라인드회원

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserpwd() {
		return userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	public String getEmailid() {
		return emailid;
	}

	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}

	public String getEmaildomain() {
		return emaildomain;
	}

	public void setEmaildomain(String emaildomain) {
		this.emaildomain = emaildomain;
	}

	public String getProfile() {
		if(profile == null)
			profile = "noimage";
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getJoindate() {
		return joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

}
