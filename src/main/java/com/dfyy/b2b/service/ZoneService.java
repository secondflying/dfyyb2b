package com.dfyy.b2b.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Zone;
import com.dfyy.b2b.dao.ZoneDao;
import com.dfyy.b2b.dto.ZoneResult;
import com.dfyy.b2b.util.BaiduMapUtils;

@Service
@Transactional
public class ZoneService {

	@Autowired
	private ZoneDao dao;

	public List<Zone> getAll() {
		return dao.getAll();
	}

	public ZoneResult getZoneByCood(double x, double y) {
		if (x == 0 || y == 0) {
			return new ZoneResult(false);
		}

		Integer zoneCode = BaiduMapUtils.coodToZoneCode(x, y);
		if (zoneCode == null) {
			return new ZoneResult(false);
		}

		Zone zone = dao.findOne(zoneCode);
		if (zone == null) {
			return new ZoneResult(false);
		}

		return new ZoneResult(true, zone);
	}
}
