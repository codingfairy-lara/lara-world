package com.hr.laraworld.ilchon.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hr.laraworld.ilchon.model.dto.Ilchon;

@Mapper
public interface IlchonDao {

	int enrollIlchon(Ilchon ilchon);

	List<Ilchon> getIlchonRequests(String memberId);

	List<Ilchon> getIlchonList(String memberId);

	Ilchon showIlchonRequest(int no);

	int acceptIlchonRequest(Ilchon ilchon);

	int deleteIlchon(String no);

	int editIlchonName(Ilchon ilchon);

	List<Ilchon> getEditRequests(String memberId);

	int acceptEditRequest(Ilchon ilchon);

	List<Ilchon> getAllIlchonList(String memberId);

}
