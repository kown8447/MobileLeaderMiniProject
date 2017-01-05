<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-------------------------------------------------------------------------- 
				OS 정보를 Table 형태로 보여주는 부분
 ---------------------------------------------------------------------------->
<div class="row" style="margin-left: 15%">
	<table class="table table-striped table-condensed table-hover" style="width: 80%; margin-left: 3%; margin-top: 7%">
		<tr><th colspan="2" style="text-align: center">OS 정보</td></tr>
		<tr><td style="width: 50%">OS name</td><td id="os1" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">OS Arch</td><td id="os2" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">Available Processors</td><td id="os3" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">TotalPhysicalMemorySize</td><td id="os4" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">FreePhysicalMemorySize</td><td id="os5" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">TotalSwapSpaceSize</td><td id="os6" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">FreeSwapSpaceSize</td><td id="os7" style="text-align: center"></td></tr>
		<tr><td style="width: 50%">CommittedVirtualMemorySize</td><td id="os8" style="text-align: center"></td></tr>
	</table>
</div>
