<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="设置" scope="request" />
<jsp:include page="../includes/header.jsp" />

<div class="well shadow">
	<c:url var="addUrl" value="edit" />
	<form id="settingform" action="${addUrl}" method="post">
		<legend>
			设置
			<input id="saveform" type="submit" class="btn btn-info pull-right" value="保存" />
		</legend>
		<div class="row">
			<div class="span4">

				<div class="control-group">
					<label class="control-label" for="name">回答问题积分</label>
					<c:set var="responseDic" value="${settingform.responseDic}" />
					<input type="hidden" path="responseDic.id" name='responseDic.id' id="responseDic.id" class="input-xxlarge"
						value="${responseDic.id}" />
					<input type="hidden" path="responseDic.name" name='responseDic.name' id="responseDic.name" class="input-xxlarge"
						value="${responseDic.name}" />
					<div class="controls">
						<input path="responseDic.val" name='responseDic.val' id="responseDic.val" value="${responseDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">农技达人回答问题获取积分系数</label>
					<c:set var="njdrDic" value="${settingform.njdrDic}" />
					<input type="hidden" path="njdrDic.id" name='njdrDic.id' id="njdrDic.id" class="input-xxlarge"
						value="${njdrDic.id}" />
					<input type="hidden" path="njdrDic.name" name='njdrDic.name' id="njdrDic.name" class="input-xxlarge"
						value="${njdrDic.name}" />
					<div class="controls">
						<input path="njdrDic.val" name='njdrDic.val' id="njdrDic.val" value="${njdrDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">每天回答问题能获取的最多积分</label>
					<c:set var="maxonedayDic" value="${settingform.maxonedayDic}" />
					<input type="hidden" path="maxonedayDic.id" name='maxonedayDic.id' id="maxonedayDic.id" class="input-xxlarge"
						value="${maxonedayDic.id}" />
					<input type="hidden" path="maxonedayDic.name" name='maxonedayDic.name' id="maxonedayDic.name" class="input-xxlarge"
						value="${maxonedayDic.name}" />
					<div class="controls">
						<input path="maxonedayDic.val" name='maxonedayDic.val' id="maxonedayDic.val" value="${maxonedayDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">采纳答案积分</label>
					<c:set var="adoptDic" value="${settingform.adoptDic}" />
					<input type="hidden" path="adoptDic" name='adoptDic.id' id="adoptDic.id" class="input-xxlarge"
						value="${adoptDic.id}" />
					<input type="hidden" path="adoptDic" name='adoptDic.name' id="adoptDic.name" class="input-xxlarge"
						value="${adoptDic.name}" />
					<div class="controls">
						<input path="adoptDic.val" name='adoptDic.val' id="adoptDic.val" value="${adoptDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">点赞积分</label>
					<c:set var="zanDic" value="${settingform.zanDic}" />
					<input type="hidden" path="zanDic.id" name='zanDic.id' id="zanDic.id" class="input-xxlarge" value="${zanDic.id}" />
					<input type="hidden" path="zanDic.name" name='zanDic.name' id="zanDic.name" class="input-xxlarge"
						value="${zanDic.name}" />
					<div class="controls">
						<input path="zanDic.val" name='zanDic.val' id="zanDic.val" value="${zanDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">签到积分</label>
					<c:set var="signinDic" value="${settingform.signinDic}" />
					<input type="hidden" path="signinDic.id" name='signinDic.id' id="signinDic.id" class="input-xxlarge"
						value="${signinDic.id}" />
					<input type="hidden" path="signinDic.name" name='signinDic.name' id="signinDic.name" class="input-xxlarge"
						value="${signinDic.name}" />
					<div class="controls">
						<input path="signinDic.val" name='signinDic.val' id="signinDic.val" value="${signinDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">注册积分</label>
					<c:set var="regDic" value="${settingform.regDic}" />
					<input type="hidden" path="regDic.id" name='regDic.id' id="regDic.id" class="input-xxlarge" value="${regDic.id}" />
					<input type="hidden" path="regDic.name" name='regDic.name' id="regDic.name" class="input-xxlarge"
						value="${regDic.name}" />
					<div class="controls">
						<input path="regDic.val" name='regDic.val' id="regDic.val" value="${regDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">评价订单积分</label>
					<c:set var="scoringDic" value="${settingform.scoringDic}" />
					<input type="hidden" path="scoringDic.id" name='scoringDic.id' id="scoringDic.id" class="input-xxlarge"
						value="${scoringDic.id}" />
					<input type="hidden" path="scoringDic.name" name='scoringDic.name' id="scoringDic.name" class="input-xxlarge"
						value="${scoringDic.name}" />
					<div class="controls">
						<input path="scoringDic.val" name='scoringDic.val' id="scoringDic.val" value="${scoringDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">刮刮乐消耗积分</label>
					<c:set var="guaguaDic" value="${settingform.guaguaDic}" />
					<input type="hidden" path="guaguaDic" name='guaguaDic.id' id="guaguaDic.id" class="input-xxlarge"
						value="${guaguaDic.id}" />
					<input type="hidden" path="guaguaDic" name='guaguaDic.name' id="guaguaDic.name" class="input-xxlarge"
						value="${guaguaDic.name}" />
					<div class="controls">
						<input path="guaguaDic.val" name='guaguaDic.val' id="guaguaDic.val" value="${guaguaDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="name">提交妙招获取积分</label>
					<c:set var="adviceDic" value="${settingform.adviceDic}" />
					<input type="hidden" path="adviceDic" name='adviceDic.id' id="adviceDic.id" class="input-xxlarge"
						value="${adviceDic.id}" />
					<input type="hidden" path="adviceDic" name='adviceDic.name' id="adviceDic.name" class="input-xxlarge"
						value="${adviceDic.name}" />
					<div class="controls">
						<input path="adviceDic.val" name='adviceDic.val' id="adviceDic.val" value="${adviceDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">妙招被点赞获取积分</label>
					<c:set var="advicegetDic" value="${settingform.advicegetDic}" />
					<input type="hidden" path="advicegetDic" name='advicegetDic.id' id="advicegetDic.id" class="input-xxlarge"
						value="${advicegetDic.id}" />
					<input type="hidden" path="advicegetDic" name='advicegetDic.name' id="advicegetDic.name" class="input-xxlarge"
						value="${advicegetDic.name}" />
					<div class="controls">
						<input path="advicegetDic.val" name='advicegetDic.val' id="advicegetDic.val" value="${advicegetDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="name">分享一次获取积分</label>
					<c:set var="shareDic" value="${settingform.shareDic}" />
					<input type="hidden" path="shareDic" name='shareDic.id' id="shareDic.id" class="input-xxlarge"
						value="${shareDic.id}" />
					<input type="hidden" path="shareDic" name='shareDic.name' id="shareDic.name" class="input-xxlarge"
						value="${shareDic.name}" />
					<div class="controls">
						<input path="shareDic.val" name='shareDic.val' id="shareDic.val" value="${shareDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="name">每天分享获得的最高积分数</label>
					<c:set var="shareMaxDic" value="${settingform.shareMaxDic}" />
					<input type="hidden" path="shareMaxDic" name='shareMaxDic.id' id="shareMaxDic.id" class="input-xxlarge"
						value="${shareMaxDic.id}" />
					<input type="hidden" path="shareMaxDic" name='shareMaxDic.name' id="shareMaxDic.name" class="input-xxlarge"
						value="${shareMaxDic.name}" />
					<div class="controls">
						<input path="shareMaxDic.val" name='shareMaxDic.val' id="shareMaxDic.val" value="${shareMaxDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				
				
				<div class="control-group">
					<label class="control-label" for="name">提交种植分享获取积分</label>
					<c:set var="plantinfoDic" value="${settingform.plantinfoDic}" />
					<input type="hidden" path="plantinfoDic" name='plantinfoDic.id' id="plantinfoDic.id" class="input-xxlarge"
						value="${plantinfoDic.id}" />
					<input type="hidden" path="plantinfoDic" name='plantinfoDic.name' id="plantinfoDic.name" class="input-xxlarge"
						value="${plantinfoDic.name}" />
					<div class="controls">
						<input path="plantinfoDic.val" name='plantinfoDic.val' id="plantinfoDic.val" value="${plantinfoDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="name">附近农资店距离阈值</label>
					<c:set var="nzdDic" value="${settingform.nzdDic}" />
					<input type="hidden" path="nzdDic.id" name='nzdDic.id' id="nzdDic.id" class="input-xxlarge" value="${nzdDic.id}" />
					<input type="hidden" path="nzdDic.name" name='nzdDic.name' id="nzdDic.name" class="input-xxlarge"
						value="${nzdDic.name}" />
					<div class="controls">
						<input path="nzdDic.var" name='nzdDic.var' id="nzdDic.var" value="${nzdDic.var}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">秒杀距离阈值</label>
					<c:set var="secondDic" value="${settingform.secondDic}" />
					<input type="hidden" path="secondDic.id" name='secondDic.id' id="secondDic.id" class="input-xxlarge"
						value="${secondDic.id}" />
					<input type="hidden" path="secondDic.name" name='secondDic.name' id="secondDic.name" class="input-xxlarge"
						value="${secondDic.name}" />
					<div class="controls">
						<input path="secondDic.var" name='secondDic.var' id="secondDic.var" value="${secondDic.var}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">农资店配方个数</label>
					<c:set var="recipeDic" value="${settingform.recipeDic}" />
					<input type="hidden" path="recipeDic.id" name='recipeDic.id' id="recipeDic.id" class="input-xxlarge"
						value="${recipeDic.id}" />
					<input type="hidden" path="recipeDic.name" name='recipeDic.name' id="recipeDic.name" class="input-xxlarge"
						value="${recipeDic.name}" />
					<div class="controls">
						<input path="recipeDic.var" name='recipeDic.var' id="recipeDic.var" value="${recipeDic.var}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">积分兑换比例</label>
					<c:set var="exchangeDic" value="${settingform.exchangeDic}" />
					<input type="hidden" path="exchangeDic.id" name='exchangeDic.id' id="exchangeDic.id" class="input-xxlarge"
						value="${exchangeDic.id}" />
					<input type="hidden" path="exchangeDic.name" name='exchangeDic.name' id="exchangeDic.name" class="input-xxlarge"
						value="${exchangeDic.name}" />
					<div class="controls">
						<input path="exchangeDic.var" name='exchangeDic.var' id="exchangeDic.var" value="${exchangeDic.var}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">每天刮刮乐次数</label>
					<c:set var="guanumDic" value="${settingform.guanumDic}" />
					<input type="hidden" path="guanumDic.id" name='guanumDic.id' id="guanumDic.id" class="input-xxlarge"
						value="${guanumDic.id}" />
					<input type="hidden" path="guanumDic.name" name='guanumDic.name' id="guanumDic.name" class="input-xxlarge"
						value="${guanumDic.name}" />
					<div class="controls">
						<input path="guanumDic.var" name='guanumDic.var' id="guanumDic.var" value="${guanumDic.var}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">好评加分</label>
					<c:set var="haoDic" value="${settingform.haoDic}" />
					<input type="hidden" path="haoDic.id" name='haoDic.id' id="haoDic.id" class="input-xxlarge" value="${haoDic.id}" />
					<input type="hidden" path="haoDic.name" name='haoDic.name' id="haoDic.name" class="input-xxlarge"
						value="${haoDic.name}" />
					<div class="controls">
						<input path="haoDic.val" name='haoDic.val' id="haoDic.val" value="${haoDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">中评加分</label>
					<c:set var="zhongDic" value="${settingform.zhongDic}" />
					<input type="hidden" path="zhongDic.id" name='zhongDic.id' id="zhongDic.id" class="input-xxlarge"
						value="${zhongDic.id}" />
					<input type="hidden" path="zhongDic.name" name='zhongDic.name' id="zhongDic.name" class="input-xxlarge"
						value="${zhongDic.name}" />
					<div class="controls">
						<input path="zhongDic.val" name='zhongDic.val' id="zhongDic.val" value="${zhongDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="name">差评加分</label>
					<c:set var="chaDic" value="${settingform.chaDic}" />
					<input type="hidden" path="chaDic.id" name='chaDic.id' id="chaDic.id" class="input-xxlarge" value="${chaDic.id}" />
					<input type="hidden" path="chaDic.name" name='chaDic.name' id="chaDic.name" class="input-xxlarge"
						value="${chaDic.name}" />
					<div class="controls">
						<input path="chaDic.val" name='chaDic.val' id="chaDic.val" value="${chaDic.val}" />
						<span class="help-inline"></span>
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="control-group">
					<label class="control-label" for="name">积分规则说明</label>
					<c:set var="pointsdesDic" value="${settingform.pointsdesDic}" />
					<input type="hidden" path="pointsdesDic.id" name='pointsdesDic.id' id="pointsdesDic.id" class="input-xxlarge"
						value="${pointsdesDic.id}" />
					<input type="hidden" path="pointsdesDic.name" name='pointsdesDic.name' id="pointsdesDic.name" class="input-xxlarge"
						value="${pointsdesDic.name}" />
					<div class="controls">
						<textarea path="pointsdesDic.description" name='pointsdesDic.description' style="width: 90%; height: 200px;">${pointsdesDic.description}</textarea>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<c:url var="cssUrl" value="/assets/uploadify-v3.1/uploadify.css" />
<link rel="stylesheet" href="${cssUrl}" type="text/css"></link>
<c:url var="jsUrl" value="/assets/uploadify-v3.1/jquery.uploadify-3.1.min.js" />
<script type="text/javascript" src="${jsUrl}"></script>

<script>
	function addFormValidate() {
		$("#settingform").validate({
			debug : true,
			rules : {
				title : {
					required : true
				},
				content : {
					required : true
				}
			},

			messages : {
				title : {
					required : "必填"
				},
				content : {
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
</script>


<jsp:include page="../includes/footer.jsp" />