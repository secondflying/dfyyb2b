package com.dfyy.b2b.web.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dfyy.b2b.bussiness.CommodityTag;
import com.dfyy.b2b.bussiness.CommodityType;
import com.dfyy.b2b.bussiness.CommodityUnit;
import com.dfyy.b2b.bussiness.PpBrokerage;
import com.dfyy.b2b.bussiness.SalesmanBrokerage;
import com.dfyy.b2b.dto.ProkerageDto;
import com.dfyy.b2b.service.BrokerageService;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;

@Controller
@RequestMapping("/manager")
public class ParametersController {
	
	@Autowired
	private CommodityService service;
	@Autowired
	private BrokerageService brokerService;

	@RequestMapping(value = "/parameters/commoditytype",method=RequestMethod.GET)
	public String formal(Model model){
		List<CommodityType> crops = service.getTreeCommodityType();
		model.addAttribute("crops", crops);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "crop/small");
		return "b2bparameters/commoditytype";
	}
	
	@RequestMapping(value = "/parameters/newcrop",method=RequestMethod.GET)
	public String newcrop(Model model){
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "crop/small");
		return "b2bparameters/newcrop";
	}
	
	@RequestMapping(value = "/parameters/addcrop", method = RequestMethod.POST)
	public String editOne(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String category = multipartRequest.getParameter("category");
		String image = multipartRequest.getParameter("image");		
		CommodityType type = new CommodityType();
		type.setName(name);
		int c=-1;
		if(!StringUtil.isBlank(category)){
			c = Integer.parseInt(category);
		}
		type.setCategory(c);
		type.setImage(image);
		type.setStatus(0);
		service.saveCrop(type);
		
		return "redirect:commoditytype";
	}
	
	@RequestMapping(value = "/parameters/editcrop",method=RequestMethod.GET)
	public String newcrop(Model model,@RequestParam(required = true) int id){
		CommodityType crop = service.getById(id);
		String cname = "";
		if(crop.getCategory()!=-1){
			CommodityType cType = service.getById(crop.getCategory());
			cname = cType.getName();
		}
		model.addAttribute("crop", crop);
		model.addAttribute("cname", cname);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "crop/small");
		return "b2bparameters/editcrop";
	}
	
	@RequestMapping(value = "/parameters/editcrop", method = RequestMethod.POST)
	public String editcrop(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String cname = multipartRequest.getParameter("cname");
		String category = multipartRequest.getParameter("category");
		String image = multipartRequest.getParameter("image");	
		int id = Integer.parseInt(multipartRequest.getParameter("id").toString());
		CommodityType type = service.getById(id);
		type.setName(name);
		int c=-1;
		if(!StringUtil.isBlank(category) && !StringUtil.isBlank(cname)){
			c = Integer.parseInt(category);
		}
		type.setCategory(c);
		type.setImage(image);
		type.setStatus(0);
		service.saveCrop(type);
		
		return "redirect:commoditytype";
	}
	
	@RequestMapping(value = "/parameters/deletecrop", method = RequestMethod.POST)
	@ResponseBody
	public String deletecrop(@RequestParam(required = true) Integer id) {
		service.deleteCrop(id);
		return "true";
	}
	
	@RequestMapping(value = "/parameters/tags",method=RequestMethod.GET)
	public String tags(Model model){
		List<CommodityTag> tags = service.getAllCommodityTags();
		model.addAttribute("tags", tags);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "tag/small");
		return "b2bparameters/tags";
	}
	
	@RequestMapping(value = "/parameters/newtag",method=RequestMethod.GET)
	public String newtag(Model model){
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "tag/small");
		return "b2bparameters/newtag";
	}
	
	@RequestMapping(value = "/parameters/addtag", method = RequestMethod.POST)
	public String addtag(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String image = multipartRequest.getParameter("image");		
		CommodityTag tag = new CommodityTag();
		tag.setName(name);
		tag.setImage(image);
		tag.setStatus(0);
		service.saveTag(tag);
		
		return "redirect:tags";
	}
	
	@RequestMapping(value = "/parameters/edittag",method=RequestMethod.GET)
	public String edittag(Model model,@RequestParam(required = true) int id){
		CommodityTag tag = service.getTagById(id);
		model.addAttribute("tag", tag);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "tag/small");
		return "b2bparameters/edittag";
	}
	
	@RequestMapping(value = "/parameters/edittag", method = RequestMethod.POST)
	public String edittag(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String image = multipartRequest.getParameter("image");	
		int id = Integer.parseInt(multipartRequest.getParameter("id").toString());
		CommodityTag tag = service.getTagById(id);
		tag.setName(name);
		tag.setImage(image);
		tag.setStatus(0);
		service.saveTag(tag);
		
		return "redirect:tags";
	}
	
	@RequestMapping(value = "/parameters/deletetag", method = RequestMethod.POST)
	@ResponseBody
	public String deletetag(@RequestParam(required = true) Integer id) {
		service.deleteTag(id);
		return "true";
	}
	
	@RequestMapping(value = "/parameters/units",method=RequestMethod.GET)
	public String units(Model model){
		List<CommodityUnit> units = service.getAllCommodityUnits();
		model.addAttribute("units", units);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "unit/small");
		return "b2bparameters/units";
	}
	
	@RequestMapping(value = "/parameters/newunit",method=RequestMethod.GET)
	public String newunit(Model model){
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "unit/small");
		return "b2bparameters/newunit";
	}
	
	@RequestMapping(value = "/parameters/addunit", method = RequestMethod.POST)
	public String addunit(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String image = multipartRequest.getParameter("image");		
		CommodityUnit unit = new CommodityUnit();
		unit.setName(name);
		unit.setImage(image);
		unit.setStatus(0);
		service.saveUnit(unit);
		
		return "redirect:units";
	}
	
	@RequestMapping(value = "/parameters/editunit",method=RequestMethod.GET)
	public String editunit(Model model,@RequestParam(required = true) int id){
		CommodityUnit unit = service.getUnitById(id);
		model.addAttribute("unit", unit);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "unit/small");
		return "b2bparameters/editunit";
	}
	
	@RequestMapping(value = "/parameters/editunit", method = RequestMethod.POST)
	public String editunit(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String name = multipartRequest.getParameter("name");
		String image = multipartRequest.getParameter("image");	
		int id = Integer.parseInt(multipartRequest.getParameter("id").toString());
		CommodityUnit unit = service.getUnitById(id);
		unit.setName(name);
		unit.setImage(image);
		unit.setStatus(0);
		service.saveUnit(unit);
		
		return "redirect:units";
	}
	
	@RequestMapping(value = "/parameters/deleteunit", method = RequestMethod.POST)
	@ResponseBody
	public String deleteunit(@RequestParam(required = true) Integer id) {
		service.deleteUnit(id);
		return "true";
	}
	
	@RequestMapping(value = "/parameters/brokerages",method=RequestMethod.GET)
	public String brokerages(Model model){
		List<ProkerageDto> objectss = brokerService.getByAllCrops();
		SalesmanBrokerage sage = brokerService.getSalesmanBrokerage();
		model.addAttribute("objects", objectss);
		model.addAttribute("sage", sage);
		return "b2bparameters/brokerages";
	}
	
	@RequestMapping(value = "/parameters/editppbrokerage", method = RequestMethod.POST)
	public String editppbrokerage(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws IllegalStateException, IOException, ServletException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String cid = multipartRequest.getParameter("cid");
		String pl = multipartRequest.getParameter("platform");
		String pa = multipartRequest.getParameter("partner");
		int crid = Integer.parseInt(cid);
		PpBrokerage ppBrokerage = brokerService.getByCrop(crid);
		if(ppBrokerage!=null){
			brokerService.delete(ppBrokerage.getId());
		}
		ppBrokerage = new PpBrokerage();
		CommodityType commodityType = new CommodityType();
		commodityType.setId(crid);
		ppBrokerage.setCrop(commodityType);
		ppBrokerage.setPlatform(pl==null?0:Double.parseDouble(pl));
		ppBrokerage.setPartner(pa==null?0:Double.parseDouble(pa));
		ppBrokerage.setTime(new Date());
		ppBrokerage.setStatus(0);
		brokerService.save(ppBrokerage);
		redirectAttributes.addFlashAttribute("success", "编辑成功");
		return "redirect:brokerages";
	}
	
	@RequestMapping(value = "/parameters/editsalesmanbrokerage", method = RequestMethod.POST)
	public String editsalesmanbrokerage(HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes)
			throws IllegalStateException, IOException, ServletException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		String mi = multipartRequest.getParameter("min");
		String ma = multipartRequest.getParameter("max");
		SalesmanBrokerage salesmanBrokerage = brokerService.getSalesmanBrokerage();
		if(salesmanBrokerage!=null){
			brokerService.deleteS(salesmanBrokerage.getId());
		}
		salesmanBrokerage = new SalesmanBrokerage();
		salesmanBrokerage.setMin(mi==null?0:Double.parseDouble(mi));
		salesmanBrokerage.setMax(ma==null?0:Double.parseDouble(ma));
		salesmanBrokerage.setTime(new Date());
		salesmanBrokerage.setStatus(0);
		brokerService.saveS(salesmanBrokerage);
		redirectAttributes.addFlashAttribute("success", "编辑成功");
		return "redirect:brokerages";
	}
	
	@RequestMapping(value = "/parameters/bash", method = RequestMethod.POST)
	@ResponseBody
	public String bashImport(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,
			IOException, ServletException {
		String imageName = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile mFile = entity.getValue();
			String imagename = mFile.getOriginalFilename();
			String format = imagename.substring(imagename.lastIndexOf(".") + 1);

			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "crop");
		}
		return imageName;
	}
	
	@RequestMapping(value = "/parameters/tagbash", method = RequestMethod.POST)
	@ResponseBody
	public String tagbashImport(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,
			IOException, ServletException {
		String imageName = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile mFile = entity.getValue();
			String imagename = mFile.getOriginalFilename();
			String format = imagename.substring(imagename.lastIndexOf(".") + 1);

			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "tag");
		}
		return imageName;
	}
	
	@RequestMapping(value = "/parameters/unitbash", method = RequestMethod.POST)
	@ResponseBody
	public String unitbashImport(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,
			IOException, ServletException {
		String imageName = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile mFile = entity.getValue();
			String imagename = mFile.getOriginalFilename();
			String format = imagename.substring(imagename.lastIndexOf(".") + 1);

			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "unit");
		}
		return imageName;
	}
}
