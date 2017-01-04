package com.msg.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.msg.dao.TestDAO;

@Service
public class TestService {

	@Autowired private SqlSession sqlsession;
	
	public int getBoardCount(){
		int result = 0;
		TestDAO dao = sqlsession.getMapper(TestDAO.class);
		result = dao.getBoardCount();
		System.out.println("게시글 갯수(Mybatis Test : " + result);
		return result;
	}
}
