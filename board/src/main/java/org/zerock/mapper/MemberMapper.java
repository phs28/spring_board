package org.zerock.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.zerock.domain.MemberVO;

@Mapper
public interface MemberMapper {
	public MemberVO read(String userid);
}
