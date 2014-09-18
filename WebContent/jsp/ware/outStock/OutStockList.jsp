<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>


<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">出库列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
			<a href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">new</s:param></s:url>" >添加出库</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="outStock_list"  method="get" namespace="/outStock" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>编号:</td>
			<td class='secRow'><s:textfield name="outStock.uuid" title="编号" />
			
			<td class='firstRow'>单据号:</td>
			<td class='secRow'>
			<s:textfield name="outStock.ordernum" title="单据号" />
			</td>
			
			</tr>
			<tr>
			<td class='firstRow'>出库时间:</td>
			<td class='secRow'><s:textfield id="indate" name="outStock.date" title="出库时间" />
			<script type="text/javascript">$("#indate").datepicker();</script></td>
			
			<td class='firstRow'>出库仓库:</td>
			<td class='secRow'><s:select name="outStock.store_id" title="出库仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" /></td>
			
			</tr>
			
			<tr>
			<td class='firstRow'>单据性质:</td>
			<td class='secRow'>
			<select name="outStock.reason" title="状态">
							<option value="-1">---请选择---</option>
							<option value="0"
							<s:if test="%{outStock.reason==0}">
							 selected="selected"
							</s:if>
							>销售出库</option>
							<option value="1"
							 <s:if test="%{outStock.reason==1}">
							 selected="selected"
							</s:if>
							>招待用酒</option>
							<option value="2" 
							<s:if test="%{outStock.reason==2 }">
							selected="selected"
							</s:if>
							>借货</option>
							<option value="3" 
							<s:if test="%{outStock.reason==3 }">
							selected="selected"
							</s:if>
							>报损</option>
							<option value="4" 
							<s:if test="%{outStock.reason==4 }">
							selected="selected"
							</s:if>
							>赠酒</option>
			</select>
			
			</td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
			<select name="outStock.send" title="状态">
					<option value="-1">---请选择---</option>
					<option value="-2">正常订单</option>
					<option value="5">取消订单</option>
			</select>
			</td>
			</tr>
			
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>编号</th>
		<th>经办人</th>
		<th>单号</th>
		<th>出库仓库</th>
		<th>状态</th>
		<th>单据性质</th>
		<th>操作</th>
	  </tr>
<s:iterator value="outStocks" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="operator_name" />(<s:property value="dept_name" />)</td>
		<td><s:property value="ordernum" /></td>
		<td><s:property value="ware_name" /></td>
		<td><s:if test='0==send'>借出未还</s:if>
				<s:if test='1==send'>借出已还</s:if>
				<s:if test='2==send'>新单</s:if>
				<s:if test='3==send'>待审核</s:if>
				<s:if test='4==send'>结案<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
				<s:if test='5==send'>已取消订单</s:if>
		</td>
		<td>
		
			<s:if test="%{reason==0}">销售出库
					</s:if>
					 <s:if test="%{reason==1}">招待用酒
					</s:if>
					<s:if test="%{reason==2 }">借货
					</s:if>
					<s:if test="%{reason==3 }">报损
					</s:if>
					<s:if test="%{reason==4 }">赠酒
					</s:if>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_MDY') && @com.qkj.ware.action.warepower@checkPermit(store_id,'del')">
	    	[<a href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && @com.qkj.ware.action.warepower@checkPermit(store_id,'del') && (send!=4 && send!=5)">
	    	[<a href="<s:url namespace="/outStock" action="outStock_del"><s:param name="outStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	 
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_PRINT')  && (send==4 || send==5) ">
	    	[<a target="_blank" href="<s:url namespace="/outStock" action="outStock_view"><s:param name="viewFlag">view</s:param><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">查看/打印</a>]
	    	</s:if>	  
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_PRINT')  && send==4 && @com.qkj.ware.action.warepower@checkPermit(store_id,'del') && reason==2 && boflag==0">
	    	[<a onclick="return isOp('确认归还?');" href="<s:url namespace="/outStock" action="outStock_borrow"><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">还货</a>]
	    	</s:if>	 
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>