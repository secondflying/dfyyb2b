package com.dfyy.b2b.web.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityReview;
import com.dfyy.b2b.bussiness.CommodityUnit;
import com.dfyy.b2b.bussiness.SalesmanBrokerage;
import com.dfyy.b2b.service.BrokerageService;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;
import com.dfyy.b2b.web.authentication.B2BUserDetails;
import com.dfyy.b2b.web.authentication.LoginUtil;
import com.dfyy.b2b.web.form.CommodityForm;

@Controller
@RequestMapping("/provider/commodities")
public class CommodityController {

	@Autowired
	private CommodityService commodityService;

	@Autowired
	private UserService userService;
	
	@Autowired
	private BrokerageService brokerageService;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, @RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {

		B2BUserDetails loginUser = LoginUtil.getLoginUser();
		List<Commodity> commodities = commodityService.getCommodityOfProvider(loginUser.getId(), page, size);
		int sumcount = commodityService.getCountCommodityOfProvider(loginUser.getId());

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("commodities", commodities);
		model.addAttribute("sumcount", sumcount);
		return "commodities/index";
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(@RequestParam(required = false) String id, Model model) {
		SalesmanBrokerage salesmanBrokerage = brokerageService.getSalesmanBrokerage();
		String strbrokerage = "";
		if(salesmanBrokerage!=null){
			model.addAttribute("min",salesmanBrokerage.getMin());
			model.addAttribute("max",salesmanBrokerage.getMax());
			strbrokerage=salesmanBrokerage.getMin()+"--"+salesmanBrokerage.getMax();
		}
		model.addAttribute("strbrokerage", strbrokerage);
		List<CommodityUnit> units = commodityService.getAllCommodityUnits();
		model.addAttribute("units", units);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		if (!StringUtils.isBlank(id)) {
			Commodity commodity = commodityService.getCommodity(Integer.parseInt(id));
			List<CommodityAttachment> docs = commodityService.getdocByCommodity(commodity.getId());
			List<CommodityGradualprice> gradualprices = commodityService.getGradualprices(commodity.getId());
			List<CommodityGradualrebate> gradualrebates = commodityService.getGradualrebates(commodity.getId());
			if(commodity.getStatus()==2 || commodity.getStatus()==4){
				CommodityReview review = commodityService.getReviews(commodity.getId());
				model.addAttribute("review", review);
			}
			model.addAttribute("commodity", commodity);
			model.addAttribute("docs", docs);
			model.addAttribute("gprices", gradualprices);
			model.addAttribute("grebates", gradualrebates);
			return "commodities/edit";
		} else {
			return "commodities/add";
		}

	}

	@RequestMapping(value = "/addone", method = RequestMethod.POST)
	public String addOne(@ModelAttribute("commodity") CommodityForm dto) {
		B2BUserDetails loginUser = LoginUtil.getLoginUser();

		if (dto != null) {
			// 如果是经销商，初始状态为0，需要合伙人再审核一次
			if (loginUser.getType().getId() == 1) {
				dto.setStatus(0);
			} else {
				dto.setStatus(1);
			}
			dto.setUserid(loginUser.getId());
			commodityService.createCommodity(dto);
			return "redirect:index";
		} else {
			return "commodities/add";
		}

	}

	@RequestMapping(value = "/editone", method = RequestMethod.POST)
	public String editOne(@ModelAttribute("commodity2") CommodityForm dto, RedirectAttributes redirectAttributes) {
		B2BUserDetails loginUser = LoginUtil.getLoginUser();

		if (dto != null) {
			// 如果是经销商，初始状态为0，需要合伙人再审核一次
			if (loginUser.getType().getId() == 1) {
				dto.setStatus(0);
			} else {
				dto.setStatus(1);
			}
			commodityService.editCommodity(dto);
			return "redirect:index";
		} else {
			return "commodities/edit";
		}

	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String deleteCommodity(@RequestParam(required = true) Integer id) {
		commodityService.deleteCommodity(id);
		return "true";
	}

	@RequestMapping(value = "/bash", method = RequestMethod.POST)
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

			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "b2bcommodity");
		}
		return imageName;
	}

}
