package com.qkj.ware.allot.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class AllotDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("allot_getAllotsCounts");
		return super.list("allot_getAllots", map);
	}
	
	public Object get(Object uuid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uuid", uuid);
		return super.get("allot_getAllots", map);
	}

	public Object add(Object parameters) {
		return super.add("allot_addAllot", parameters);
	}

	public int save(Object parameters) {
		return super.save("allot_mdyAllot", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("allot_delAllot", parameters);
	}
	
	public int updateState(Object parameters){
		return super.save("allot_mdyAllotState", parameters);
	}
	
	public int getResultCount() {
		return super.getResultCount();
	}
}