package com.cafe.board.mapper;

import java.util.List;
import java.util.Map;

import com.cafe.board.model.MemoDto;

public interface MemoDao {

	void writeMemo(MemoDto memoDto);
	List<MemoDto> listMemo(Map<String, String> map);
	void modifyMemo(MemoDto memoDto);
	void deleteMemo(int mseq);
	
}
