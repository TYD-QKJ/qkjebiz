package com.qkj.ware.domain;

import java.util.*;

public class OutDetail {
	private Integer uuid;// (int)
	private Integer lading_id;// (varchar)
	private Integer product_id;// (int)
	private Integer num;// (int)
	private Double price;// (decimal)
	private Double totel;// (int)

	// 以下为非数据库字段
	private String product_name;
	private Integer case_spec;
	private String flag;

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Integer getUuid() {
		return uuid;
	}

	public void setUuid(Integer uuid) {
		this.uuid = uuid;
	}

	public Integer getLading_id() {
		return lading_id;
	}

	public void setLading_id(Integer lading_id) {
		this.lading_id = lading_id;
	}

	public Integer getProduct_id() {
		return product_id;
	}

	public void setProduct_id(Integer product_id) {
		this.product_id = product_id;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getTotel() {
		return totel;
	}

	public void setTotel(Double totel) {
		this.totel = totel;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public Integer getCase_spec() {
		return case_spec;
	}

	public void setCase_spec(Integer case_spec) {
		this.case_spec = case_spec;
	}

}
