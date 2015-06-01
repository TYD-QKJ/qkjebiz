package com.qkj.manage.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;




/**
 * 请假表单
 * @author yangenxiong
 *
 */
public class VacationForm  {

	// 休假开始日期
	private String startDate;
	
	// 休假结束日期
	private String endDate;
	
	// 天数
	private int days;
	
	// 类型
	private int vacationType;
	
	// 原因
	private String reason;
		
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getDays() {
		return days;
	}

	public void setDays(int days) {
		this.days = days;
	}

	public int getVacationType() {
		return vacationType;
	}

	public void setVacationType(int vacationType) {
		this.vacationType = vacationType;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	
	
}
