package com.dfyy.b2b.web.controller;
import java.io.IOException;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserDoc;
import com.dfyy.b2b.bussiness.UserType;
import com.dfyy.b2b.service.UserContext;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.service.UserTypeService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;
@Controller
@RequestMapping("/provider")
public class ProInfoController {

	@Autowired
	private UserContext userContext;
	@Autowired
	private UserService userService;
	@Autowired
	private UserTypeService typeService;
	
	
	@RequestMapping(value = "/proinfo/info",method=RequestMethod.GET)
	public String index(Model model){
		User user = userContext.getCurrentUser();
		user = userService.getById(user.getId());		
		if(user.getType()==null){
			return "redirect:perfect";
		}
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("user", user);
		model.addAttribute("size", size);
		return "proinfo/info";
	}
	
	@RequestMapping(value = "/proinfo/perfect",method=RequestMethod.GET)
	public String perfect(Model model){
		User user = userContext.getCurrentUser();
		user = userService.getById(user.getId());
		List<UserType> types = typeService.getProvider();
		model.addAttribute("user", user);
		model.addAttribute("types", types);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		return "proinfo/perfect";
	}
	
	@RequestMapping(value = "/proinfo/perfect", method = RequestMethod.POST)
	public String perfectUser(@ModelAttribute("user") User user) {
		if (user != null) {
			User u = userService.getById(user.getId());
			user.setPhone(u.getPhone());
			user.setPassword(u.getPassword());
			user.setTime(new Date());
			user.setStatus(0);
			userService.update(user);
			if(user.getDocs()!=null && user.getDocs().size()>0){
				for (Iterator iterator = user.getDocs().iterator(); iterator.hasNext();) {
					UserDoc doc = (UserDoc) iterator.next();
					doc.setUid(user.getId());
					doc.setStatus(0);
					userService.saveDoc(doc);
				}
			}
			return "redirect:info";
		} else {
			return "proinfo/perfect";
		}
	}
	
	@RequestMapping(value = "/proinfo/bash", method = RequestMethod.POST)
	@ResponseBody
	public String proinfobashImport(HttpServletRequest request, HttpServletResponse response)
			throws IllegalStateException, IOException, ServletException {
		String imageName = "";
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile mFile = entity.getValue();
			String imagename = mFile.getOriginalFilename();
			String format = imagename.substring(imagename.lastIndexOf(".") + 1);
			imageName = PublicHelper.saveImage1(mFile.getInputStream(), format, "providers");
		}
		return imageName;
	}
}
