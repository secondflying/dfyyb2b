package com.dfyy.b2b.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserReview;
import com.dfyy.b2b.bussiness.UserType;
import com.dfyy.b2b.service.UserReviewService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;

@Controller
@RequestMapping("/manager")
public class UsersController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserReviewService reviewService;
	
	@RequestMapping(value = "/users/formal",method=RequestMethod.GET)
	public String formal(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getFormal(keyword,new PageRequest(page, size));
		int sumcount = userService.getCountByStatus(1,keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/formal";
	}
	
	@RequestMapping(value = "/users/informal",method=RequestMethod.GET)
	public String informal(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getInformal(keyword,new PageRequest(page, size));
		int sumcount = userService.getCountByStatus(0,keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/informal";
	}
	
	@RequestMapping(value = "/users/info",method=RequestMethod.GET)
	public String edit(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		return "b2busers/info";
	}
	
	@RequestMapping(value = "/users/check",method=RequestMethod.GET)
	public String check(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		return "b2busers/check";
	}
	
	@RequestMapping(value = "/users/verify", method = RequestMethod.POST)
	@ResponseBody
	public String verify(@RequestParam(required = true) String id,@RequestParam(required = false) String opinion) {
		User user = userService.getById(id);
		user.setStatus(1);
		userService.update(user);
		
		UserReview userReview = new UserReview();
		userReview.setOpinion(opinion);
		userReview.setResult(1);
		userReview.setStatus(0);
		userReview.setTime(new Date());
		userReview.setUid(id);
		reviewService.addLog(userReview);
		return "true";
	}
	
	@RequestMapping(value = "/users/notverify", method = RequestMethod.POST)
	@ResponseBody
	public String notverify(@RequestParam(required = true) String id,@RequestParam(required = true) String opinion) {
		User user = userService.getById(id);
		user.setStatus(2);
		userService.update(user);
		
		UserReview userReview = new UserReview();
		userReview.setOpinion(opinion);
		userReview.setResult(2);
		userReview.setStatus(0);
		userReview.setTime(new Date());
		userReview.setUid(id);
		reviewService.addLog(userReview);
		return "true";
	}
}
