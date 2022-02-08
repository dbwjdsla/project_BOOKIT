package com.finale.bookit.member.model.service;

import java.util.HashMap;
import java.util.Map;

import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.MemberEntity;

public interface MemberService {

	int insertMember(MemberEntity member);

	int insertMember(MemberEntity member, Address address);

	MemberEntity selectOneMember(String id);

	int selectAddress(Address address);

	int insertAddress(Address address);
	
	int updateAddress(Address address);

	int memberUpdate(Map<String, Object> param, Address address);

	int selectOneMemberCount(String id);

	int selectOneMemberNicknameCount(String nickname);

	String getAccessToken(String code);

	MemberEntity getUserInfo(String access_Token);

	int insertAuthority(String id);

}
