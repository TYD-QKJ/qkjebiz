<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
			<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
				<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">add</s:param></s:url>">添加结案提货单</a></span>
			</c:if>
		</div>
		<s:form id="serachForm" name="serachForm" action="closeOrder_list" method="get" namespace="/qkjmanage" theme="simple">
			<div class="label_con">
				<div class="label_main">
					<div class='label_hang'>
						<div class='label_ltit'>主键:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.uuid' cssClass=' validate[maxSize[10],custom[integer],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>结案时间:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.close_time' cssClass=' datepicker validate[custom[date],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>主题:</div>
						<div class="label_rwben">
							<s:textfield name="closeOrder.theme" title="主题" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">申请部门:</div>
						<div class="label_rwben2">
							<span class="label_rwb"> <s:textfield title="部门名称" id="userdept_nameid" name="closeOrder.apply_dept_name" readonly="true" /> <s:hidden title="部门代码" id="userdept_codeid" name="closeOrder.apply_dept" readonly="true" />
							</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" /> <s:checkbox id="apply_is_sub_dept" name="closeOrder.is_sub_dept" cssClass="regular-checkbox" /> <label for="apply_is_sub_dept"></label>包含子部门<span
								id="ajax_member_message"></span>
							</span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">申请人:</div>
						<div class="label_rwben label_rwb">
							<s:select id="membermanagerid" cssClass="selectKick" name="closeOrder.add_user" list="#{}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>

					<div class="label_hang">
						<div class="label_ltit">单据状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_state" name="closeOrder.state" cssClass="selectKick" list="#{0:'新单',1:'审核中',2:'通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">销售状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_state" name="closeOrder.sd_state" cssClass="selectKick" list="#{5:'退回',10:'待审核',30:'大区审核通过',40:'总监审核通过',50:'业务副总通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">销管状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_state" name="closeOrder.smd_status" cssClass="selectKick" list="#{5:'退回',10:'已签收',30:'销管经理已审',40:'销管部经理已审',50:'销管副总通过',60:'总经理通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">数据中心:</div>
						<div class="label_rwben label_rwb">
							<s:select id="nd_check_state" name="closeOrder.nd_check_state" cssClass="selectKick" list="#{0:'未确认',5:'退回',10:'已审'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang tac">
						<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
						<label for="search_mcondition"></label>更多条件
						<s:submit value="搜索" />
						<s:reset value="重置" />
					</div>
				</div>
			</div>
		</s:form>
		<div class="tab_warp">
			<table>
				<tr id="coltr">
					<th class="td1">主键</th>
					<th class="td2">申请部门</th>
					<th class="td1">申请人</th>
					<th class="td5">主题</th>
					<th class="td3">结案时间</th>
					<th class="td1">单据状态</th>
					<th class="td2">销售状态</th>
					<th class="td2">销管状态</th>
					<th class="td4">操作</th>
					<th class="td0">查看</th>
				</tr>
				<s:iterator value="closeOrders" status="sta">
					<tr id="showtr${uuid}">
						<td class="td1 nw">${uuid}</td>
						<td class="td2 nw">${apply_dept_name}</td>
						<td class="td1 nw">${add_user_name}</td>
						<td class="td5 longnote" title="${theme}">${it:subString(theme,18)}</td>
						<td class="td3 nw">${it:formatDate(close_time,'yyyy-MM-dd')}</td>
						<td class="td1 nw">
						<s:if test="state==0">新单</s:if>
						<s:if test="state==1">审批中</s:if>
						<s:if test="state==2">通过</s:if>
						</td>
						<td class="td2 nw" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">
						<s:if test="sd_state==0">新单</s:if>
									<s:if test="sd_state==5">
										<font class="message_error">审核退回</font></s:if>
									<s:if test="sd_state==10">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="sd_state==30">
										<font class="message_pass">大区已审</font></s:if>
									<s:if test="sd_state==40">
										<font class="message_pass">总监已审</font></s:if>
									<s:if test="sd_state==50">
										<font class="message_pass">副总已审</font></s:if>
						</td>
						<td class="td2 nw" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">
						<s:if test="smd_status==0">未签收</s:if>
									<s:if test="smd_status==5">
										<font class="message_error">审核退回</font></s:if>
									<s:if test="smd_status==10">
										<font class="message_warning">已签收</font>
									</s:if>
									<s:if test="smd_status==30">
										<font class="message_pass">销管经理已审</font></s:if>
									<s:if test="smd_status==40">
										<font class="message_pass">销管部经理已审</font></s:if>
									<s:if test="smd_status==50">
										<font class="message_pass">销管副总已审</font></s:if>
										<s:if test="smd_status==60">
										<font class="message_pass">总经理已审</font></s:if>
						</td>
						<td class="td4 op-area">
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY',null)==true}">
								<a class="input-blue" href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>">修改</a>
							</c:if> 
							<s:if test="check_state>30">
					    	<a class="input-gray" href="<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="uuid" /></s:url>">打印</a>
					    	</s:if>
					    	<c:if test="${check_state<1 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
								<a class="input-red" href="<s:url namespace="/qkjmanage" action="closeOrder_del"><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
							</c:if></td>
						<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<div id="listpage" class="pagination"></div>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
</script>
</body>
</html>