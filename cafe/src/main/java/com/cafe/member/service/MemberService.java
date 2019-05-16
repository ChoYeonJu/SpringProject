package com.cafe.member.service;

import java.util.List;
import java.util.Map;

import com.cafe.member.model.MemberDetailDto;
import com.cafe.member.model.MemberDto;
import com.cafe.member.model.ZipDto;

public interface MemberService {
	
	int idCount(String userid);
	List<ZipDto> listZip(String dong);
	int registerMember(MemberDetailDto memberDetailDto);
	MemberDetailDto getMember(String userid);
	void modifyMember(MemberDetailDto memberDetailDto);
	void deleteMember(String userid);
	void reregisterMember(String userid);
	
	MemberDto login(Map<String, String> map);
	
}
