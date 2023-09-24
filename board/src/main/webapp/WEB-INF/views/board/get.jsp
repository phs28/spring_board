<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
	<%@include file="../includes/header.jsp" %>
	<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

</style>
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
			<div class='row'>

	 	<div class="col-lg-12">
		
		<div class="row">
		  <div class="col-lg-12">
		    <div class="panel panel-default">
		
		      <div class="panel-heading">Files</div>
		      <!-- /.panel-heading -->
		      <div class="panel-body">
		        
		        <div class='uploadResult'> 
		          <ul>
		          </ul>
		        </div>
		      </div>
		      <!--  end panel-body -->
		    </div>
		    <!--  end panel-body -->
		  </div>
		  <!-- end panel -->
		</div>
		<!-- /.row -->
		<div class='bigPictureWrapper'>
  		<div class='bigPicture'>
  		</div>
		</div>
    <!-- /.panel -->
    <div class="panel panel-default">
      
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw">Reply</i> 
        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
      </div>      
      
      <!-- /.panel-heading -->
      <div class="panel-body">        
      
        <ul class="chat">
			<!-- start reply -->
        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->
      
      <div class="panel-footer">

      </div>
	</div>
  </div>
  <!-- ./ end row -->
</div>
			
	</div>
	<!-- /#wrapper -->
	

<!-- Modal -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
        aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">Reply Write</h4>
            </div>
            <div class="modal-body">
              <div class="form-group">
                <label>Reply</label> 
                <input class="form-control" name='reply' value='New Reply!!!!'>
              </div>      
              <div class="form-group">
                <label>Replyer</label>
                <input class="form-control" name='replyer' value='replyer'>
              </div>
              <div class="form-group">
                <label>Reply Date</label> 
                <input class="form-control" name='replyDate' value=''>
              </div>
            </div>
		  	<div class="modal-footer">
	        <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
	        <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
	        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
	        <button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
	      </div>          
      </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
	
	<script type="text/javascript" src="/resources/js/reply.js"></script>
	
	<script type="text/javascript">
	
	$(document).ready(function () {
		let bnoValue = "${board.bno}";
		let replyUL = $(".chat");
		
		showList(1);
		
		function showList(page) {
			
			console.log("show list.." + page);
		    
		    replyService.getList({bno:bnoValue, page:page || 1 }, function(replyCnt, list) {
		      
		    console.log("replyCnt: "+ replyCnt );
		    console.log("list: " + list);
		    
		    if(page == -1){
		      pageNum = Math.ceil(replyCnt/10.0);
		      showList(pageNum);
		      return;
		    }
		      
		    let str="";
		    if(list == null || list.length == 0) {
		      return;
		    }
		    
		    for (var i = 0, len = list.length || 0; i < len; i++) {
		      str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
		      str +="<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>"; 
		      str +="<small class='pull-right text-muted'>"+replyService.formatDate(list[i].replyDate)+"</small></div>";
		      str +="<p>"+list[i].reply+"</p></div></li>";
		    }
		    
		    replyUL.html(str);
		    
		    showReplyPage(replyCnt);
		   });
		 }
		
		let pageNum = 1;
		let replyPageFooter = $(".panel-footer");
	    
	    function showReplyPage(replyCnt){
	      
	      let endNum = Math.ceil(pageNum / 10.0) * 10;  
	      let startNum = endNum - 9; 
	      
	      let prev = startNum != 1;
	      let next = false;
	      
	      if(endNum * 10 >= replyCnt){
	        endNum = Math.ceil(replyCnt/10.0);
	      }
	      
	      if(endNum * 10 < replyCnt){
	        next = true;
	      }
	      
	      let str = "<ul class='pagination pull-right'>";
	      
	      if(prev){
	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
	      }
	      
	      for(let i = startNum; i <= endNum; i++){
	        
	    	let active = pageNum == i ? "active":"";
	        
	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
	      }
	      
	      if(next){
	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
	      }
	      
	      str += "</ul></div>";
	      
	      console.log(str);
	      
	      replyPageFooter.html(str);
	    }
	     
	    replyPageFooter.on("click","li a", function(e){
	       e.preventDefault();
	       console.log("page click");
	       
	       let targetPageNum = $(this).attr("href");
	       
	       console.log("targetPageNum: " + targetPageNum);
	       
	       pageNum = targetPageNum;
	       
	       showList(pageNum);
	     });
		
		//reply 모달창
		
		let modal = $(".modal");
		let modalInputReply = modal.find("input[name='reply']");
		let modalInputReplyer = modal.find("input[name='replyer']");
		let modalIntputReplyDate = modal.find("input[name='replyDate']");
		
		let modalModBtn = $("#modalModBtn");
		let modalRemoveBtn = $("#modalRemoveBtn");
		let modalRegisterBtn = $("#modalRegisterBtn");
		let modalCloseBtn = $("#modalCloseBtn");
		
		$("#addReplyBtn").on("click", function(e) {
			
			modal.find("input").val("");
			modalIntputReplyDate.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		modalRegisterBtn.on("click", function (e) {
			
			let reply = {
					reply:modalInputReply.val(),
					replyer:modalInputReplyer.val(),
					bno:bnoValue
			};
			
			replyService.add(reply, function(result) {
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				
				showList(1);
			});
		});
		
		modalCloseBtn.on("click", function(e) {
			modal.modal("hide");	
		})
		
		$(".chat").on("click", "li", function(e) {
			let rno = $(this).data("rno");
			
			replyService.get(rno, function (reply) {
				
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalIntputReplyDate.val(replyService.formatDate(reply.replyDate)).attr("readonly", "readonly");
				modal.data("rno", reply.rno);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		modalModBtn.on("click", function(e) {
			let reply = {rno:modal.data("rno"), reply:modalInputReply.val()};	
			
			replyService.update(reply, function(result) {
				alert(result);
				modal.modal("hide");
				showList(1);
			});
		});
		
		modalRemoveBtn.on("click", function(e) {
			let rno = modal.data("rno");
			
			replyService.remove(rno, function(result) {
				modal.modal("hide");
				showList(1);
			})
		});
	});
	
  	
	$(document).ready(function () {
		
		let actionForm = $("#actionForm");	
		
		$('.listBtn').click(function (e) {
			e.preventDefault();
			actionForm.find("input[name='bno']").remove();
			actionForm.submit();
		});
		
		$('.modBtn').click(function (e) {
			e.preventDefault();
			actionForm.attr("action", "/board/modify.do");
			actionForm.submit();
		});		
	});
	
	$(document).ready(function() {
		 (function(){
			  
		  let bno = '<c:out value="${board.bno}"/>';
		  
		  $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
		        
		       console.log(arr);
		       
		       var str = "";
		       
		       $(arr).each(function(i, attach){
		       
		         //image type
		         if(attach.fileType){
		           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
		           
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<img src='/display?fileName="+fileCallPath+"'>";
		           str += "</div>";
		           str +"</li>";
		         }else{
		             
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<span> "+ attach.fileName+"</span><br/>";
		           str += "<img src='/resources/img/attach.png'></a>";
		           str += "</div>";
		           str +"</li>";
		         }
		       });
		       
		       $(".uploadResult ul").html(str);
		       
		       
		     });//end getjson
		})();//end function
		
		$(".uploadResult").on("click", "li", function(e) {
			console.log("view image");
			
			let liObj = $(this);
			let path = encodeURIComponent(liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename"));
			
			if(liObj.data("type")) {
				showImage(path.replace(new RegExp(/\\/g), "/"));
			} else {
				self.location = "/download?fileName="+path;
			}
			
		});
		
		function showImage(fileCallPath){
		    
		    alert(fileCallPath);
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='/display?fileName="+fileCallPath+"' >")
		    .animate({width:'100%', height: '100%'}, 1000);
		    
		  }

		  $(".bigPictureWrapper").on("click", function(e){
		    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){
		      $('.bigPictureWrapper').hide();
		    }, 1000);
		  });
		
	});
	</script>
	
	<%@include file="../includes/footer.jsp"%>
