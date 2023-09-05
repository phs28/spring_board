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
							Board Modify Page
						</div>
						<!-- /.panel-heading -->
						<form id="modifyForm" >
							<input type="hidden" name="pageNum" value="${cri.pageNum }">
							<input type="hidden" name="amount" value="${cri.amount }">
							<input type="hidden" name="type" value="${cri.type }">
							<input type="hidden" name="keyword" value="${cri.keyword }">
							
							<div class="panel-body">
								<div class="form-group">
		                        	<label>번호</label>
		                        	<input class="form-control" name="bno" value="${board.bno }"  readonly="readonly"/>
	                            </div>
								<div class="form-group">
		                        	<label>제목</label>
		                        	<input class="form-control" name="title" value="${board.title }" />
	                            </div>
	                            <div class="form-group">
		                        	<label>작성자</label>
		                        	<input class="form-control" name="writer" value="${board.writer }" readonly="readonly"/>
	                            </div>
	                            <div class="form-group">
	                                <label>글내용</label>
	                                <textarea style="resize: none" class="form-control" rows="5" name="content">${board.content }</textarea>
	                            </div>
	                            
	                            <button type="submit" data-oper='modify' class='btn btn-defult'>Modify</button>
	                            <button type="submit" data-oper='remove' class='btn btn-danger'>Remove</button>
	                            <button type="submit" data-oper='list' class="btn btn-info">List</button>
							</div>
						</form>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
	</div>
	<!-- /#wrapper -->
	
	<script type="text/javascript">
		$(document).ready(function () {
			
			let formObj = $('#modifyForm');
			
			$('button').on('click', function (e) {
				e.preventDefault();
				
				let operation = $(this).data('oper');
				console.log(operation);
				
				if(operation === 'remove') {
					formObj.attr('action', '/board/remove');
					formObj.attr('method', 'POST');
				} else if(operation === 'list') {
					formObj.attr('action', '/board/list');
					formObj.attr('method', 'GET');
					
					let pageNumTag = $("input[name = 'pageNum']").clone();
					let amountTag = $("input[name = 'amount']").clone();
					let typeTag = $("input[name = 'type']").clone();
					let keywordTag = $("input[name = 'keyword']").clone();
					
					formObj.empty();
					formObj.append(pageNumTag);
					formObj.append(amountTag);
					formObj.append(typeTag);
					formObj.append(keywordTag);
				} else if(operation === 'modify') {
					formObj.attr('action', '/board/modify');
					formObj.attr('method', 'POST');
				}
				formObj.submit();
			});
		});
	</script>
	
	<%@include file="../includes/footer.jsp"%>
	