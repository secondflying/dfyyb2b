package com.dfyy.b2b.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.service.ZoneService;

@Controller
@RequestMapping("/utils")
public class SelectController {
	
	@Autowired
	private ZoneService zoneService;
	
	@RequestMapping(value = "/select/zones",method=RequestMethod.GET)
	public String zones(Model model){
		List<Zone> zones = zoneService.getAll();
		model.addAttribute("zones", zones);
		return "select/zones";
	}

}
