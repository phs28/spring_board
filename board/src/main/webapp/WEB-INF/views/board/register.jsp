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
							<form role="form" action="/board/register" method="post">
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
			<div class="row">
	  <div class="col-lg-12">
	    <div class="panel panel-default">
	
	      <div class="panel-heading">File Attach</div>
	      <!-- /.panel-heading -->
	      <div class="panel-body">
	        <div class="form-group uploadDiv">
	            <input type="file" name='uploadFile' multiple>
	        </div>
	        
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
	</div>
	<!-- /#wrapper -->
	
	
	<%@include file="../includes/footer.jsp"%>
	
	<script>

$(document).ready(function(e){

	let formObj = $("form[role='form']");
  
  $("button[type='submit']").on("click", function(e){
    
    e.preventDefault();
    
    console.log("submit clicked");
    
    let str = "";
    
    $(".uploadResult ul li").each(function(i, obj){
      
      var jobj = $(obj);
      
      console.log("-------------------------");
      console.log(jobj.data("filename"));
      
      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
      
    });
    
    console.log(str);
    
    formObj.append(str).submit();
    
  });

  
  let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
  let maxSize = 5242880; //5MB
  
  function checkExtension(fileName, fileSize){
    
    if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
    }
    
    if(regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
    }
    return true;
  }
  
  $("input[type='file']").change(function(e){

	  let formData = new FormData();
	  let inputFile = $("input[name='uploadFile']");
	  let files = inputFile[0].files;
    
    for(let i = 0; i < files.length; i++){

      if(!checkExtension(files[i].name, files[i].size) ){
        return false;
      }
      formData.append("uploadFile", files[i]);
      
    }
    
    $.ajax({
      url: '/uploadAjaxAction',
      processData: false, 
      contentType: false,data: 
      formData,type: 'POST',
      dataType:'json',
        success: function(result){
          console.log(result); 
		  showUploadResult(result); //업로드 결과 처리 함수 

      }
    }); //$.ajax
    
  });  
  
  function showUploadResult(uploadResultArr){
	    
    if(!uploadResultArr || uploadResultArr.length == 0) { 
    	return; 
    }
    
    let uploadUL = $(".uploadResult ul");
    
    let str ="";
    
    $(uploadResultArr).each(function(i, obj){
    
		if(obj.image){
			let fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			
			str += "<li data-path='"+obj.uploadPath+"'";
			str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
			str +" ><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"'>";
			str += "</div>";
			str +"</li>";
		}else{
			let fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
			let fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		      
			str += "<li "
			str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
			str += "<span> "+ obj.fileName+"</span>";
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
			str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png'></a>";
			str += "</div>";
			str +"</li>";
		}

    });
    
    uploadUL.append(str);
  }

  $(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    let targetFile = $(this).data("file");
    let type = $(this).data("type");
    
    let targetLi = $(this).closest("li");
    
    $.ajax({
      url: '/deleteFile',
      data: {fileName: targetFile, type:type},
      dataType:'text',
      type: 'POST',
        success: function(result){
           alert(result);
           
           targetLi.remove();
         }
    }); //$.ajax
   });
  
});

</script>

	