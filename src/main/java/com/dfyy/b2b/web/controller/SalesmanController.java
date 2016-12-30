package com.dfyy.b2b.web.controller;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dfyy.b2b.bussiness.Commodity;
import com.dfyy.b2b.bussiness.CommodityAttachment;
import com.dfyy.b2b.bussiness.CommodityGradualprice;
import com.dfyy.b2b.bussiness.CommodityGradualrebate;
import com.dfyy.b2b.bussiness.CommodityOfNzd;
import com.dfyy.b2b.bussiness.CommodityProtective;
import com.dfyy.b2b.bussiness.CommodityTag;
import com.dfyy.b2b.bussiness.OrderBrokerage;
import com.dfyy.b2b.bussiness.Orders;
import com.dfyy.b2b.bussiness.SUser;
import com.dfyy.b2b.bussiness.SalesmanStore;
import com.dfyy.b2b.bussiness.SalesmanZone;
import com.dfyy.b2b.bussiness.User;
import com.dfyy.b2b.bussiness.UserReview;
import com.dfyy.b2b.service.CommodityService;
import com.dfyy.b2b.service.OrdersService;
import com.dfyy.b2b.service.SUserService;
import com.dfyy.b2b.service.SalesmanZoneService;
import com.dfyy.b2b.service.SalesmanstoreService;
import com.dfyy.b2b.service.UserContext;
import com.dfyy.b2b.service.UserReviewService;
import com.dfyy.b2b.service.UserService;
import com.dfyy.b2b.service.UserTypeService;
import com.dfyy.b2b.service.ZoneService;
import com.dfyy.b2b.util.PublicConfig;
import com.dfyy.b2b.util.PublicHelper;

@Controller
@RequestMapping("/provider")
public class SalesmanController {
	
	@Autowired
	private UserContext userContext;
	@Autowired
	private UserService userService;
	@Autowired
	private UserTypeService typeService;
	@Autowired
	private ZoneService zoneService;
	@Autowired
	private UserReviewService reviewService;
	@Autowired
	private SalesmanZoneService szoneService;
	@Autowired
	private SalesmanstoreService sstoreService;
	@Autowired
	private OrdersService ordersService;
	@Autowired
	private CommodityService commodityService;
	@Autowired
	private SUserService suserService;
	
	@RequestMapping(value = "/salesman/info",method=RequestMethod.GET)
	public String info(Model model){
		User user = userContext.getCurrentUser();
		user = userService.getById(user.getId());		

		int size = 0;
		if(user.getDocs()!=null && user.getDocs().size()>0){
			size = user.getDocs().size();
		}
		List<SalesmanZone> zones = szoneService.getByUid(user.getId());
		List<SalesmanStore> stores = sstoreService.getByUid(user.getId());
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "providers/small");
		model.addAttribute("user", user);
		model.addAttribute("size", size);
		model.addAttribute("zones", zones);
		model.addAttribute("stores", stores);
		if(user.getStatus()==2){
			UserReview userReview = reviewService.getByUid(user.getId());
			model.addAttribute("review", userReview);
		}
		return "salesman/info";
	}

	@RequestMapping(value = "/salesman/orders", method = RequestMethod.GET)
	public String orders(Model model, @RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {
		User user = userContext.getCurrentUser();
		user = userService.getById(user.getId());
		
		List<Orders> orders = ordersService.getOrdersOfSalesman(user.getId(), page, size);
		int sumcount = ordersService.getCountOrdersOfSalesman(user.getId());

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("orders", orders);
		model.addAttribute("sumcount", sumcount);

		return "salesman/orders";
	}
	
	@RequestMapping(value = "/salesman/order", method = RequestMethod.GET)
	public String orderinfo(Model model, @RequestParam(required = true) int id) {

		Orders orders = ordersService.getSingle(id);
		double totalprice = 0;
		totalprice = PublicHelper.correctTo(orders.getCount()*orders.getPrice());
		List<CommodityAttachment> docs = commodityService.getdocByCommodity(orders.getCommodity().getId());
		int size = 0;
		if(docs!=null && docs.size()>0){
			size = docs.size();
		}
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("docs", docs);
		model.addAttribute("order", orders);
		model.addAttribute("size", size);
		model.addAttribute("totalprice", totalprice);
		if(orders.getStatus()==3){
			OrderBrokerage orderBrokerage = ordersService.getBrokerageByOid(orders.getId());
			model.addAttribute("brokerage", orderBrokerage);
		}

		return "salesman/order";
	}
	
	@RequestMapping(value = "/salesman/stores",method=RequestMethod.GET)
	public String stores(Model model,@RequestParam(required = false, defaultValue = "") String keyword,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "10") int size){
		keyword = StringUtils.trim(keyword);

		List<SUser> users = suserService.getAllNzd(keyword, page, size);
		int sumcount = suserService.getAllNzdCount(keyword);

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "users/small");
		model.addAttribute("users", users);
		model.addAttribute("sumcount", sumcount);
		return "salesman/stores";
	}
	
	@RequestMapping(value = "/salesman/store",method=RequestMethod.GET)
	public String nzdinfo(Model model,@RequestParam(required = true) String id){
		SUser user = suserService.getById(id);
		SalesmanStore sstore = sstoreService.getByStore(user.getId());
		if(sstore!=null){
			User user2 = userService.getById(sstore.getUid());
			model.addAttribute("salesman", user2);
		}
		model.addAttribute("user", user);		
		return "salesman/store";
	}
	
	@RequestMapping(value = "/salesman/storeorders",method=RequestMethod.GET)
	public String storeorder(Model model,@RequestParam(required = true) String uid,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		SUser user = suserService.getById(uid);
		List<Orders> orders = ordersService.getNzdOrders(uid, page, size);
		int sumcount = ordersService.getCountNzdOrders(uid);

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("orders", orders);
		model.addAttribute("sumcount", sumcount);		
		return "salesman/storeorders";
	}
	
	@RequestMapping(value = "/salesman/storeorder", method = RequestMethod.GET)
	public String storeorder(Model model, @RequestParam(required = true) int id) {

		Orders orders = ordersService.getSingle(id);
		double totalprice = 0;
		totalprice = PublicHelper.correctTo(orders.getCount()*orders.getPrice());
		List<CommodityAttachment> docs = commodityService.getdocByCommodity(orders.getCommodity().getId());
		int size = 0;
		if(docs!=null && docs.size()>0){
			size = docs.size();
		}
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("docs", docs);
		model.addAttribute("order", orders);
		model.addAttribute("size", size);
		model.addAttribute("totalprice", totalprice);
		if(orders.getStatus()==3){
			OrderBrokerage orderBrokerage = ordersService.getBrokerageByOid(orders.getId());
			model.addAttribute("brokerage", orderBrokerage);
		}

		return "salesman/storeorder";
	}
	
	@RequestMapping(value = "/salesman/storebuyed",method=RequestMethod.GET)
	public String storebuyed(Model model,@RequestParam(required = true) String uid,
			@RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size){
		List<CommodityOfNzd> cs = ordersService.getMyBuyedCommodity(uid, page, size);
		int sumcount = ordersService.getCountMyBuyedCommodity(uid);

		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		model.addAttribute("commodities", cs);
		model.addAttribute("sumcount", sumcount);		
		return "salesman/storebuyed";
	}
	
	@RequestMapping(value = "/salesman/storecommodity", method = RequestMethod.GET)
	public String storecommodity(@RequestParam(required = true) int id, Model model) {
		model.addAttribute("imageUrl", PublicConfig.getImageUrl() + "b2bcommodity/small");
		Commodity commodity = commodityService.getCommodityFull(id);
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
		model.addAttribute("docs", docs);
		model.addAttribute("size", size);
		model.addAttribute("gprices", gradualprices);
		model.addAttribute("grebates", gradualrebates);
		model.addAttribute("protectives", protectives);
		model.addAttribute("tags", tags);
		return "salesman/storecommodity";
	}
	
	@RequestMapping(value = "/salesman/brokerages", method = RequestMethod.GET)
	public String brokerages(Model model, @RequestParam(required = false, defaultValue = "0") int page,
			@RequestParam(required = false, defaultValue = "20") int size) {
		User user = userContext.getCurrentUser();
		user = userService.getById(user.getId());
		
		List<OrderBrokerage> brokerages = ordersService.getBrokeragesOfSalesman(user.getId(), page, size);
		int sumcount = ordersService.getBrokeragesCountOfSalesman(user.getId());

		model.addAttribute("brokerages", brokerages);
		model.addAttribute("sumcount", sumcount);

		return "salesman/brokerages";
	}
}
