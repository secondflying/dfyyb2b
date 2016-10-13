package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.UserReview;
import com.dfyy.b2b.dao.UserReviewDao;

@Service
@Transactional
public class UserReviewService {

	@Autowired
	private UserReviewDao dao;
	
	public void addLog(UserReview userReview){
		dao.save(userReview);
	}
	
	public UserReview getByUid(String uid){
		UserReview userReview = null;
		List<UserReview> userReviews = dao.getByUid(uid);
		if(userReviews!=null && userReviews.size()>0){
			userReview = userReviews.get(0);
		}
		return userReview;
	}
}
