package com.cafe.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.board.mapper.MemoDao;
import com.cafe.board.model.MemoDto;

@Service
public class MemoServiceImpl implements MemoService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeMemo(MemoDto memoDto) {
		sqlSession.getMapper(MemoDao.class).writeMemo(memoDto);
	}

	@Override
	public List<MemoDto> listMemo(int seq, String sort) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("seq", seq + "");
		if(sort == null || sort.isEmpty())
			map.put("sort", "latest");
		else
			map.put("sort", sort);
			
		return sqlSession.getMapper(MemoDao.class).listMemo(map);
	}

	@Override
	public void modifyMemo(MemoDto memoDto) {
		sqlSession.getMapper(MemoDao.class).modifyMemo(memoDto);
	}

	@Override
	public void deleteMemo(int mseq) {
		sqlSession.getMapper(MemoDao.class).deleteMemo(mseq);
	}

}
