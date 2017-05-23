package com.dfyy.b2b.web.controller;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.OrderBrokerage;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.service.BrokerageService;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.OrdersService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;
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

	@Autowired
	private CommodityService commodityService;

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

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public String info(Model model, @RequestParam(required = true) int id) {

		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		Orders orders = ordersService.getSingle(id);
		double totalprice = 0;
		totalprice = PublicHelper.correctTo(orders.getCount() * orders.getPrice());
		List<CommodityAttachment> docs = commodityService.getdocByCommodity(orders.getCommodity().getId());
		int size = 0;
		if (docs != null && docs.size() > 0) {
			size = docs.size();
		}
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("docs", docs);
		model.addAttribute("order", orders);
		model.addAttribute("size", size);
		model.addAttribute("totalprice", totalprice);
		if (orders.getStatus() == 3) {
			OrderBrokerage orderBrokerage = ordersService.getBrokerageByOid(orders.getId());
			model.addAttribute("brokerage", orderBrokerage);
		}

		return "orders/info";
	}

	@RequestMapping(value = "/confirmsend", method = RequestMethod.POST)
	@ResponseBody
	public String confirmsend(@RequestParam(required = true) Integer id) {
		ordersService.confirmSend(id);
		return "true";
	}

	@RequestMapping(value = "/confirmarrival", method = RequestMethod.POST)
	@ResponseBody
	public String confirmarrival(@RequestParam(required = true) Integer id) {
		ordersService.confirmArrival(id);
		return "true";
	}

	@RequestMapping(value = "/backstop", method = RequestMethod.POST)
	@ResponseBody
	public String backstop(@RequestParam(required = true) Integer id) {
		ordersService.backStop(id);
		return "true";
	}

	@RequestMapping(value = "/backpass", method = RequestMethod.POST)
	@ResponseBody
	public String backpass(@RequestParam(required = true) Integer id) {
		ordersService.backPass(id);
		return "true";
	}

	@RequestMapping(value = "/newOrders", method = RequestMethod.GET)
	@ResponseBody
	public List<Orders> newOrders(Model model, @RequestParam(required = true) long time) {
		Date date = new Date(time);
		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<Orders> orders = ordersService.getNewOrdersOfProvider(loginUser.getId(), date);
		return orders;
	}

}
