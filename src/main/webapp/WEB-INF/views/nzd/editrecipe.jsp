<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="编辑配方" scope="request" />
<jsp:include page="header.jsp" />


<section class="well shadow">
	<c:url var="addUrl" value="/nzd/index/edit" />	
	<form id="reicpe" action="${addUrl}" method="post">
		<fieldset>
			<legend>配方信息				
				<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
			</legend>
			<div class="divnull">&nbsp;&nbsp;</div>
			<div class="control-group">
				<label class="control-label" for="name">标题</label>
				<input type="hidden" path="id" name='id' id="id" class="input-xxlarge" value="${recipe.id}" />
				<div class="controls">
					<input path="title" name='title' id="title" class="input-xxlarge" placeholder="输入配方标题" value="${recipe.title}" />
					<span class="help-inline"></span>
				</div>
			</div>
			<br />
			<br />
			<div class="control-group">
				<label class="control-label" for="description">描述</label>
				<div class="controls">
					<textarea rows="5" path="description" name='description' id="description" class="span8" placeholder="输入描述信息" >${recipe.description}</textarea>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="price">原价</label>
				<div class="controls">
					<input path="price" name="price" id="price" class="input-xxlarge" value="${recipe.price}" placeholder="输入原价"  onkeyup="clearNoNum(this)" maxlength="10"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="newprice">现价</label>
				<div class="controls">
					<input path="newprice" name='newprice' id="newprice" class="input-xxlarge" value="${recipe.newprice}" placeholder="输入现价"  onkeyup="clearNoNum(this)" maxlength="10"/>
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="description">主治病害</label>
				<div class="controls">
					<select class="selectpicker" name="disease.id" id="disease.id" path="disease.id">
					<c:forEach items="${diseases}" var="disease">
						<option value="${disease.id}"<c:if test="${disease.id == recipe.did}">selected</c:if>><c:out value="${disease.name}" /></option>
					</c:forEach>
					</select>
					<span class="help-inline"></span>
				</div>
			</div>
			<br />
			<br />
			<input type="file" name="uploadify" id="multiple_file_upload" />
			<div id="attachmentsdiv">
				<c:set value="0" var="sum" />
				<c:forEach items="${recipe.attachments}" var="attachment">
					<div id="panel${sum}" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">
						<img class="image" src="${imageUrl}/${attachment.url}" />
						<a class="imageClose" href="javascript:deleteImagePanel(${sum})"></a>
						<input type="hidden" path="attachments[${sum}].id" name="attachments[${sum}].id" id="attachments[${sum}].id" value="${attachment.id}" />
						<input type="hidden" path="attachments[${sum}].url" name="attachments[${sum}].url" id="attachments[${sum}].url" value="${attachment.url}" />
					</div>
					<c:set value="${sum + 1}" var="sum" />
				</c:forEach>
			</div>
			
		</fieldset>
	</form>
</section>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
	var recipeUpload;
	$(document).ready(function() {
		
		setplaceholderSupport();
		addFormValidate();
		
		$("#multiple_file_upload").uploadify({  
			'removeTimeOut' :0,
            'buttonText'    : '上传图片...',  
            'swf'           : '<c:url value="/assets/uploadify-v3.1/uploadify.swf"/>',  
            'uploader'      : '<c:url value="/nzd/index/bash;jsessionid=${pageContext.session.id}"/>',  
            'fileTypeExts'  : '*.jpg;*.png;*.gif;*.bmp', 
            'onDialogOpen':function() {
            	$("#saveform").attr("disabled",true);
            },
            'onUploadSuccess':function(file,data,response){
            	if(data == "failure" || data==""){
            		bootbox.alert({  
                        buttons: {  
                           ok: {  
                                label: '确定',  
                                className: 'btn-myStyle'  
                            }  
                        },  
                        message: "抱歉，图片："+file.name+"上传失败！",   
                        title: "提示",  
                    });
                }
            	else{
            		var itemid = $("#attachmentsdiv").children('div').length;
                	var html = '<div id="panel'+itemid+'" style="width:150px;height:150px;display:inline-block;position: relative;margin: 0px 5px;border: solid 1px #ccc;">';
                    html += '<img class="image" src="${imageUrl}/'+data+'" />';
                    html += '<a class="imageClose" href="javascript:deleteImagePanel('+itemid+')"></a>';
                    html += '<input type="hidden" path="attachments[' + itemid + '].url" name="attachments[' + itemid + '].url" id="attachments[' + itemid + '].url" value="' + data + '" />';
                    html += '</div>';

                    $("#attachmentsdiv").append(html);
            	}
            	
            },
            'onQueueComplete' : function(stats) {
            	$("#saveform").attr("disabled",false);
            } 
            
        });  						

	});
	function clearNoNum(obj)
    {
        //先把非数字的都替换掉，除了数字和.
        obj.value = obj.value.replace(/[^\d.]/g,"");
        //必须保证第一个为数字而不是.
        obj.value = obj.value.replace(/^\./g,"");
        //保证只有出现一个.而没有多个.
        obj.value = obj.value.replace(/\.{2,}/g,".");
        //保证.只出现一次，而不能出现两次以上
        obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
    }
	
	function addFormValidate() {
		$("#reicpe").validate(
				{
					debug : true,
					rules : {
						title : {
							required : true
						},
						description : {
							required : true
						},
						price : {
							required : true
						},
						newprice : {
							required : true
						}
					},

					messages : {
						title : {
							required : "必填"
						},
						description : {
							required : "必填"
						},
						price : {
							required : "必填"
						},
						newprice : {
							required : "必填"
						}
					},

					errorClass : 'invalid',
					validClass : 'invalid',
					errorPlacement : function(error, element) {
						 element.nextAll(".help-inline").html(error);

					},
					success : function(label) {
						label.html("");
					},
					submitHandler : function(form) {
						form.submit();	
					}
				});
	}
	
	function deleteImagePanel(id) {
        $("#panel" + id).remove();
    }
	
</script>
<jsp:include page="../includes/footer.jsp" />