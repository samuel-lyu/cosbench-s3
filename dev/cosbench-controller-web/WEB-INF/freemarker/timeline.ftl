<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="resources/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="resources/css/style.css" rel='stylesheet' type='text/css' />
	<link href="resources/css/font-awesome.css" rel="stylesheet"> 
	<link href='https://fonts.googleapis.com/css?family=Roboto:700,500,300,100italic,100,400' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" type="text/css" href="resources/cosbench.css" />
  <title>Stage Timeline Status</title>
</head>
<body>
	<#include "navigationBar.ftl">
		
	<div id="rightContent">
		<#include "header.ftl">
		<div id="main">
		<div class="top"><br /></div>
		<div class="content">
		  <p>
			<a href="index.html">index</a> ->
			<a href="workload.html?id=${wInfo.id}">workload</a> ->
			<a href="stage.html?wid=${wInfo.id}&sid=${sInfo.id}">stage</a> ->
			<span>timeline</span>
		  </p>
		  <h2>Stage</h2>
		  <h3>Basic Info</h3>
		  <p>
			<span class="grid">
			  <span class="label"><strong>ID:</strong></span>
			  ${sInfo.id}
			</span>
			<span class="grid">
			  <span class="label"><strong>Name:</strong></span>
			  ${sInfo.stage.name}
			</span>
			<span class="grid">
			  <span class="label"><strong>Interval:</strong></span>
			  <#if (sInfo.interval > 0) > 
				${sInfo.interval} s
			  <#else>
				N/A
			  </#if>
			</span>
			<span class="grid">
			  <span class="label"><strong>Current State:</strong></span>
			  <span class="stage-state-${sInfo.state?lower_case} state">${sInfo.state?lower_case}</span>
			</span>
		  </p>
		  <h3>Timeline Status</h3>
		  <#assign allSnapshots = sInfo.snapshots >
		  <#include "timeline-metrics.ftl">
		  <p><a href="timeline.csv?wid=${wInfo.id}&sid=${sInfo.id}">export CSV file</a></p>
		  <p><a href="stage.html?wid=${wInfo.id}&sid=${sInfo.id}">go back to stage</a></p>
		</div> <#-- end of content -->
		<div class="bottom"><br /></div>
		</div> <#-- end of main -->
		<#include "footer.ftl">
	</div>

	<script src="resources/js/jquery-1.10.2.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/nav.js"></script>
</body>
</html>