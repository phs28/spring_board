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
							Board Register Page
						</div>
						
						<!-- /.panel-heading -->
						<div class="panel-body">
							<form action="/board/register" method="post">
								<div class="form-group">
	                            	<label>제목</label>
	                            	<input class="form-control" name="title">
                                </div>
                                <div class="form-group">
	                            	<label>작성자</label>
	                            	<input class="form-control" name="writer">
                                </div>
                                <div class="form-group">
                                    <label>글내용</label>
                                    <textarea style="resize: none" class="form-control" rows="5" name="content"></textarea>
                                </div>
                                
                                <button type="submit" class="btn btn-success">Write</button>
                                <button type="reset" class="btn btn-danger">return</button>
                                <button type="button" class="btn btn-info" onclick="location.href='/board/list'">List</button>
							</form>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 -->
			</div>
	</div>
	<!-- /#wrapper -->
	
	<%@include file="../includes/footer.jsp"%>
	