package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.bussiness.OrderRebate;
import com.dfyy.b2b.service.RebateService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.web.authentication.B2BUserDetails;
import com.dfyy.b2b.web.authentication.LoginUtil;

@Controller
@RequestMapping("/provider/rebates")
public class RebatesController {
	
	@Autowired
	private RebateService service;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, @RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {

		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<OrderRebate> rebates = service.getByProvider(loginUser.getId(), page, size);
		int sumcount = service.getCountByProvider(loginUser.getId());

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("rebates", rebates);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("loginUser", loginUser);

		return "rebates/index";
	}
	
	@RequestMapping(value = "/finalrebate", method = RequestMethod.POST)
	@ResponseBody
	public String finalrebate(@RequestParam(required = true) Integer id) {
		service.finalrebate(id);
		return "true";
	}

}
