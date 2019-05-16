package com.cafe.admin.mapper;

import java.util.List;
import java.util.Map;

import com.cafe.commons.model.ListParameterDto;
import com.cafe.member.model.MemberDetailDto;

public interface MemberAdminDao {

	List<MemberDetailDto> listMember(ListParameterDto listParameterDto);
	void blindMember(Map<String, String> map);
	
	int totalUserCount(ListParameterDto listParameterDto);

}
