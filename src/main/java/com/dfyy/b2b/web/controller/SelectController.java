package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dfyy.b2b.bussiness.Area;
import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.dao.AreaDao;
import com.dfyy.b2b.service.AreaService;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.service.ZoneService;

@Controller
@RequestMapping("/utils")
public class SelectController {
	
	@Autowired
	private AreaService areaService;
	@Autowired
	private CommodityService commodityService;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "/select/zones",method=RequestMethod.GET)
	public String zones(Model model){
		List<Area> zones = areaService.getAllAreas();
		model.addAttribute("zones", zones);
		return "select/zones";
	}

	@RequestMapping(value = "/select/crops",method=RequestMethod.GET)
	public String crops(Model model){
		List<CommodityType> crops = commodityService.getCommodityTypeParent();
		model.addAttribute("crops", crops);
		return "select/crops";
	}
	
	@RequestMapping(value = "/select/commoditytypes",method=RequestMethod.GET)
	public String commoditytypes(Model model){
		List<CommodityType> crops = commodityService.getTreeCommodityType();
		model.addAttribute("crops", crops);
		return "select/commoditytypes";
	}
	
	@RequestMapping(value = "/select/salesmans",method=RequestMethod.GET)
	public String salesmans(Model model){
		List<User> users = userService.getByType(4, "", new PageRequest(0, 10000));
		model.addAttribute("users", users);
		return "select/salesmans";
	}
	
	@RequestMapping(value = "/select/partners",method=RequestMethod.GET)
	public String partners(Model model){
		List<User> users = userService.getByType(2, "", new PageRequest(0, 10000));
		model.addAttribute("users", users);
		return "select/partners";
	}
}
