<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
	<%@include file="../includes/header.jsp" %>

		<div id="page-wrapper">
			<div class="row">
				<div class="col-lg-12">
					<h1 class="page-header">Tables</h1>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							Board Read Page
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div class="form-group">
	                        	<label>번호</label>
	                       		<input class="form-control" name="bno" value="${board.bno }" readonly="readonly"/>
                            </div>
							<div class="form-group">
	                        	<label>제목</label>
	                        	<input class="form-control" name="title" value="${board.title }" readonly="readonly"/>
                            </div>
                            <div class="form-group">
	                        	<label>작성자</label>
	                        	<input class="form-control" name="writer" value="${board.writer }" readonly="readonly"/>
                            </div>
                            <div class="form-group">
                                <label>글내용</label>
                                <textarea style="resize: none" class="form-control" rows="5" name="content" readonly="readonly">${board.content }</textarea>
                            </div>
                            
                            <form id='actionForm' action="/board/list" method='get'>
								<input type='hidden' name='pageNum' value='${cri.pageNum}'>
								<input type='hidden' name='amount' value='${cri.amount}'>
								<input type='hidden' name='amount' value='${cri.type}'>
								<input type='hidden' name='amount' value='${cri.keyword}'>
								<input type='hidden' name='bno' value='${board.bno}'>
							</form>
                            
                            <button type="button" class='btn btn-defult modBtn' >Modify</button>
                            <button type="button" class='btn btn-info listBtn' onclick="location.href='/board/list'">list</button>
                            
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
	</div>
	<!-- /#wrapper -->
	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function () {
		
		console.log("==============");
		console.log("JS TEST")
		
		let bnoValue = '${board.bno}';
		
		replyService.getList({bno:bnoValue, page:1}, function(list) {
			
			for(var i=0, len = list.length||0; i<len; i++) {
				console.log(list[i]);
			}
		});
		
// 		replyService.add(
// 			{reply:'JS TEST', replyer:'tester', bno:bnoValue}
// 			,
// 			function (result) {
// 				alert("RESULT: " + result);
// 			}
// 		);
		
// 		replyService.remove(20, function (count) {
// 			console.log(count);
			
// 			if(count == 'success') {
// 				alert('REMOVED');
// 			}
// 		}, function (err) {
// 			alert('ERROR...');
// 		});
		
		let actionForm = $("#actionForm");	
		
		$('.listBtn').click(function (e) {
			e.preventDefault();
			actionForm.find("input[name='bno']").remove();
			actionForm.submit();
		});
		
		$('.modBtn').click(function (e) {
			e.preventDefault();
			actionForm.attr("action", "/board/modify");
			actionForm.submit();
		});	
	});
// 		let operForm = $('#operForm');
		
// 		$('button[data-oper="modify"]').on('click', function (e) {
// 			e.preventDefault();
			
// 			operForm.attr("action", "/board/modify");
// 			operForm.attr("method", "get");
// 			operForm.submit();
// 		})
		
// 		$('button[data-oper="list"]').on('click', function (e) {
// 		e.preventDefault();
			
// 		operForm.find('#bno').remove();
// 		operForm.attr("action", "/board/list");
// 		operForm.attr("method", "get");
// 		operForm.submit();
//		 })
		
		
	</script>
	
	<%@include file="../includes/footer.jsp"%>