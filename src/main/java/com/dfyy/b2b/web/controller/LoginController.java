package com.dfyy.b2b.web.controller;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.dto.CheckResult;
import com.dfyy.b2b.service.RegisterCodeService;
import com.dfyy.b2b.service.SMSService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicHelper;
import com.dfyy.b2b.web.form.RetisterForm;

@Controller
public class LoginController {
	@Autowired
	private UserService userService;

	@Autowired
	private SMSService smsService;

	@Autowired
	private RegisterCodeService codeService;

	@RequestMapping("/login")
	public String login(Model model) {
		return "login";
	}
	
	@RequestMapping("/mlogin")
	public String mlogin(Model model) {
		return "mlogin";
	}
	
	@RequestMapping("/test")
	public String test(Model model) {
		return "test";
	}

	@RequestMapping("/register")
	public String register(Model model) {
		return "register";
		
	}

	@RequestMapping(value = "/checkcode", method = RequestMethod.POST)
	@ResponseBody
	public CheckResult confirmOrder(@RequestParam(required = true) String phone, @RequestParam(defaultValue = "0") int n) {

		if (!PublicHelper.isMobile(phone)) {
			throw new WebApplicationException(Response.status(Response.Status.NOT_FOUND).entity("不是有效的手机号码")
					.type(MediaType.TEXT_PLAIN).build());
		}

		String code = PublicHelper.game(4);

//		// 为1时默认用互亿发送
//		if (1 == 1) {
//			if (n % 2 == 0) {
//				smsService.sendsms(phone, code);
//			} else {
//				smsService.sendsms2(phone, code);
//			}
//		} else {
//			if (n % 2 == 0) {
//				smsService.sendsms2(phone, code);
//			} else {
//				smsService.sendsms(phone, code);
//			}
//		}

		// 将手机号和验证码存到数据库，用于
		codeService.add(phone, code);
		return new CheckResult(true);
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(@ModelAttribute("register") RetisterForm form, Model model) {
		try {
			userService.register(form);
			// 注册用户
			return "redirect:login";
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			return "register";
		}

	}

	@RequestMapping("/errors/403")
	public String error() {
		return "errors/403";
	}
	
	
	
	@RequestMapping(value = "/checkcode2", method = RequestMethod.GET)
	@ResponseBody
	public CheckResult confirmOrder1() {
		return new CheckResult(false);
	}

}
