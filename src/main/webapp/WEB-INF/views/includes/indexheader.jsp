<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title><c:out value="${pageTitle}" /></title>
<link rel="icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="/assets/img/favicon.ico" mce_href="/assets/img/favicon.ico" type="image/x-icon">
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<c:url var="cssUrl" value="/assets/bootstrap/css/bootstrap.css" />
<link href="${cssUrl}" rel="stylesheet" />
<c:url var="cssUrl2" value="/assets/jquery/plugin/DataTables/css/jquery.dataTables.css" />
<link href="${cssUrl2}" rel="stylesheet" />
<c:url var="cssUrl3" value="/assets/css/css.css" />
<link href="${cssUrl3}" rel="stylesheet" />

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
          <script src="../../assets/javascript/html5.js"></script>
        <![endif]-->

<jsp:include page="js.jsp" />
</head>
<body>
	<div class="tiles">
		<c:if test="${message != null}">
			<div class="alert alert-success" id="message">
				<c:out value="${message}" />
			</div>
		</c:if>
		<h1 id="title">
			<c:out value="${pageTitle}" />
		</h1>