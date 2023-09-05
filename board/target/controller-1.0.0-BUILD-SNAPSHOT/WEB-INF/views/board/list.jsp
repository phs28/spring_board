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
							Board List Page
						<button id="regBtn" type="button" class="btn btn-xs pull-right">Register New Board</button>
						</div>
						
						<!-- /.panel-heading -->
						<div class="panel-body">
							<table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
								<thead>
									<tr>
										<th>#번호</th>
										<th>제목</th>
										<th>내용</th>
										<th>작성자</th>
										<th>작성일</th>
										<th>수정일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${list }" var="vo">
									<tr>
										<td><c:out value="${vo.bno }" /></td>
										<td><a class="move" href='${vo.bno }'><c:out value="${vo.title }" /></a></td>
										<td><c:out value="${vo.content }" /></td>
										<td><c:out value="${vo.writer }" /></td>
										<td><fmt:formatDate pattern="yyyy-mm-dd" value="${vo.regdate }"/></td>
										<td><fmt:formatDate pattern="yyyy-mm-dd" value="${vo.updateDate }"/></td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
							
							<div class="row">
								<div class="col-lg-12">
									<form id="searchForm" action="/board/list" method="get">
										<select name="type">
											<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
											<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected':'' }" />>제목
											<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>내용</option>
											<option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected':'' }" />>작성자</option>
											<option value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected':'' }" />>제목 or 내용</option>
											<option value="TW" <c:out value="${pageMaker.cri.type == 'TW' ? 'selected':'' }" />>제목 or 작성자</option>
											<option value="TWC" <c:out value="${pageMaker.cri.type == 'TWC' ? 'selected':'' }" />>제목 or 내용 or 작성자</option>
										</select>
										<input type="text" name="keyword" value='${pageMaker.cri.keyword }'/>
										<input type="hidden" name="pageNum" value='${pageMaker.cri.pageNum }'/>
										<input type="hidden" name="amount" value='${pageMaker.cri.amount }'/>
										<button class="btn btn-default">Search</button>
									</form>						
								</div>
							</div>
							
							<div class="pull-right">
								<ul class="pagination">
									<c:if test="${pageMaker.prev }">
										<li class="page-link">
											<a href="${pageMaker.startPage - 1}">Previous</a>
										</li>
									</c:if>
									<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
										<li class="page-link ${pageMaker.cri.pageNum == num ? "active":""} ">
											<a href="${num}">${num}</a>
										</li>
									</c:forEach>
									<c:if test="${pageMaker.next }">
										<li class="page-link">
											<a href="${pageMaker.endPage + 1}">next</a>
										</li>
									</c:if>
								</ul>
							</div>
							
							<form id='actionForm' action="/board/list" method='get'>
								<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
								<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
								<input type='hidden' name='type' value='${pageMaker.cri.type}'>
								<input type='hidden' name='keyword' value='${pageMaker.cri.keyword}'> 
							</form>
							
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                                        </div>
                                        <div class="modal-body">처리가 완료되었습니다.</div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
                                        </div>
                                    </div>
                                    <!-- /.modal-content -->
                                </div>
                                <!-- /.modal-dialog -->
                            </div>
						</div>
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
			
			let result = '${result}';
			console.log(result);
				
			checkModal(result);
			
			history.replaceState({}, null, null);
			
		function checkModal(result) {
			
			if(result === '' || history.state) {
				return;
			}
				
			if(result === '') {
				return;
			}
					
			if(parseInt(result) > 0) {
				$('.modal-body').html('게시글' + parseInt(result) + ' 번이 등록되었습니다.');
			}
			
				$('#myModal').modal('show');
			}
		
			$('#regBtn').on('click', function () {
				
				self.location = '/board/register';
			});
			
			let actionForm = $('#actionForm');
			
			$(".page-link a").on('click', function(e) {
			 	e.preventDefault();
				
				console.log('click');
				
				let target = $(this).attr("href");
				
				actionForm.find("input[name='pageNum']").val(target);
				actionForm.submit();
			});
			
			$('.move').on('click', function (e) {
				e.preventDefault();
				
				let target = $(this).attr("href");
				console.log(target);
				
				actionForm.append("<input type='hidden' name='bno' value='" + target + "'>");
				actionForm.attr("action", "/board/get");
				actionForm.submit();
			});
		});
		
		let searchForm = $("#searchForm");

		$("#searchForm button").on("click", function(e) {
			if (!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();

			searchForm.submit();
		});
	</script>
	
	<%@include file="../includes/footer.jsp"%>
	