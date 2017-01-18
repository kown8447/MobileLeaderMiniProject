<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="page-header">
	<h1><span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>  DISK 정보</h1>
</div>
<div class="row" style="margin-top: 10%">
<!-------------------------------------------------------------------------- 
						DISK 용량을 텍스트 형태로 보여주는 부분
---------------------------------------------------------------------------->
	<div class="col-md-3" style="margin-top: 5%; margin-left: 20%">
		<form class="form-inline">
			<div class="form-group">
				<label for="exampleInputName2">전체 공간</label> 
				<span id="total"></span>
			</div>
		</form>
		<form class="form-inline">
			<div class="form-group">
				<label for="exampleInputName2" style="color:#AE758A">사용 공간</label> 
				<span id="use"></span>
			</div>
		</form>
		<form class="form-inline">
			<div class="form-group">
				<label for="exampleInputName2" style="color:#AACCE2">사용가능 공간</label> 
				<span id="usable"></span>
			</div>
		</form>
		<input type="button" id="checkDiskDetail" class="btn btn-default" value="파티션별 용량 확인"/>
	</div>
	<!-------------------------------------------------------------------------- 
					DISK 용량을 Chart 형태로 보여주는 부분
	 ---------------------------------------------------------------------------->
	<div class="col-md-5">
		<div id="container"></div>
	</div>
</div>

<!-------------------------------------------------------------------------- 
					파티션별 DISK 용량을 출력하는 Modal 부분
	 ---------------------------------------------------------------------------->
<div class="modal fade" id="diskDetail">
	<div class="modal-dialog modal-lg">
		<div class="modal-content modal-lg">
			<!-- header -->
			<div class="modal-header">
				<!-- 닫기(x) 버튼 -->
				<button type="button" class="close" data-dismiss="modal">×</button>
				<!-- header title -->
				<h4 class="modal-title">파티션별 디스트 용량</h4>
			</div>
			<!-- body -->
			<div class="modal-body" id="modalBody">
				<table id="resultDiskDetail" class="table table-bordered">
					<tr>
						<th>Disk Name</th><th>Total Size(GB)</th><th>Usable Size(GB)</th><th>Used Size(GB)</th>
					</tr>
				</table>
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-------------------------------------------------------------------------- 
					Disk 용량이 10% 이하 남았을 경우 경고창
---------------------------------------------------------------------------->
<div class="modal fade" id="dsikAlert">
	<div class="modal-dialog modal-md">
		<div class="modal-content modal-md">
			<!-- header -->
			<div class="modal-header">
				<!-- 닫기(x) 버튼 -->
				<button type="button" class="close" data-dismiss="modal">×</button>
				<!-- header title -->
				<h4 class="modal-title" style="color:red"><b>디스크 경고</b></h4>
			</div>
			<!-- body -->
			<div class="modal-body" id="modalBody">
				디스크 용량이 10% 미만 남았습니다. 디스크 교체 또는 정리하는 것을 권장합니다.
			</div>
			<!-- Footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
