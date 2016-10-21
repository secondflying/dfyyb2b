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

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityReview;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.PartnerDealerService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.web.authentication.B2BUserDetails;
import com.dfyy.b2b.web.authentication.LoginUtil;

@Controller
@RequestMapping("/provider/dealers")
public class DealersController {

	@Autowired
	private CommodityService service;
	@Autowired
	private PartnerDealerService pdealerService;
	
	@RequestMapping(value = "/informal",method=RequestMethod.GET)
	public String informal(Model model,@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<Commodity> commodities = service.getInformalByPartner(loginUser.getId(), page, size);
		int sumcount = service.getInformalCountByPartner(loginUser.getId());
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("commodities", commodities);
		return "prodealers/informal";
	}
	
	@RequestMapping(value = "/check",method=RequestMethod.GET)
	public String check(Model model,@RequestParam(required = true) int id){
		Commodity commodity = service.getCommodity(id);
		List<CommodityAttachment> docs = service.getdocByCommodity(id);
		List<CommodityGradualprice> gradualprices = service.getGradualprices(commodity.getId());
		List<CommodityGradualrebate> gradualrebates = service.getGradualrebates(commodity.getId());
		int size = 0;
		if(docs!=null && docs.size()>0){
			size = docs.size();
		}
		model.addAttribute("commodity", commodity);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("size", size);
		model.addAttribute("docs", docs);
		model.addAttribute("gprices", gradualprices);
		model.addAttribute("grebates", gradualrebates);
		return "prodealers/check";		
	}
	
	@RequestMapping(value = "/verify", method = RequestMethod.POST)
	@ResponseBody
	public String verify(@RequestParam(required = true) int id,@RequestParam(required = false) String opinion) {
		Commodity commodity = service.getCommodity(id);
		commodity.setStatus(1);
		
		CommodityReview review = new CommodityReview();
		review.setOpinion(opinion);
		review.setResult(1);
		review.setStatus(0);
		review.setTime(new Date());
		review.setCid(id);
		service.checkCommodity(commodity, review);
		return "true";
	}
	
	@RequestMapping(value = "/notverify", method = RequestMethod.POST)
	@ResponseBody
	public String notverify(@RequestParam(required = true) int id,@RequestParam(required = true) String opinion) {
		Commodity commodity = service.getCommodity(id);
		commodity.setStatus(2);
		
		CommodityReview review = new CommodityReview();
		review.setOpinion(opinion);
		review.setResult(2);
		review.setStatus(0);
		review.setTime(new Date());
		review.setCid(id);
		service.checkCommodity(commodity, review);
		return "true";
	}
	
	@RequestMapping(value = "/subordinates",method=RequestMethod.GET)
	public String subordinates(Model model){
		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<PartnerDealer> partnerDealers = pdealerService.getByPid(loginUser.getId());
		model.addAttribute("pdealers", partnerDealers);
		return "prodealers/subordinates";
	}
	
	@RequestMapping(value = "/dealercommodities",method=RequestMethod.GET)
	public String dealercommodities(Model model,@RequestParam(required = true) String id,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<Commodity> commodities = service.getCommodityOfProvider(id, page, size);
		int sumcount = service.getCountCommodityOfProvider(id);

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("commodities", commodities);
		model.addAttribute("sumcount", sumcount);
		return "prodealers/dealercommodities";
	}
}
