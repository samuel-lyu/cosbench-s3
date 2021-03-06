<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="resources/css/bootstrap.min.css" rel='stylesheet' type='text/css' />
	<link href="resources/css/style.css" rel='stylesheet' type='text/css' />
	<link href="resources/css/font-awesome.css" rel="stylesheet"> 
	<link rel="stylesheet" type="text/css" href="resources/cosbench.css" />
	<script src="resources/js/jquery-1.10.2.min.js"></script>
	<script src="resources/js/echarts.js"></script>
	
  <title>Stage Timeline Status</title>
</head>
<body>
	<#include "navigationBar.ftl">
		
	<div id="rightContent">
		<#include "header.ftl">
		<div id="main">
			<div class="top"><br /></div>
			<div id="tabs" class="tabs">
				<div class="graph">
					<nav>
						<ul>
							<li><a href="#section-1" class="icon-cup"><i class="lnr lnr-lighter"></i> <span>Chart</span></a></li>
							<li><a href="#section-2" class="icon-shop"><i class="lnr lnr-briefcase"></i> <span>Data</span></a></li>
						</ul>
					</nav>
					<div class="content tab" style="width:100%">
						<section id="section-1">
							<div class="SelectMetricsToShowDiv" style="margin:10px 0px">
								<h3 style="display:inline-block;margin:0px">Metric to show:&nbsp;</h3>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=throughput"><input type="button" name="metricsName" value="Throughput" checked="true"></input></a>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=bandWidth"><input type="button" name="metricsName" value="BandWidth"></input></a>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=byteCount"><input type="button" name="metricsName" value="ByteCount"></input></a>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=opCount"><input type="button" name="metricsName" value="OpCount"></input></a>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=avgResTime"><input type="button" name="metricsName" value="AvgResTime"></input></a>
								<a href="?wid=${wInfo.id}&sid=${sInfo.id}&metricName=avgProceTime"><input type="button" name="metricsName" value="AvgProceTime"></input></a>
							</div>
							<#assign allSnapshots = sInfo.snapshots>
							<#include "timeline-echarts.ftl">
						</section>
						<section id="section-2">
							<div >
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
						</section>
						
					</div>
				</div>	
			</div>
			<div class="clearfix"> </div>
			<div class="bottom"><br /></div>
		</div> <#-- end of main -->
		<#include "footer.ftl">
	</div>

	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/cbpFWTabs.js"></script>
	<script>
		new CBPFWTabs( document.getElementById( 'tabs' ) );
	</script>
</body>
</html>