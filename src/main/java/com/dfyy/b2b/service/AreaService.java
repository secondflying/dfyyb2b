package com.dfyy.b2b.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfyy.b2b.bussiness.Area;
import com.dfyy.b2b.dao.AreaDao;

@Service
@Transactional
public class AreaService {

	@Autowired
	private AreaDao dao;

	public List<Area> getAllAreas() {
		List<Area> areas2 = getChildrens(0, dao.findAll());
		return areas2;
	}

	private List<Area> getChildrens(int parentid, Iterable<Area> areas) {
		List<Area> childrens = new ArrayList<Area>();
		for (Iterator<Area> iterator = areas.iterator(); iterator.hasNext();) {
			Area area = (Area) iterator.next();
			if (area.getParentid() == parentid) {
				childrens.add(area);
				area.setNodes(getChildrens(area.getId(), areas));
			}
		}
		return childrens;
	}

	public Area getByName(String name) {
		Area area = dao.getByName(name);
		return area;
	}

	public Area getById(int id) {
		return dao.findOne(id);
	}

	public void save(Area area) {
		dao.save(area);
	}

	public void delete(Area area) {
		dao.delete(area);
	}
	
}
