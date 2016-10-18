//package com.dfyy.b2b.web.controller;
//
//import java.io.IOException;
//import java.util.List;
//import java.util.Map;
//
//import javax.servlet.ServletException;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.commons.lang.StringUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.multipart.MultipartHttpServletRequest;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
//import com.dfyy.b2b.bussiness.Commodity;
//import com.dfyy.b2b.bussiness.SUser;
//import com.dfyy.b2b.service.CommodityService;
//import com.dfyy.b2b.service.UserService;
//import com.dfyy.b2b.util.PublicConfig;
//import com.dfyy.b2b.util.PublicHelper;
//import com.dfyy.b2b.web.authentication.AdminUserDetails;
//import com.dfyy.b2b.web.authentication.B2BUserDetails;
//import com.dfyy.b2b.web.authentication.LoginUtil;
//
//@Controller
//@RequestMapping("/provider/commodities")
//public class CommodityController {
//
//	@Autowired
//	private CommodityService commodityService;
//
//	@Autowired
//	private UserService userService;
//
//	@RequestMapping(value = "/index", method = RequestMethod.GET)
//	public String index(Model model) {
//
//		B2BUserDetails loginUser = LoginUtil.getLoginUser();
//		List<Commodity> commodities = commodityService.getCommodityOfProvider(loginUser.getId());
//		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "commodities/small");
//		model.addAttribute("commodities", commodities);
//		return "commodities/index";
//
//	}
//
//	@RequestMapping(value = "/edit", method = RequestMethod.GET)
//	public String edit(@RequestParam(required = false) String id, Model model) {
//		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "commodities/small");
//		if (!StringUtils.isBlank(id)) {
//			Commodity commodity = commodityService.getCommodity(Integer.parseInt(id));
//			model.addAttribute("commodity", commodity);
//			return "commodities/edit";
//		} else {
//			return "commodities/add";
//		}
//
//	}
//
//	@RequestMapping(value = "/addone", method = RequestMethod.POST)
//	public String addOne(@ModelAttribute("commodity") CommodityDto dto) {
//
//		if (dto != null) {
//			commodityService.create(dto);
//			AdminUserDetails loginUser = LoginUtil.getLoginUser();
//			if (loginUser != null) {
//				logService.addLog(loginUser.getId(), "新增积分商城产品(" + dto.getName() + ")");
//			}
//			return "redirect:index";
//		} else {
//			return "commodities/add";
//		}
//
//	}
//
//	@RequestMapping(value = "/editone", method = RequestMethod.POST)
//	public String editOne(@ModelAttribute("commodity2") CommodityDto dto, RedirectAttributes redirectAttributes) {
//
//		if (dto != null) {
//			commodityService.edit(dto);
//			AdminUserDetails loginUser = LoginUtil.getLoginAdmin();
//			if (loginUser != null) {
//				logService.addLog(loginUser.getId(), "更新积分商城产品(" + dto.getName() + ")");
//			}
//			redirectAttributes.addFlashAttribute("read", "1");
//			return "redirect:index";
//		} else {
//			return "commodities/edit";
//		}
//
//	}
//
//	@RequestMapping(value = "/delete", method = RequestMethod.POST)
//	@ResponseBody
//	public String deleteCommodity(@RequestParam(required = true) Integer id) {
//		commodityService.deleteCommodity(id);
//		AdminUserDetails loginUser = LoginUtil.getLoginAdmin();
//		if (loginUser != null) {
//			logService.addLog(loginUser.getId(), "删除积分商城产品(" + id + ")");
//		}
//		return "true";
//	}
//
//	@RequestMapping(value = "/bash", method = RequestMethod.POST)
//	@ResponseBody
//	public String bashImport(HttpServletRequest request, HttpServletResponse response) throws IllegalStateException,
//			IOException, ServletException {
//		String imageName = "";
//		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
//		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
//			MultipartFile mFile = entity.getValue();
//			String imagename = mFile.getOriginalFilename();
//			String format = imagename.substring(imagename.lastIndexOf(".") + 1);
//
//			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "commodities");
//		}
//		return imageName;
//	}
//
//}
