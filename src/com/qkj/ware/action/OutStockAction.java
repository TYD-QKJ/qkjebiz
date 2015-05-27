package com.qkj.ware.action;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.ware.dao.OutDetailDAO;
import com.qkj.ware.dao.OutDetailHDAO;
import com.qkj.ware.dao.OutStockDAO;
import com.qkj.ware.dao.OutStockHDAO;
import com.qkj.ware.dao.StockDAO;
import com.qkj.ware.domain.OutDetail;
import com.qkj.ware.domain.OutDetailH;
import com.qkj.ware.domain.OutStock;
import com.qkj.ware.domain.OutStockH;
import com.qkj.ware.domain.Stock;
import com.qkj.ware.domain.Warepowers;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class OutStockAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(OutStockAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private OutStockDAO dao = new OutStockDAO();

	private OutStock outStock;
	private Stock stock;
	private OutStockH outStockh;
	private OutDetailH outDetailh;
	private List<Stock> stocks;
	private List<OutStock> outStocks;
	private List<OutDetail> outDetails;
	private OutDetail outDetail;
	private List<Ware> wares;
	private List<Ware> borrowwares;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private List<Warepowers> wps;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;出库管理";
	
	
	public List<Warepowers> getWps() {
		return wps;
	}

	public void setWps(List<Warepowers> wps) {
		this.wps = wps;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public List<Ware> getBorrowwares() {
		return borrowwares;
	}

	public void setBorrowwares(List<Ware> borrowwares) {
		this.borrowwares = borrowwares;
	}

	public OutStock getOutStock() {
		return outStock;
	}

	public void setOutStock(OutStock outStock) {
		this.outStock = outStock;
	}

	public List<OutStock> getOutStocks() {
		return outStocks;
	}

	public void setOutStocks(List<OutStock> outStocks) {
		this.outStocks = outStocks;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	
	
	public List<Ware> getWares() {
		return wares;
	}

	public void setWares(List<Ware> wares) {
		this.wares = wares;
	}
	

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
	}
	

	public List<OutDetail> getOutDetails() {
		return outDetails;
	}

	public void setOutDetails(List<OutDetail> outDetails) {
		this.outDetails = outDetails;
	}

	public OutDetail getOutDetail() {
		return outDetail;
	}

	public void setOutDetail(OutDetail outDetail) {
		this.outDetail = outDetail;
	}
	
	
	public OutStockH getOutStockh() {
		return outStockh;
	}

	public void setOutStockh(OutStockH outStockh) {
		this.outStockh = outStockh;
	}

	public OutDetailH getOutDetailh() {
		return outDetailh;
	}

	public void setOutDetailh(OutDetailH outDetailh) {
		this.outDetailh = outDetailh;
	}

	public Stock getStock() {
		return stock;
	}

	public void setStock(Stock stock) {
		this.stock = stock;
	}
	
	private void getWare() {
		WareDAO wd = new WareDAO();
		Map<String, Object> mapware = new HashMap<String, Object>();
		this.setWps(warepower.checkWarePower());
		mapware.clear();
		if(wps!=null && wps.size()>0){
			List<Integer> ud_list = new ArrayList<>();
			for(int i=0;i<wps.size();i++){
				if(wps.get(i).getPrvg().contains("2")){//有入库权限则有入库单查询权限
					ud_list.add(wps.get(i).getWare_id());
				}
			}
			mapware.put("uuids", ud_list);
		}
		this.setWares(wd.list(mapware));
	}
	

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_LIST");
		try {
			map.clear();
			if (outStock != null)
					map.putAll(ToolsUtil.getMapByBean(outStock));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));	
			
			this.setWps(warepower.checkWarePower());
			if(wps!=null && wps.size()>0){
				List<Integer> ud_list = new ArrayList<>();
				for(int i=0;i<wps.size();i++){
					if(wps.get(i).getPrvg().contains("1")){//有入库权限则有入库单查询权限
						ud_list.add(wps.get(i).getWare_id());
					}
				}
				map.put("storeids", ud_list);
			}
			this.setOutStocks(dao.list(map));
			getWare();
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;出库列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setOutStock(null);
				setMessage("你没有选择任何操作!");
			}else if ("add".equals(viewFlag)) {
				getWare();
				this.setOutStock(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/outStock/outStock_list'>出库列表</a>&nbsp;&gt;&nbsp;增加出库";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				if(outStock==null)this.setOutStock(null);
				else {
					map.put("uuid", outStock.getUuid());
					this.setOutStock((OutStock)dao.list(map).get(0));
					getWare();
					OutDetailDAO idao=new OutDetailDAO();
					map.clear();
					map.put("lading_id", outStock.getUuid());
					this.setOutDetails(idao.list(map));
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/outStock/outStock_list'>出库列表</a>&nbsp;&gt;&nbsp;出库详情";
			} else {
				this.setOutStock(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
		
	}

	/*private void wareByPower(String u, String code) {
		WareDAO wd=new WareDAO();
		if(ContextHelper.isAdmin()){//管理员
			map.clear();
			map.put("bug","bug");
			map.put("type", "0");//非藏酒库
			this.setWares(wd.list(map));
			this.setBorrowwares(wares);
		}else{
			map.clear();
			map.put("username",u);
			map.put("dept_code", code);
			map.put("del", 1);
			map.put("bug","bug");
			this.setWares(wd.listByPower(map));
			//借货仓库
			map.clear();
			map.put("bug","bug");
			this.setBorrowwares(wd.list(map));
		}
	}*/

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			
			outStock.setTake_id(u);
			outStock.setSend(2);
			outStock.setAdd_user(u);
			outStock.setAdd_timer(d);
			outStock.setLm_user(u);
			outStock.setLm_timer(new Date());
			dao.add(outStock);
			map.clear();
			map.put("ordernum", outStock.getOrdernum());
			this.setOutStock((OutStock)dao.list(map).get(0));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_MDY");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			outStock.setLm_user(u);
			outStock.setLm_timer(new Date());
			dao.save(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	//取消出库
	public String cencle() throws Exception{
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_CENCLE");
		try {
			OutDetailDAO odao=new OutDetailDAO();
			//修改单据状态
			outStock.setSend(5);
			dao.updateSend(outStock);
			//修改库存
			StockDAO stockdao=new StockDAO();
			map.clear();
			map.put("lading_id",outStock.getUuid());
			this.setOutDetails(odao.list(map));
			if(outDetails.size()>0){
				for(int i=0;i<outDetails.size();i++){
					this.setOutDetail(outDetails.get(i));
					StockDAO sd=new StockDAO();
					this.setStock((Stock)sd.get(outDetail.getProduct_id()));
					map.clear();
					map.put("uuid", stock.getUuid());
					map.put("quantity", stock.getQuantity()+outDetail.getNum());
					stockdao.updateTotleById(map);
				}
		
			}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_DEL");
		try {
			this.setOutStock((OutStock)dao.get(outStock.getUuid()));
			this.setOutStockh(outStock);
			OutStockHDAO mhd=new OutStockHDAO();
			//mhd.add(outStockh);
			
			dao.delete(outStock);
			setMessage("删除成功!ID=" + outStock.getUuid());
			OutDetailDAO odao=new OutDetailDAO();
			//修改库存
			map.clear();
			map.put("lading_id",outStock.getUuid());
			this.setOutDetails(odao.list(map));
			if(outDetails.size()>0){
				for(int i=0;i<outDetails.size();i++){
					this.setOutDetail(outDetails.get(i));
					OutDetailHDAO hd=new OutDetailHDAO();
					this.setOutDetailh(outDetail);
					//hd.add(outDetailh);//填加历史
				}
				
				//删除详表
				map.clear();
				map.put("lading_id",outStock.getUuid());
				odao.deleteByLading(map);
			}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	private void setOutDetailh(OutDetail outDetail2) {
		// TODO Auto-generated method stub
		outDetailh=new OutDetailH();
		outDetailh.setLading_id(outDetail2.getLading_id());
		outDetailh.setNum(outDetail2.getNum());
		outDetailh.setPrice(outDetail2.getPrice());
		outDetailh.setProduct_id(outDetail2.getProduct_id());
		outDetailh.setTotel(outDetail2.getTotel());
		
	}

	private void setOutStockh(OutStock outStock2) {
		// TODO Auto-generated method stub
		outStockh=new OutStockH();
		outStockh.setAdd_timer(outStock2.getAdd_timer());
		outStockh.setAdd_user(outStock2.getAdd_user());
		outStockh.setBsreason(outStock2.getBsreason());
		outStockh.setCoo_check(outStock2.getCoo_check());
		outStockh.setCoo_check_time(outStock2.getCoo_check_time());
		outStockh.setDate(outStock2.getDate());
		outStockh.setLm_timer(outStock2.getLm_timer());
		outStockh.setLm_user(outStock2.getLm_user());
		outStockh.setManager_check(outStock2.getManager_check());
		outStockh.setManager_check_time(outStock2.getManager_check_time());
		outStockh.setManager_check_user(outStock2.getManager_check_user());
		outStockh.setMember_adress(outStock2.getMember_adress());
		outStockh.setMember_id(outStock2.getMember_id());
		outStockh.setMember_mebile(outStock2.getMember_mebile());
		outStockh.setMember_name(outStock2.getMember_name());
		outStockh.setMember_price(outStock2.getMember_price());
		outStockh.setNote(outStock2.getNote());
		outStockh.setOperator_id(outStock2.getOperator_id());
		outStockh.setOrdernum(outStock2.getOrdernum());
		outStockh.setReason(outStock2.getReason());
		outStockh.setSend(outStock2.getSend());
		outStockh.setStore_id(outStock2.getStore_id());
		outStockh.setTake_id(outStock2.getTake_id());
		outStockh.setTotal_price(outStock2.getTotal_price());
		
	}

	/**
	 * 新增方法
	 */
	

	//还货
	public String borrow() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_MDY");
		String u = ContextHelper.getUserLoginUuid();
		String code=ContextHelper.getUserLoginDept();
		try {
			if(outStock!=null&&outStock.getReason()!=null&&outStock.getReason()==1){
				outStock.setMember_id(outStock.getMember_name());
			}
			map.clear();
			map.put("uuid", outStock.getUuid());
			this.setOutStock((OutStock)dao.list(map).get(0));
			int jStock=outStock.getBorrowStore_id();
			int cStock=outStock.getStore_id();
			
			StockDAO stockdao=new StockDAO();
			OutDetailDAO idao=new OutDetailDAO();
			map.clear();
			map.put("lading_id", outStock.getUuid());
			this.setOutDetails(idao.list(map));
			if(outDetails.size()>0){
				for(int i=0;i<outDetails.size();i++){
					this.setOutDetail(outDetails.get(i));
					//改库存出库仓库+库存，借库仓库—库存
					this.setStock((Stock)stockdao.get(outDetail.getProduct_id()));
					int product=stock.getProduct_id();
					map.put("quantity", stock.getQuantity()+outDetail.getNum());
					map.put("uuid", stock.getUuid());
					stockdao.updatborrow(map);
					
					//借库仓库—库存
					map.clear();
					map.put("product_id",product);
					map.put("store_id", outStock.getBorrowStore_id());
					this.setStock((Stock)stockdao.list(map).get(0));
					
					map.put("quantity", stock.getQuantity()-outDetail.getNum());
					map.put("uuid", stock.getUuid());
					stockdao.updatborrow(map);
					
				}
			}
			outStock.setBoflag(1);
			dao.save(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		} 
		return SUCCESS;
	}
	
	
	//确认
		public String sure() throws Exception {
			ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_SURE");
			String u = ContextHelper.getUserLoginUuid();
			try {
				//修改库存
				this.setOutStock((OutStock)dao.get(outStock.getUuid()));
				OutDetailDAO odd=new OutDetailDAO();
				map.clear();
				map.put("lading_id", outStock.getUuid());
				this.setOutDetails(odd.list(map));
				if(outDetails.size()>0){
					for(int i=0;i<outDetails.size();i++){
						this.setOutDetail(outDetails.get(i));
						StockDAO stockdao=new StockDAO();
						map.clear();
						map.put("uuid", outDetail.getProduct_id());//出库祥表的product_id是库存id
						this.setStock((Stock)stockdao.fingByPro(map));
						int quan=(stock.getQuantity()-stock.getFreezeNum())-outDetail.getNum();
						stock.setQuantity(quan);
						stockdao.save(stock);
					}
				}
				//修改确认状态
				outStock.setSend(4);
				outStock.setManager_check(1);//确认
				outStock.setManager_check_user(u);//确认人
				outStock.setManager_check_time(new Date());//确认时间
				dao.updateCheck(outStock);
			} catch (Exception e) {
				log.error(this.getClass().getName() + "!save 数据更新失败:", e);
				throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
			}
			return SUCCESS;
		}
	
		public String note() throws Exception {
			ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_MDY");
			try {
				Date d = new Date();
				String u = ContextHelper.getUserLoginUuid();
				String note=outStock.getNote();
				int uuid=outStock.getUuid();
				this.setOutStock(null);
				outStock=new OutStock();
				outStock.setLm_user(u);
				outStock.setLm_timer(new Date());
				outStock.setUuid(uuid);
				outStock.setNote(note);
				dao.updateNote(outStock);
			} catch (Exception e) {
				log.error(this.getClass().getName() + "!save 数据更新失败:", e);
				throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
			}
			return SUCCESS;
		}
		
/*
		//送审
		public String chack() throws Exception {
			ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_STATUS0");
			try {
				Date d = new Date();
				String u = ContextHelper.getUserLoginUuid();
				outStock.setManager_check(0);
				outStock.setCoo_check(0);
				outStock.setSend(3);
				dao.updateCheck(outStock);
			} catch (Exception e) {
				log.error(this.getClass().getName() + "!save 数据更新失败:", e);
				throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
			}
			return SUCCESS;
		}
		
	//经理审核
	
	public String chackManage() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_MANAGE");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			outStock.setManager_check(1);
			outStock.setCoo_check(0);
			outStock.setManager_check_time(d);
			outStock.setManager_check_user(u);
			dao.updateCheckManage(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	//总监审核
	public String chackCoo() throws Exception {
		ContextHelper.isPermit("QKJ_WARE_OUTSTOCK_COO");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			outStock.setCoo_check(1);
			outStock.setCoo_check_time(d);
			outStock.setCoo_check_user(u);
			outStock.setSend(4);
			dao.updateCheckCoo(outStock);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	*/
	
	
}
