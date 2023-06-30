package com.hr.laraworld.ilchon.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hr.laraworld.ilchon.model.dao.IlchonDao;
import com.hr.laraworld.ilchon.model.dto.Ilchon;

import lombok.extern.slf4j.Slf4j;

@Transactional(rollbackFor = Exception.class)  // 발생하는 모든 예외에 대해 rollback 처리
@Service
@Slf4j
public class IlchonServiceImpl implements IlchonService {
	
	@Autowired
	private IlchonDao ilchonDao;

	@Override
	public int enrollIlchon(Ilchon ilchon) {
		return ilchonDao.enrollIlchon(ilchon);
	}

	@Override
	public List<Ilchon> getIlchonRequests(String memberId) {
		return ilchonDao.getIlchonRequests(memberId);
	}

	@Override
	public List<Ilchon> getIlchonList(String memberId) {
		return ilchonDao.getIlchonList(memberId);
	}

	@Override
	public Ilchon showIlchonRequest(int no) {
		return ilchonDao.showIlchonRequest(no);
	}

	@Override
	public int acceptIlchonRequest(Ilchon ilchon) {
		return ilchonDao.acceptIlchonRequest(ilchon);
	}

	@Override
	public int deleteIlchon(String no) {
		return ilchonDao.deleteIlchon(no);
	}

	@Override
	public int editIlchonName(Ilchon ilchon) {
		return ilchonDao.editIlchonName(ilchon);
	}

	@Override
	public List<Ilchon> getEditRequests(String memberId) {
		return ilchonDao.getEditRequests(memberId);
	}

	@Override
	public int acceptEditRequest(Ilchon ilchon) {
		return ilchonDao.acceptEditRequest(ilchon);
	}

	@Override
	public List<Ilchon> getAllIlchonList(String memberId) {
		return ilchonDao.getAllIlchonList(memberId);
	}


}
