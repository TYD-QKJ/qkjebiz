<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>门店支付首页<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
 <!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right input-a">
 	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;门店支付
		
	</div>
	<div class="label_main">		
         <div class="label_hang">
         	<div class="label_ltit">品名:</div>
         	 <div class="label_rwbenx">
	             <s:textfield id="auto_prod_name" name="prodname" cssClass="selectAll iI iI-s" />
		         <input id="auto_prod_id" type="hidden" name="prodid" />			
	         </div>	    
        </div>
 		<div class="label_hang">
            <div class="label_ltit">条形码:</div>
            <div class="label_rwbenx"><s:textfield class="tiaomainput"  name="customer.uuid" id="tiaomainput"/>
	             &nbsp;<input type="reset" value="添加" id="storessubmit">

	             </div>
        </div>
      </div>
	<!-- <div class="tiaoma_hang">
	       <div class="tiaoma_ltit">条形码：<input class="tiaomainput"  name="customer.uuid"  title="客户编号" />				       
		      <input class="tiaomareset" type="reset" value="添加" id="storessubmit"> 				      
		      <s:textfield id="auto_prod_name" name="prodname" cssClass="selectAll iI iI-s" />
	             <input id="auto_prod_id" type="hidden" name="prodid" />				    
	      </div>
	       <span><a class="tiaomareset" style="float: right;margin-top: 10px;" href="/qkjmanage/stores_order_update.action">修改订单</a></span>
	</div>
	<s:form id="serachForm" name="serachForm" action="insert_sotres_order"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="tab_warp" >
			<table id="qkj_list">
				<tr id="coltr" >
			    <th class="td1">统一编码</th>
				<th class="td2">条形码</th>
				<th class="td3">系列</th>
				<th class="td4">品名</th>
				<th class="td5">规格</th>
				<th class="td6">单价</th>
				<th class="td6">总价</th>
				<th class="td7">数量</th>
				<th class="td8">操作</th>
			 	</tr>
			</table>
		</div>
	    <s:submit class="tiaomareset" type="reset" value="提交订单" id="sumbit_order"/> 
	</s:form> -->
	<s:form id="serachForm" name="serachForm" action="insert_sotres_order"  method="get" namespace="/qkjmanage" theme="simple">
	    <div class="tab_warp" >
	    	<div class="tab_txm">
		    	<table id="qkj_list">
			 		<tr>
					    <th class="td1">品名</th>
						<th class="td1">单价</th>
						<th class="td1">数量</th>
						<th class="td1">总价</th>
						<th class="td1">操作</th>
				  	</tr>
			  	</table>
	    		<div style="margin:10px 0;"><s:submit type="reset" value="提交订单" id="sumbit_order" cssClass="input-blue"/></div>
	    	</div>
	    	<div  class="tab_txm2">
	    	<table>
			 		<tr>
			 			<th class="td1">订单时间</th>
						<th class="td1">订单总价</th>
					
						<th class="td1">操作</th>
				  	</tr>
				  		<s:iterator value="storesorderlist" status="sta">
				  	<tr>
				  	<td class="td1">${add_time}</td>
				  		<td class="td1">${total_price}</td>
				  		
				  		<td class="td1 op-area"><a  class="input-blue"  href="/qkjmanage/stores_order_update_details.action?id=${id}" >查看详情</a></td>
				  	</tr>
				  			</s:iterator>
			  	</table>
	    	</div>
			  	
	    </div>
      </s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
<div id="dialog" title="重复条码选择" style="display:none">
  <p>这是一个默认的对话框，用于显示信息。对话框窗口可以移动，调整尺寸，默认可通过 'x' 图标关闭。</p>
</div>
</body>
<script >
$("#dianji").click(function(){
	 $('#dialog').css('display', 'display');
	   $( "#dialog" ).dialog();
});
var num=0;
var firstnum=true;
var show = new Array(); 
$("#storessubmit").click(function(){
 var code=$(".tiaomainput").val();
if(code!=""&&code!=null){
	 /* $.ajax({
     type:"post",
     url:"/qkjebiz/qkjmanage/add_sotres_list",
     data:{code:code},
     //async: false,
     cache: false,
     success:function(data){
     }
 });  */
 var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
 var ajax=new Common_Ajax();
 ajax.config.action_url=ajax_url_action;
 ajax.config._success=function(data,textStatus){
	   if(data){
      	 if(data.length>1){
      		 $('#dialog').css('display', 'display');
      		   $( "#dialog" ).dialog();
      		   $( "#dialog" ).empty();
      	    	for (var i = 0; i < data.length; i++) {
      	    		     var repeatshow = new Array();
      	    		     var product_id=data[i].uuid;
      	    		     var procode = data[i].prod_code;
      	    		     var barcode=data[i].bar_code;
      	    	         var title = data[i].title;
      	    	         var spec = data[i].spec;
      	    	         var marketprice = data[i].market_price;
      	    		     repeatshow.push('<p><a id="'+product_id+','+procode+','+barcode+','+title+','+spec+','+marketprice+'"  href="javascript:void(0)" onclick="javascript:mylist(this)" value="'+marketprice+','+spec+','+title+'">'+title+'</a></p>') ;
      	    		    $("#dialog").append(repeatshow.join(""));
      	    	}
      	 }else if(data.length==0){
      		alert("请输入正确的条码");
      	 }
      	 else{ fortr(data);
      	 }
           num++;
       	}else{
       		alert("请输入正确的条码")
       	}
       firstnum=true; 
 };

 ajax.addParameter("parameters", "code="+code);
 ajax.addParameter("work","StoresOrder");
 ajax.sendAjax();

}else{
	alert("请输入正确的条码")
}
});
function mylist(list){
	var msg=list.id.split(",");
	var procode=msg[1];
	$("#qkj_list").find("tr").each(function(){
		$(this).find("td").each(function(){
		if($(this).text()==procode){
			var numplus=$(this).next().next().next().next().next().next().text();
			var price=$(this).next().next().next().next().next().text();
			var totlprice=$(this).next().next().next().next().next().next().next().text();
			totlprice=(parseFloat(totlprice)+parseFloat(price)).toFixed(2);
			var totalName=$(this).next().next().next().next().next().next().next().find("input").attr("name");
			$(this).next().next().next().next().next().next().next().empty();
		
			$(this).next().next().next().next().next().next().next().append('<input type="hidden" name="'+totalName+'"  value="'+totlprice+'"/>'+totlprice+'');
			var ordernumName=$(this).next().next().next().next().next().next().find("input").attr("name");
			var ordernumcount=(Number(numplus)*1)+1;
			$(this).next().next().next().next().next().next().empty();
			$(this).next().next().next().next().next().next().append('<input type="hidden" name="'+ordernumName+'"  value="'+ordernumcount+'"/>'+ordernumcount+'');
			$( "#dialog" ).dialog('close');
			firstnum=false;
		}
		})
		})
if(firstnum==true){	
	var msg=list.id.split(",");
    show.push('<tr>');
    show.push('<td class="td1" style="display:none"><input type="hidden" name=storesorderitem['+num+'].product_id value="'+msg[0]+'"/><input type="hidden" name=storesorderitem['+num+'].prod_code value="'+msg[1]+'"/>'+ msg[1] +'</td>') ;
    show.push('<td class="td1" style="display:none"> <input type="hidden" name=storesorderitem['+num+'].bar_code value="'+msg[2]+'"/>'+ msg[2] +'</td>');
    show.push('<td class="td1" style="display:none">天佑德</td>');
    show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].title  value="'+msg[3]+'"/>'+ msg[3] +'</td>');
    show.push('<td class="td1" style="display:none"><input type="hidden" name=storesorderitem['+num+'].spec  value="'+msg[4]+'"/>'+ msg[4] +'</td>') ;
    show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].product_price  value="'+msg[5]+'"/>'+ msg[5] +'</td>') ;
    show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].order_num  value="1"/>1</td>') ;
    show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].order_total_price  value="'+msg[5]+'"/>'+ msg[5] +'</td>') ;
    show.push(' <td class="td1 op-area"><a id="rmtr'+num+'" onclick="javascript:ondeltr(this)" href="javascript:void(0)" class="input-red">删除</a></td>') ;
    show.push('</tr>');
   $("#qkj_list").append(show.join(""));
   $( "#dialog" ).dialog('close');
   show=new Array();
}
	firstnum=true;
};
function ondeltr(data){
	$("#"+data.id).parents("tr").remove();
}
function fortr(list){
	 var procode = list[0].prod_code;
		$("#qkj_list").find("tr").each(function(){
			$(this).find("td").each(function(){
				if($(this).text()==procode){
					var numplus=$(this).next().next().next().next().next().next().text();
					var price=$(this).next().next().next().next().next().text();
					var totlprice=$(this).next().next().next().next().next().next().next().text();
					totlprice=(parseFloat(totlprice)+parseFloat(price)).toFixed(2);
					var totalName=$(this).next().next().next().next().next().next().next().find("input").attr("name");
					$(this).next().next().next().next().next().next().next().empty();
					$(this).next().next().next().next().next().next().next().append('<input type="hidden" name="'+totalName+'"  value="'+totlprice+'"/>'+totlprice+'');
					var ordernumName=$(this).next().next().next().next().next().next().find("input").attr("name");
					var ordernumcount=(Number(numplus)*1)+1;
					$(this).next().next().next().next().next().next().empty();
					$(this).next().next().next().next().next().next().append('<input type="hidden" name="'+ordernumName+'"  value="'+ordernumcount+'"/>'+ordernumcount+'');
					firstnum=false;
			}
			})
			})
	if(firstnum==true){
  	for (var i = 0; i < list.length; i++) {
  		var product_id=list[i].uuid;
	    var procode = list[i].prod_code;
	    var barcode=list[i].bar_code;
         var title = list[i].title;
         var spec = list[i].spec;
         var marketprice = list[i].market_price;
         show.push('<tr>');
         show.push('<input type="hidden" name=storesorderitem['+num+'].product_id value="'+product_id+'"/>')
         show.push('<td class="td1" style="display:none"><input type="hidden" name=storesorderitem['+num+'].prod_code value="'+procode+'"/>'+ procode +'</td>') ;
         show.push('<td class="td1" style="display:none"><input type="hidden" name=storesorderitem['+num+'].bar_code value="'+barcode+'"/>'+ barcode +'</td>');
         show.push('<td class="td1" style="display:none">天佑德</td>');
         show.push('<td class="td1" ><input type="hidden" name=storesorderitem['+num+'].title  value="'+title+'"/>'+ title +'</td>');
         show.push('<td class="td1" style="display:none"><input type="hidden" name=storesorderitem['+num+'].spec  value="'+spec+'"/>'+ spec +'</td>') ;
         show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].product_price  value="'+marketprice+'"/>'+ marketprice +'</td>') ;
         show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].order_num  value="1"/>1</td>') ;
         show.push('<td class="td1"><input type="hidden" name=storesorderitem['+num+'].order_total_price  value="'+marketprice+'"/>'+ marketprice +'</td>') ;
         show.push(' <td class="td1 op-area"><a id="rmtr'+num+'" onclick="javascript:ondeltr(this)" href="javascript:void(0)" class="input-red">删除</a></td>') ;
         show.push('</tr>');
        $("#qkj_list").append(show.join(""));
         show=new Array();
}
}
}
/* $("#sumbit_order").click(function(){
	var data = '{"persons":[	';
	var num=1;
$("#qkj_list").find("tr").each(function(){
        var tdArr = $(this).children();
        var procode = tdArr.eq(0).text();
	    var barcode=tdArr.eq(1).text();
         var title = tdArr.eq(2).text();
         var spec =tdArr.eq(3).text();
         var dealerprice = tdArr.eq(4).text();
         if(num==2){
        	data += '{"procode":"'+procode+'","barcode":"'+barcode+'","title":"'+title+'","spec":"'+spec+'","dealerprice":"'+dealerprice+'"}';    
         }else if(num!=1){
         data += ',{"procode":"'+procode+'","barcode":"'+barcode+'","title":"'+title+'","spec":"'+spec+'","dealerprice":"'+dealerprice+'"}';
         data = data + "{\\\"procode\\\":\\\""+procode+"\\\",\\\"barcode\\\":\\\""+barcode+"\\\",\\\"title\\\":\\\""+title+"\\\,\\\"spec\\\":\\\""+spec+"\\\,\\\"dealerprice\\\":\\\""+dealerprice+"\\\"},";

         }
         num++;
         }) 
      data += ']}';
    }); */
    
    $(function(){
    	SimpleLoadProducts(function(){},"noparam=true");
     });
</script>
</html>