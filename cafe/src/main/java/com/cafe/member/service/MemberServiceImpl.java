package com.cafe.member.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.member.mapper.MemberDao;
import com.cafe.member.model.MemberDetailDto;
import com.cafe.member.model.MemberDto;
import com.cafe.member.model.ZipDto;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int idCount(String userid) {
		return sqlSession.getMapper(MemberDao.class).idCount(userid);
	}

	@Override
	public List<ZipDto> listZip(String dong) {
		return null;
	}

	@Override
	public int registerMember(MemberDetailDto memberDetailDto) {
		return sqlSession.getMapper(MemberDao.class).registerMember(memberDetailDto);
	}

	@Override
	public MemberDetailDto getMember(String userid) {
		return sqlSession.getMapper(MemberDao.class).getMember(userid);
	}
	
	@Override
	@Transactional
	public void modifyMember(MemberDetailDto memberDetailDto) {
		MemberDao memberDao = sqlSession.getMapper(MemberDao.class);
		memberDao.modifyMember(memberDetailDto);
		memberDao.modifyMemberDetail(memberDetailDto);
	}

	@Override
	public void deleteMember(String userid) {
		sqlSession.getMapper(MemberDao.class).deleteMember(userid);
	}
	
	@Override
	public void reregisterMember(String userid) {
		sqlSession.getMapper(MemberDao.class).reregisterMember(userid);
	}

	@Override
	public MemberDto login(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).login(map);
	}

}
