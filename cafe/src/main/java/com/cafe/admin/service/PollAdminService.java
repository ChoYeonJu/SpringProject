package com.cafe.admin.service;

import java.util.List;

import com.cafe.commons.model.ListParameterDto;
import com.cafe.poll.model.PollDto;

public interface PollAdminService {

	List<PollDto> listPoll(ListParameterDto listParameterDto);
}
