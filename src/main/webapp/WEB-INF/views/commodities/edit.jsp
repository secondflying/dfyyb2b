<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑商品" scope="request" />
<jsp:include page="../includes/proheader.jsp" />


<section class="well">
	<c:if test="${review!=null }">
		<div class="alert alert-error">
		  未能通过用户审核,原因如下：${review.opinion }。可编辑后继续提交审核。时间：${review.time }
		</div>
	</c:if>
	<c:url var="addUrl" value="editone" />
	<form id="commodity2" action="${addUrl}" method="post">
		<fieldset>
			<legend>
				商品
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存并提交" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="row">
				<div class="column span7">
				<div class="control-group">
					<label class="control-label" for="name">名称</label>
					<div class="controls">
						<input path="name" name='name' id="name" class="span5" placeholder="商品名称" value="${commodity.name }" required/>
						<span class="help-inline"></span>
						<input type="hidden" id="id" name="id" value="${commodity.id }"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="cname">是否是宣传产品</label>
					<div class="controls">
						<input  path="isad" name='isad' id="isad" type="checkbox"  ${commodity.isad?"checked":""}
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="cname">类别</label>
					<div class="controls">
						<input path="cname" name='cname' id="cname" class="span5" placeholder="" required value="${commodity.type.name }"/>
						<span class="help-inline"></span>
						<input id="cid" name="cid"type="hidden" value="${commodity.type.id }"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="unit">单位</label>
					<select class="span5" name="unit" id="unit" required>
						<c:forEach items="${units}" var="unit">
							<c:choose>
							   <c:when test="${commodity.unit.id==unit.id }">   
	                            <option value="${unit.id }" selected="">
									${unit.name }
								</option>      
							   </c:when>
							   <c:otherwise> 
							    <option value="${unit.id }">
									${unit.name }
								</option>
							   </c:otherwise>
							</c:choose> 
						</c:forEach>
					</select>
				</div>
				<div class="control-group">
						<label class="control-label" for="oprice">原价</label>
						<div class="controls">
							<input path="oprice" name='oprice' id="oprice" class="span5" placeholder="原价" required onkeyup="clearNoNum(this)" value="${commodity.oprice }"/>
							<span class="help-inline"></span>
						</div>
					</div>
				<div class="control-group">
					<label class="control-label" for="price">现价</label>
					<div class="controls">
						<input path="price" name='price' id="price" class="span5" placeholder="现价" required onkeyup="clearNoNum(this)" value="${commodity.price }" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
						<label class="control-label" for="retail">零售价</label>
						<div class="controls">
							<input path="retail" name='retail' id="retail" class="span5" placeholder="零售价" required onkeyup="clearNoNum(this)"  value="${commodity.retail }"/>
							<span class="help-inline"></span>
						</div>
					</div>
				<div class="control-group">
					<label class="control-label" for="factory">厂家</label>
					<div class="controls">
						<input path="factory" name='factory' id="factory" class="span5" placeholder="厂家名称" required value="${commodity.factory }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="code">登记证号</label>
					<div class="controls">
						<input path="code" name='code' id="code" class="span5" placeholder="登记证号" required value="${commodity.code }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="standard">规格</label>
					<div class="controls">
						<input path="standard" name='standard' id="standard" class="span5" placeholder="规格" required value="${commodity.standard }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="composition">成分及含量</label>
					<div class="controls">
						<input path="composition" name='composition' id="composition" class="span5" placeholder="成分及含量"  required value="${commodity.composition }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="number">起订量</label>
					<div class="controls">
						<input path="number" name='number' id="number" class="span5" placeholder="起订量" required onkeyup="clearNoNum(this)" value="${commodity.number }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
						<label class="control-label" for="maxcount">限量</label>
						<div class="controls">
							<input path="maxcount" name='maxcount' id="maxcount" class="span5" placeholder="限量" required onkeyup="clearNoNum(this)" value="${commodity.maxcount }"/>
							<span class="help-inline"></span>
						</div>
					</div>
				<div class="control-group">
					<label class="control-label" for="step">增减阶梯步长</label>
					<div class="controls">
						<input path="step" name='step' id="step" class="span5" placeholder="增减阶梯步长" required onkeyup="clearNoNum(this)" value="${commodity.step }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="brokerage">业务员佣金比例</label>
					<div class="controls">
						<input path="brokerage" name='brokerage' id="brokerage" class="span5" placeholder="${strbrokerage }" required onkeyup="clearNoNum(this)" value="${commodity.brokerage }"/>
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
						<label class="control-label" for="rebatedays">返利期限</label>
						<div class="controls">
							<input path="rebatedays" name='rebatedays' id="rebatedays" class="span5" placeholder="天数" required onkeyup="clearNoNum(this)" value="${commodity.rebatedays }" />
							<span class="help-inline"></span>
						</div>
					</div>
				<div class="control-group">
					<label class="control-label" for="zonename">区域</label>
					<div class="controls">
						<input path="zonename" name='zonename' id="zonename" class="span5" placeholder="区域" required value="${commodity.zone.name }"/>
						<span class="help-inline"></span>
						<input id="zoneid" name="zone.id"type="hidden" value="${commodity.zone.id }"/>
					</div>
				</div>
			</div>
				<div class="column span4">
					<div class="bs-docs-example">
						<legend>
							<h4>阶梯价格
							<a id="add1" class="btn btn-small btn-success pull-right"  href="#jgModal" data-toggle="modal">
								添加
							</a>
							</h4>
						</legend>
						<div class="divnull">&nbsp;&nbsp;</div>
						<table id="pricetable" class="table table-bordered">
						 	<thead>
								<tr>
									<td align="center">最小数量</td>
<!-- 									<td align="center">最大数量</td> -->
									<td align="center">价格</td>
									<td align="center">操作</td>
								</tr>
							</thead>
							<tbody>
								<c:set var="i" value="0"></c:set>
								<c:forEach items="${gprices}" var="gprice">
									<tr>
										<td><input class='transinput' id='gprices[${i }].minnumber' name='gprices[${i }].minnumber' readonly='readonly' type='text' value='${gprice.minnumber }' onkeyup='clearNoNum(this)'/></td>
<%-- 										<td><input class='transinput' id='gprices[${i }].maxnumber' name='gprices[${i }].maxnumber' readonly='readonly' type='text' value='${gprice.maxnumber }' onkeyup='clearNoNum(this)'/></td> --%>
										<td><input class='transinput' id='gprices[${i }].price' name='gprices[${i }].price' readonly='readonly' type='text' value='${gprice.price }' onkeyup='clearNoNum(this)'/></td>
										<td><a id='pages${i }' class='icon pull-right' href='javascript:delprice(${i })'><i class='icon-remove'></i></a></td>
									</tr>
									<c:set var="i" value="${i+1 }"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="bs-docs-example">
						<legend>
							<h4>
							阶梯返利
							<a id="add2" class="btn btn-small btn-success pull-right"  href="#flModal" data-toggle="modal">
								添加
							</a>
							</h4>
						</legend>
						<div class="divnull">&nbsp;&nbsp;</div>
						<table id="rebatetable" class="table table-bordered">
						 	<thead>
								<tr>
									<td align="center">最小数量</td>
<!-- 									<td align="center">最大数量</td> -->
									<td align="center">返利</td>
									<td align="center">操作</td>
								</tr>
							</thead>
							<tbody>
								<c:set var="j" value="0"></c:set>
								<c:forEach items="${grebates}" var="grebate">
									<tr>
										<td><input class='transinput' id='grebates[${j }].minnumber' name='grebates[${j }].minnumber' readonly='readonly' type='text' value='${grebate.minnumber }' onkeyup='clearNoNum(this)'/></td>
<%-- 										<td><input class='transinput' id='grebates[${j }].maxnumber' name='grebates[${j }].maxnumber' readonly='readonly' type='text' value='${grebate.maxnumber }' onkeyup='clearNoNum(this)'/></td> --%>
										<td><input class='transinput' id='grebates[${j }].rebate' name='grebates[${j }].rebate' readonly='readonly' type='text' value='${grebate.rebate }' onkeyup='clearNoNum(this)'/></td>
										<td><a id='rebates${j }' class='icon pull-right' href='javascript:delrebate(${j })'><i class='icon-remove'></i></a></td>
									</tr>
									<c:set var="j" value="${j+1 }"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="column span11">
					<input type="file" name="uploadify" id="multiple_file_upload" />
					<p id="attachmenttip" class="text-error">请上传包装、内料、产品说明、田间实验图片(最多3张)；相关证书图片(最多3张)否则审核不能通过</p>
					<div id="attachmentsdiv">
						<c:set value="0" var="sum" />
						<c:forEach items="${docs}" var="doc">
							<div id="panel${sum}"
								style="width: 150px; height: 150px; display: inline-block; position: relative; margin: 0px 5px; border: solid 1px #ccc;">
								<img class="image" src="${imageUrl}/${doc.url}" />
								<a class="imageClose" href="javascript:deleteImagePanel(${sum})"></a>
								<input type="hidden" path="docs[${sum}].url" name="docs[${sum}].url" id="docs[${sum}].url"
									value="${doc.url}" />
							</div>
							<c:set value="${sum + 1}" var="sum" />
						</c:forEach>
					</div>
				</div>
			</div>
		</fieldset>
	</form>
</section>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					选择商品类别
				</h4>
			</div>
			<div class="modal-body" id="treeChooseZoneId">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<div class="modal hide fade" id="jgModal" data-backdrop="static" data-keyboard="false">
	<form id="addprice-form" class="form-horizontal"  method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">新增阶梯价格</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="name">最小数量</label>
				<div class="controls">
					<input type="text" id="gmin1" name="gmin1" class="span4" placeholder="最小数量" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
<!-- 			<div class="control-group"> -->
<!-- 				<label class="control-label" for="code">最大数量</label> -->
<!-- 				<div class="controls"> -->
<!-- 					<input type="text" id="gmax1" name="gmax1" class="span4" placeholder="最大数量" required onkeyup="clearNoNum(this)" /> -->
<!-- 					<span class="help-inline"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="control-group">
				<label class="control-label" for="code">价格</label>
				<div class="controls">
					<input type="text" id="gprice" name="gprice" class="span4" placeholder="价格" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
		</fieldset>
	</form>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnConfirm" onclick="gpriceclick();">确定</button>
	</div>
</div>
<div class="modal hide fade" id="flModal" data-backdrop="static" data-keyboard="false">
	<form id="addprice-form" class="form-horizontal"  method="post" enctype="multipart/form-data">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">新增阶梯返利</h3>
		</div>
		<br>
		<fieldset>
			<div class="control-group">
				<label class="control-label" for="name">最小数量</label>
				<div class="controls">
					<input type="text" id="gmin2" name="gmin2" class="span4" placeholder="最小数量" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
<!-- 			<div class="control-group"> -->
<!-- 				<label class="control-label" for="code">最大数量</label> -->
<!-- 				<div class="controls"> -->
<!-- 					<input type="text" id="gmax2" name="gmax2" class="span4" placeholder="最大数量" required onkeyup="clearNoNum(this)" /> -->
<!-- 					<span class="help-inline"></span> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="control-group">
				<label class="control-label" for="code">返利比例</label>
				<div class="controls">
					<input type="text" id="grebate" name="grebate" class="span4" placeholder="返利比例" required onkeyup="clearNoNum(this)" />
					<span class="help-inline"></span>
				</div>
			</div>
		</fieldset>
	</form>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
		<button class="btn btn-primary" id="btnConfirm" onclick="grebateclick();">确定</button>
	</div>
</div>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" style="display:none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					选择区域
				</h4>
			</div>
			<div class="modal-body" id="treeChooseZoneId1">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">
					关闭
				</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="cssUrl1" value="/assets/bootstrap/css/bootstrap-datetimepicker.min.css" />
<link href="${cssUrl1}" rel="stylesheet" media="screen">
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/moment.js"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="../../assets/bootstrap/js/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script>

$(document).ready(function () {
	setplaceholderSupport();
	addFormValidate(); 
	
	$("#multiple_file_upload").uploadify({
		'removeTimeOut' : 0,
		'buttonText' : '上传图片...',
		'swf' : '<c:url value="/assets/uploadify-v3.1/uploadify.swf"/>',
		'uploader' : '<c:url value="bash;jsessionid=${pageContext.session.id}"/>',
		'fileTypeExts' : '*.jpg;*.png;*.gif;*.bmp',
		'onDialogOpen' : function () {
			$("#saveform").attr("disabled", true);
		},
		'onUploadSuccess' : function (file, data, response) {
			if (data == "failure" || data == "") {
				bootbox.alert({
					buttons : {
						ok : {
							label : '确定',
							className : 'btn-myStyle'
						}
					},
					message : "抱歉，图片：" + file.name + "上传失败！",
					title : "提示",
				});
			} else {
				var itemid = $("#attachmentsdiv").children('div').length;
				var html = '<div id="panel' + itemid + '" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
				html += '<img class="image" src="${imageUrl}/' + data + '" />';
				html += '<a class="imageClose" href="javascript:deleteImagePanel(' + itemid + ')"></a>';
                html += '<input type="hidden" path="docs[' + itemid + '].url" name="docs[' + itemid + '].url" id="docs[' + itemid + '].url" value="' + data + '" />';
				html += '</div>';

				$("#attachmentsdiv").append(html);
			}

		},
		'onQueueComplete' : function (stats) {
			$("#saveform").attr("disabled", false);
		}

	});
	
	$('#treeChooseZoneId').load('<c:url value="/utils/select/commoditytypes" />');
	$('#cname').bind('click', function() {
		$('#myModal').modal( {
			keyboard : false
		})
	});
	
	$('#treeChooseZoneId1').load('<c:url value="/utils/select/zones" />');
	$('#zonename').bind('click', function() {
		$('#myModal1').modal( {
			keyboard : false
		})
	});

});

function addFormValidate() {
	$("#commodity2").validate({
		debug : true,
		rules : {
			name : {
				required : true
			},
			cname : {
				required : true
			},
			unit : {
				required : true
			},
			oprice : {
				required : true
			},
			price : {
				required : true
			},
			maxcount : {
				required : true
			},
			retail : {
				required : true
			},
			factory : {
				required : true
			},
			code : {
				required : true
			},
			standard : {
				required : true
			},
			composition : {
				required : true
			},
			number : {
				required : true
			},
			step : {
				required : true
			},
			brokerage : {
				required : true
			},
			zonename : {
				required : true
			}
		},

		messages : {
			name : {
				required : "必填"
			},
			cname : {
				required : "必填"
			},
			unit : {
				required : "必填"
			},
			oprice : {
				required : "必填"
			},
			price : {
				required : "必填"
			},
			maxcount : {
				required : "必填"
			},
			retail : {
				required : "必填"
			},
			factory : {
				required : "必填"
			},
			code : {
				required : "必填"
			},
			standard : {
				required : "必填"
			},
			composition : {
				required : "必填"
			},
			number : {
				required : "必填"
			},
			step : {
				required : "必填"
			},
			brokerage : {
				required : "必填"
			},
			zonename : {
				required : "必填"
			}
		},

		errorClass : 'invalid',
		validClass : 'invalid',
		errorPlacement : function (error, element) {
			element.nextAll(".help-inline").html(error);

		},
		success : function (label) {
			label.html("");
		},
		submitHandler : function (form) {
			var b = $('#brokerage').val();
			if(${min!=null}){
				if(Number(b)<${min}){
					bootbox.alert("超出佣金比例最小范围");
					return;
				}
			}
			if(${max!=null}){
				if(Number(b)>${max}){
					bootbox.alert("超出佣金比例最大范围");
					return;
				}
			}
			form.submit();
		}
	});
}

function clickCommodityType(id,sname,level) {
	$('#cname').val(sname);
	$('#cid').val(id);
	$('#myModal').modal('hide');

} 

function clickQuyuType(id,sname,level) {
	if(level==3){
		$('#zonename').val(sname);
		$('#zoneid').val(id);
		$('#myModal1').modal('hide');
	}
} 

function deleteImagePanel(id) {
	$("#panel" + id).remove();
}
function clearNoNum(obj) {
	//先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace(/[^\d.]/g, "");
	//必须保证第一个为数字而不是.
	obj.value = obj.value.replace(/^\./g, "");
	//保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g, ".");
	//保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".", "$#$").replace(/\./g, "").replace("$#$", ".");
}
function gpriceclick(){
	var all = true;
	var min = $('#gmin1').val();
	if(min==""||min==null){
		all = false;
		$('#gmin1').nextAll(".help-inline").html("必填");
	}
// 	var max = $('#gmax1').val();
// 	if(max==""||max==null){
// 		all = false;
// 		$('#gmax1').nextAll(".help-inline").html("必填");
// 	}
	var price = $('#gprice').val();
	if(price==""||price==null){
		all = false;
		$('#gprice').nextAll(".help-inline").html("必填");
	}
	if(!all){
		return;
	}
	
	var table1 = $('#pricetable'); 
	var firstTr = table1.find('tbody>tr'); 
	var row;
	row = $("<tr></tr>");
	var td = $("<td></td>"); 
	td.append($("<input class='transinput' id='gprices["+firstTr.length+"].minnumber' name='gprices["+firstTr.length+"].minnumber' readonly='readonly' type='text' value='"+min+"' onkeyup='clearNoNum(this)'/>"));
	row.append(td);
// 	var td1 = $("<td></td>"); 
// 	td1.append($("<input class='transinput' id='gprices["+firstTr.length+"].maxnumber' name='gprices["+firstTr.length+"].maxnumber' readonly='readonly' type='text' value='"+max+"' onkeyup='clearNoNum(this)'/>") ); 
// 	row.append(td1);
	var td11 = $("<td></td>"); 
	td11.append($("<input class='transinput' id='gprices["+firstTr.length+"].price' name='gprices["+firstTr.length+"].price' readonly='readonly' type='text' value='"+price+"' onkeyup='clearNoNum(this)'/>") ); 
	row.append(td11);
	var td2=$("<td></td>");
	td2.append($("<a id='pages"+firstTr.length+"' class='icon pull-right' href='javascript:delprice("+firstTr.length+")'><i class='icon-remove'></i></a>"));
	row.append(td2);	 
	table1.append(row); 
	
	$('#jgModal').modal('hide');
	$('#gmin1').val("");
	$('#gmin1').nextAll(".help-inline").html("");
// 	$('#gmax1').val("");
// 	$('#gmax1').nextAll(".help-inline").html("");
	$('#gprice').val("");
	$('#gprice').nextAll(".help-inline").html("");
}
function delprice(el){
	$("#pages"+el).parent().parent().remove();
}
function grebateclick(){
	var all = true;
	var min = $('#gmin2').val();
	if(min==""||min==null){
		all = false;
		$('#gmin2').nextAll(".help-inline").html("必填");
	}
// 	var max = $('#gmax2').val();
// 	if(max==""||max==null){
// 		all = false;
// 		$('#gmax2').nextAll(".help-inline").html("必填");
// 	}
	var rebate = $('#grebate').val();
	if(rebate==""||rebate==null){
		all = false;
		$('#grebate').nextAll(".help-inline").html("必填");
	}
	if(!all){
		return;
	}
	
	var table1 = $('#rebatetable'); 
	var firstTr = table1.find('tbody>tr'); 
	var row;
	row = $("<tr></tr>");
	var td = $("<td></td>"); 
	td.append($("<input class='transinput' id='grebates["+firstTr.length+"].minnumber' name='grebates["+firstTr.length+"].minnumber' readonly='readonly' type='text' value='"+min+"' onkeyup='clearNoNum(this)'/>"));
	row.append(td);
// 	var td1 = $("<td></td>"); 
// 	td1.append($("<input class='transinput' id='grebates["+firstTr.length+"].maxnumber' name='grebates["+firstTr.length+"].maxnumber' readonly='readonly' type='text' value='"+max+"' onkeyup='clearNoNum(this)'/>") ); 
// 	row.append(td1);
	var td11 = $("<td></td>"); 
	td11.append($("<input class='transinput' id='grebates["+firstTr.length+"].rebate' name='grebates["+firstTr.length+"].rebate' readonly='readonly' type='text' value='"+rebate+"' onkeyup='clearNoNum(this)'/>") ); 
	row.append(td11);
	var td2=$("<td></td>");
	td2.append($("<a id='rebates"+firstTr.length+"' class='icon pull-right' href='javascript:delrebate("+firstTr.length+")'><i class='icon-remove'></i></a>"));
	row.append(td2);	 
	table1.append(row); 
	
	$('#flModal').modal('hide');
	$('#gmin2').val("");
	$('#gmin2').nextAll(".help-inline").html("");
// 	$('#gmax2').val("");
// 	$('#gmax2').nextAll(".help-inline").html("");
	$('#grebate').val("");
	$('#grebate').nextAll(".help-inline").html("");
}
function delrebate(el){
	$("#rebates"+el).parent().parent().remove();
}
</script>
<jsp:include page="../includes/footer.jsp" />