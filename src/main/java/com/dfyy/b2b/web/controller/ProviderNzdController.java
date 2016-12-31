package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.service.BrokerageService;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.OrdersService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.web.authentication.B2BUserDetails;
import com.dfyy.b2b.web.authentication.LoginUtil;

@Controller
@RequestMapping("/provider/buyedNzd")
public class ProviderNzdController {

	@Autowired
	private OrdersService ordersService;

	@Autowired
	private UserService userService;

	@Autowired
	private BrokerageService brokerageService;

	@Autowired
	private CommodityService commodityService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, @RequestParam(required = false) Integer isnear,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {

		B2BUserDetails loginUser = LoginUtil.getLoginUser();

		boolean near = isnear != null && isnear == 1;
		if (!near) {
			List<Orders> orders = ordersService.getConfirmedOfProvider(loginUser.getId(), page, size);
			int sumcount = ordersService.getConfirmedOfProviderCount(loginUser.getId());
			model.addAttribute("orders", orders);
			model.addAttribute("sumcount", sumcount);
		} else {
			List<Orders> orders = ordersService.getNearProtectionOfProvider(loginUser.getId(), 7, page, size);
			int sumcount = ordersService.getNearProtectionOfProviderCount(loginUser.getId(), 7);
			model.addAttribute("orders", orders);
			model.addAttribute("sumcount", sumcount);
		}

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("loginUser", loginUser);
		return "buyedNzd/index";
	}

	@RequestMapping(value = "/extendProtectionConfirm", method = RequestMethod.POST)
	@ResponseBody
	public String extendProtectionConfirm(@RequestParam(required = true) Integer id) {
		ordersService.extendProtectionConfirm(id);
		return "true";
	}

	@RequestMapping(value = "/extendProtectionBack", method = RequestMethod.POST)
	@ResponseBody
	public String extendProtectionBack(@RequestParam(required = true) Integer id) {
		ordersService.extendProtectionBack(id);
		return "true";
	}

	@RequestMapping(value = "/setProtection", method = RequestMethod.POST)
	@ResponseBody
	public String setProtection(@RequestParam(required = true) Integer id, @RequestParam(required = true) int days,
			@RequestParam(required = true) double radius) {
		ordersService.setProtection(id, days, radius);
		return "true";
	}

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String index(Model model) {
		return "buyedNzd/info";
	}

	@RequestMapping(value = "/competitors", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public List<Orders> Competitors(@RequestParam int oid, @RequestParam double size) {
		return ordersService.getCompetitors(oid, size);
	}

}
