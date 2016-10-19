package com.dfyy.b2b.web.controller;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.repository.query.parser.Part;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfyy.b2b.bussiness.Area;
import com.dfyy.b2b.bussiness.BasicUser;
import com.dfyy.b2b.bussiness.PartnerDealer;
import com.dfyy.b2b.bussiness.ProviderZone;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.bussiness.SalesmanZone;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserReview;
import com.dfyy.b2b.bussiness.UserType;
import com.dfyy.b2b.service.PartnerDealerService;
import com.dfyy.b2b.service.ProviderZoneService;
import com.dfyy.b2b.service.SUserService;
import com.dfyy.b2b.service.SalesmanZoneService;
import com.dfyy.b2b.service.SalesmanstoreService;
import com.dfyy.b2b.service.UserReviewService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.util.PublicConfig;

@Controller
@RequestMapping("/manager")
public class UsersController {

	@Autowired
	private UserService userService;
	@Autowired
	private UserReviewService reviewService;
	@Autowired
	private SUserService suserService;
	@Autowired
	private SalesmanZoneService szoneService;
	@Autowired
	private SalesmanstoreService sstoreService;
	@Autowired
	private PartnerDealerService pdealerService;
	@Autowired
	private ProviderZoneService pzoneService;
	
	@RequestMapping(value = "/users/partners",method=RequestMethod.GET)
	public String formal(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getByType(2, keyword, new PageRequest(page, size));
		int sumcount = userService.getCountByType(2, keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/partners";
	}
	
	@RequestMapping(value = "/users/dealers",method=RequestMethod.GET)
	public String dealers(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getByType(1, keyword, new PageRequest(page, size));
		int sumcount = userService.getCountByType(1, keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/dealers";
	}
	
	@RequestMapping(value = "/users/manufacturers",method=RequestMethod.GET)
	public String manufacturers(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getByType(3, keyword, new PageRequest(page, size));
		int sumcount = userService.getCountByType(3, keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/manufacturers";
	}
	
	@RequestMapping(value = "/users/salesmans",method=RequestMethod.GET)
	public String salesmans(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getByType(4, keyword, new PageRequest(page, size));
		int sumcount = userService.getCountByType(4, keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/salesmans";
	}
	
	@RequestMapping(value = "/users/stores",method=RequestMethod.GET)
	public String stores(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		keyword = StringUtils.trim(keyword);

		List<SUser> users = suserService.getAllNzd(keyword, page, size);
		int sumcount = suserService.getAllNzdCount(keyword);

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "users/small");
		model.addAttribute("users", users);
		model.addAttribute("sumcount", sumcount);
		return "b2busers/stores";
	}
	
	@RequestMapping(value = "/users/informal",method=RequestMethod.GET)
	public String informal(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		List<User> users = userService.getInformal(keyword,new PageRequest(page, size));
		int sumcount = userService.getCountByStatus(0,keyword);
		model.addAttribute("sumcount", sumcount);
		model.addAttribute("users", users);
		return "b2busers/informal";
	}
	
	@RequestMapping(value = "/users/info",method=RequestMethod.GET)
	public String edit(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		return "b2busers/info_"+user.getType().getId();
	}
	
	@RequestMapping(value = "/users/manufactureinfo",method=RequestMethod.GET)
	public String manufactureinfo(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		List<ProviderZone> zones = pzoneService.getByUid(user.getId());
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		model.addAttribute("zones",zones);
		return "b2busers/info_3";
	}
	
	/**
	 * 合伙人信息
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/users/partnerinfo",method=RequestMethod.GET)
	public String partnerinfo(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		List<PartnerDealer> pDealers = pdealerService.getByPid(user.getId());
		List<ProviderZone> zones = pzoneService.getByUid(user.getId());
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		model.addAttribute("pdealers", pDealers);
		model.addAttribute("zones", zones);
		return "b2busers/info_2";
	}
	
	/**
	 * 业务员信息
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/users/salesmaninfo",method=RequestMethod.GET)
	public String salesmaninfo(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		List<SalesmanZone> zones = szoneService.getByUid(user.getId());
		List<SalesmanStore> stores = sstoreService.getByUid(user.getId());
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		model.addAttribute("zones", zones);
		model.addAttribute("stores", stores);
		return "b2busers/info_4";
	}
	
	/**
	 * 经销商信息
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/users/dealerinfo",method=RequestMethod.GET)
	public String dealerinfo(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		PartnerDealer partnerDealer = pdealerService.getByDid(user.getId());
		if(partnerDealer!=null){
			User user2 = userService.getById(partnerDealer.getPid());
			model.addAttribute("partner", user2);
		}
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		
		return "b2busers/info_1";
	}
	
	
	@RequestMapping(value = "/users/nzdinfo",method=RequestMethod.GET)
	public String nzdinfo(Model model,@RequestParam(required = true) String id){
		SUser user = suserService.getById(id);
		SalesmanStore sstore = sstoreService.getByStore(user.getId());
		if(sstore!=null){
			User user2 = userService.getById(sstore.getUid());
			model.addAttribute("salesman", user2);
		}
		model.addAttribute("user", user);		
		return "b2busers/nzdinfo";
	}
	
	@RequestMapping(value = "/users/check",method=RequestMethod.GET)
	public String check(Model model,@RequestParam(required = true) String id){
		User user = userService.getById(id);
		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		model.addAttribute("user", user);
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("size", size);
		if(user.getType().getId()==4){
			return "b2busers/pcheck";
		}
		else{
			return "b2busers/check";
		}		
	}
	
	@RequestMapping(value = "/users/verify", method = RequestMethod.POST)
	@ResponseBody
	public String verify(@RequestParam(required = true) String id,@RequestParam(required = false) String opinion) {
		User user = userService.getById(id);
		user.setStatus(1);
		userService.update(user);
		
		UserReview userReview = new UserReview();
		userReview.setOpinion(opinion);
		userReview.setResult(1);
		userReview.setStatus(0);
		userReview.setTime(new Date());
		userReview.setUid(id);
		reviewService.addLog(userReview);
		return "true";
	}
	
	@RequestMapping(value = "/users/notverify", method = RequestMethod.POST)
	@ResponseBody
	public String notverify(@RequestParam(required = true) String id,@RequestParam(required = true) String opinion) {
		User user = userService.getById(id);
		user.setStatus(2);
		userService.update(user);
		
		UserReview userReview = new UserReview();
		userReview.setOpinion(opinion);
		userReview.setResult(2);
		userReview.setStatus(0);
		userReview.setTime(new Date());
		userReview.setUid(id);
		reviewService.addLog(userReview);
		return "true";
	}
	
	@RequestMapping(value = "/users/addsalesmanzone", method = RequestMethod.POST)
	@ResponseBody
	public String addsalesmanzone(@RequestParam(required = true) String uid,@RequestParam(required = true) int aid) {
		SalesmanZone salesmanZone = szoneService.getByUidAndAid(uid, aid);
		if(salesmanZone!=null){
			return "false";
		}
		salesmanZone = new SalesmanZone();
		BasicUser user = new BasicUser();
		user.setId(uid);
		Area area = new Area();
		area.setId(aid);
		salesmanZone.setArea(area);
		salesmanZone.setSalesman(user);
		salesmanZone.setTime(new Date());
		salesmanZone.setStatus(0);
		szoneService.addSalesmanZone(salesmanZone);
		return "true";
	}
	
	@RequestMapping(value = "/users/deletesalesmanzone", method = RequestMethod.POST)
	@ResponseBody
	public String deletesalesmanzone(@RequestParam(required = true) int id) {
		
		szoneService.deleteSalesmanZone(id);
		return "true";
	}
	
	@RequestMapping(value = "/users/deletesalesmanstore", method = RequestMethod.POST)
	@ResponseBody
	public String deletesalesmanstore(@RequestParam(required = true) int id) {
		
		sstoreService.delete(id);
		return "true";
	}
	
	@RequestMapping(value = "/users/setsalesman", method = RequestMethod.POST)
	@ResponseBody
	public String setsalesman(@RequestParam(required = true) String uid,@RequestParam(required = true) String sid) {
		SalesmanStore salesmanStore = sstoreService.getByStore(sid);
		if(salesmanStore!=null){
			sstoreService.delete(salesmanStore.getId());
		}
		salesmanStore = new SalesmanStore();
		salesmanStore.setUid(uid);
		SUser sUser = new SUser();
		sUser.setId(sid);
		salesmanStore.setStore(sUser);
		salesmanStore.setTime(new Date());
		salesmanStore.setStatus(0);
		sstoreService.saveSalesmanStore(salesmanStore);
		return "true";
	}
	
	@RequestMapping(value = "/users/setpartner", method = RequestMethod.POST)
	@ResponseBody
	public String setpartner(@RequestParam(required = true) String pid,@RequestParam(required = true) String did) {
		PartnerDealer partnerDealer = pdealerService.getByDid(did);
		if(partnerDealer!=null){
			pdealerService.delete(partnerDealer.getId());
		}
		partnerDealer = new PartnerDealer();
		partnerDealer.setPid(pid);
		BasicUser sUser = new BasicUser();
		sUser.setId(did);
		partnerDealer.setDealer(sUser);
		partnerDealer.setTime(new Date());
		partnerDealer.setStatus(0);
		pdealerService.savePartnerDealer(partnerDealer);
		return "true";
	}
	
	@RequestMapping(value = "/users/deletepartnerdealer", method = RequestMethod.POST)
	@ResponseBody
	public String deletepartnerdealer(@RequestParam(required = true) int id) {
		
		pdealerService.delete(id);
		return "true";
	}
	
	@RequestMapping(value = "/users/addproviderzone", method = RequestMethod.POST)
	@ResponseBody
	public String addproviderzone(@RequestParam(required = true) String uid,@RequestParam(required = true) int aid) {
		ProviderZone providerZone = pzoneService.getByUidAndAid(uid, aid);
		if(providerZone!=null){
			return "false";
		}
		providerZone = new ProviderZone();
		BasicUser user = new BasicUser();
		user.setId(uid);
		Area area = new Area();
		area.setId(aid);
		providerZone.setArea(area);
		providerZone.setProvider(user);
		providerZone.setTime(new Date());
		providerZone.setStatus(0);
		pzoneService.save(providerZone);
		return "true";
	}
	
	@RequestMapping(value = "/users/deleteprovicerzone", method = RequestMethod.POST)
	@ResponseBody
	public String deleteprovicerzone(@RequestParam(required = true) int id) {
		
		pzoneService.deleteProviderZone(id);
		return "true";
	}
}
