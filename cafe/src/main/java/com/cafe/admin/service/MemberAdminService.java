package com.cafe.admin.service;

import java.util.List;

import com.cafe.commons.model.ListParameterDto;
import com.cafe.member.model.MemberDetailDto;
import com.cafe.util.PageNavigation;

public interface MemberAdminService {

	List<MemberDetailDto> listMember(ListParameterDto listParameterDto);
	void blindMember(String userid, int role);
	
	PageNavigation makePageNavigation(ListParameterDto listParameterDto);
}
