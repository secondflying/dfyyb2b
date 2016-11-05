package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.service.BrokerageService;
import com.dfyy.b2b.service.OrdersService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.web.authentication.B2BUserDetails;
import com.dfyy.b2b.web.authentication.LoginUtil;

@Controller
@RequestMapping("/provider/orders")
public class OrdersController {

	@Autowired
	private OrdersService ordersService;

	@Autowired
	private UserService userService;

	@Autowired
	private BrokerageService brokerageService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, @RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {

		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<Orders> orders = ordersService.getOrdersOfProvider(loginUser.getId(), page, size);
		int sumcount = ordersService.getCountOrdersOfProvider(loginUser.getId());

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("orders", orders);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("loginUser", loginUser);

		return "orders/index";
	}

	// @RequestMapping(value = "/info", method = RequestMethod.GET)
	// public String edit(@RequestParam(required = true) int id, Model model) {
	// model.addAttribute("imageUrl", PublicConfig.getImageUrl() +
	// "b2bcommodity/small");
	// Commodity commodity = commodityService.getCommodity(id);
	// List<CommodityAttachment> docs =
	// commodityService.getdocByCommodity(commodity.getId());
	// List<CommodityGradualprice> gradualprices =
	// commodityService.getGradualprices(commodity.getId());
	// List<CommodityGradualrebate> gradualrebates =
	// commodityService.getGradualrebates(commodity.getId());
	// List<CommodityProtective> protectives =
	// commodityService.getProtectives(commodity.getId());
	// int size = 0;
	// if (docs != null && docs.size() > 0) {
	// size = docs.size();
	// }
	// model.addAttribute("commodity", commodity);
	// model.addAttribute("docs", docs);
	// model.addAttribute("size", size);
	// model.addAttribute("gprices", gradualprices);
	// model.addAttribute("grebates", gradualrebates);
	// model.addAttribute("protectives", protectives);
	// return "orders/info";
	// }

	// @RequestMapping(value = "/delete", method = RequestMethod.POST)
	// @ResponseBody
	// public String deleteCommodity(@RequestParam(required = true) Integer id)
	// {
	// commodityService.deleteCommodity(id);
	// return "true";
	// }

}
