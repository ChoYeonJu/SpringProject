package com.cafe.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.commons.model.ListParameterDto;
import com.cafe.poll.model.PollDto;

@Service
public class PollAdminServiceImpl implements PollAdminService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PollDto> listPoll(ListParameterDto listParameterDto) {
		return null;
	}

}
