package com.dfyy.b2b.web.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.helper.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityProtective;
import com.dfyy.b2b.bussiness.CommodityReview;
import com.dfyy.b2b.bussiness.CommodityTag;
import com.dfyy.b2b.dto.CommodityTagDto;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.util.PublicConfig;

@Controller
@RequestMapping("/manager/commodities")
public class B2BCommodityController {
	
	@Autowired
	private CommodityService service;

	@RequestMapping(value = "/informal",method=RequestMethod.GET)
	public String informal(Model model,@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		List<Commodity> commodities = service.getCommoditiesByStatus(1, page, size);
		int sumcount = service.getCommoditiesCountByStatus(1);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("commodities", commodities);
		return "b2bcommodities/informal";
	}
	
	@RequestMapping(value = "/checked",method=RequestMethod.GET)
	public String checked(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		List<Commodity> commodities;
		int sumcount;
		if(!StringUtil.isBlank(keyword)){
			commodities = service.findCommoditiesByStatus(keyword, 3, page, size);
			sumcount = service.findCommoditiesCountByStatus(keyword, 3);
		}
		else{
			commodities = service.getCommoditiesByStatus(3, page, size);
			sumcount = service.getCommoditiesCountByStatus(3);
		}
		
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("commodities", commodities);
		return "b2bcommodities/checked";
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
		return "b2bcommodities/check";		
	}
	
	@RequestMapping(value = "/verify", method = RequestMethod.POST)
	@ResponseBody
	public String verify(@RequestParam(required = true) int id,@RequestParam(required = false) String opinion) {
		Commodity commodity = service.getCommodity(id);
		commodity.setStatus(3);
		
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
		commodity.setStatus(4);
		
		CommodityReview review = new CommodityReview();
		review.setOpinion(opinion);
		review.setResult(2);
		review.setStatus(0);
		review.setTime(new Date());
		review.setCid(id);
		service.checkCommodity(commodity, review);
		return "true";
	}
	
	@RequestMapping(value = "/info",method=RequestMethod.GET)
	public String info(Model model,@RequestParam(required = true) int id){
		Commodity commodity = service.getCommodityFull(id);
		List<CommodityAttachment> docs = commodity.getAttachments();
		List<CommodityGradualprice> gradualprices = commodity.getGradualprices();
		List<CommodityGradualrebate> gradualrebates = commodity.getGradualrebates();
		List<CommodityProtective> protectives = commodity.getProtectives();
		List<CommodityTag> tags = commodity.getTags();
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
		model.addAttribute("protectives", protectives);
		model.addAttribute("tags", tags);
		return "b2bcommodities/info";		
	}
	
	@RequestMapping(value = "/tagsmanager",method=RequestMethod.GET)
	public String tagsmanager(Model model,@RequestParam(required = true) int cid){
		List<CommodityTagDto> dtos = new ArrayList<>();
		Commodity commodity = service.getCommodityFull(cid);
		List<CommodityTag> allTags = service.getAllCommodityTags();
		Set<Integer> owed = new HashSet<Integer>();
		for (CommodityTag tag : commodity.getTags()) {
			owed.add(tag.getId());
		}
		for (int i = 0; i < allTags.size(); i++) {
			CommodityTag tag = allTags.get(i);
			CommodityTagDto commodityTagDto = new CommodityTagDto();
			commodityTagDto.setId(tag.getId());
			commodityTagDto.setName(tag.getName());
			commodityTagDto.setImage(tag.getImage());
			if (owed.contains(tag.getId())) {
				commodityTagDto.setHasright(true);
			} else {
				commodityTagDto.setHasright(false);
			}
			commodityTagDto.setColumn(i % 4);
			dtos.add(commodityTagDto);
		}
		model.addAttribute("cid", commodity.getId());
		model.addAttribute("lists", dtos);
		return "b2bcommodities/tagsmanager";		
	}
	
	@RequestMapping(value = "/commoditytagsedit", method = RequestMethod.POST)
	public String commoditytagsedit(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(required = true) Integer cid, @RequestParam(required = true) String[] biaoqian,
			RedirectAttributes redirectAttributes) throws IllegalStateException, IOException, ServletException {

		if (biaoqian != null) {
			List<Integer> tids = new ArrayList<Integer>();
			for (String string : biaoqian) {
				int tid = Integer.parseInt(string);
				tids.add(tid);
			}
			service.addTagsToCommodity(cid, tids);
		}
		return "redirect:info?id="+cid;
	}
}
