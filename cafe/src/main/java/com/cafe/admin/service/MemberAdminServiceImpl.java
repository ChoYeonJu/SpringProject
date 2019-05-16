package com.cafe.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.admin.mapper.MemberAdminDao;
import com.cafe.commons.model.ListParameterDto;
import com.cafe.member.model.MemberDetailDto;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class MemberAdminServiceImpl implements MemberAdminService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberDetailDto> listMember(ListParameterDto listParameterDto) {
		int end = listParameterDto.getPageNo() * SizeConstance.DEFAULT_LIST_SIZE;
		listParameterDto.setEnd(end);
		listParameterDto.setStart(end - SizeConstance.DEFAULT_LIST_SIZE + 1);
		String sort = listParameterDto.getSort();
		String orderby = "order by joindate desc";
		switch(sort == null ? "" : sort) {
		case "new" : orderby = "order by m.joindate desc";break;
		case "old" : orderby = "order by m.joindate asc";break;
		case "name" : orderby = "order by m.username";break;
		case "id" : orderby = "order by m.userid";break;
		default : orderby = "order by m.joindate desc";
		}
		listParameterDto.setOrderby(orderby);
		return sqlSession.getMapper(MemberAdminDao.class).listMember(listParameterDto);
	}

	@Override
	public PageNavigation makePageNavigation(ListParameterDto listParameterDto) {
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int listSize = SizeConstance.DEFAULT_LIST_SIZE;
		int pageNo = listParameterDto.getPageNo();
		PageNavigation navigation = new PageNavigation();
		int totalUserCount = sqlSession.getMapper(MemberAdminDao.class).totalUserCount(listParameterDto);
		navigation.setTotalCount(totalUserCount);
		int totalPageCount = (totalUserCount - 1) / listSize + 1;
		navigation.setTotalPageCount(totalPageCount);
		navigation.setCurrentPage(pageNo);
		navigation.setStartRange(pageNo < naviSize);
		navigation.setEndRange((totalPageCount - 1) / naviSize * naviSize < pageNo);
		navigation.makeNavigator();
		return navigation;
	}

	@Override
	public void blindMember(String userid, int role) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("role", role + "");
		sqlSession.getMapper(MemberAdminDao.class).blindMember(map);
	}

}
