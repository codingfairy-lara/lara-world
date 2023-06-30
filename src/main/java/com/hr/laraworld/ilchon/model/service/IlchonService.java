package com.hr.laraworld.ilchon.model.service;

import java.util.List;

import com.hr.laraworld.ilchon.model.dto.Ilchon;

public interface IlchonService {

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
