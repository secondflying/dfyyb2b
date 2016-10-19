package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.service.ZoneService;

@Controller
@RequestMapping("/utils")
public class SelectController {

	@Autowired
	private ZoneService zoneService;
	@Autowired
	private CommodityService commodityService;
	
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/select/zones", method = RequestMethod.GET)
	public String zones(Model model) {
		List<Zone> zones = zoneService.getAll();
		model.addAttribute("zones", zones);
		return "select/zones";
	}

	@RequestMapping(value = "/select/crops", method = RequestMethod.GET)
	public String crops(Model model) {
		List<CommodityType> crops = commodityService.getCommodityTypeParent();
		model.addAttribute("crops", crops);
		return "select/crops";
	}
}
