package com.smhrd.bigdata.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.bigdata.entity.Member;

@Mapper
public interface MemberMapper {
	
	public int join(Member member);
	
	public Member login(Member member);

}