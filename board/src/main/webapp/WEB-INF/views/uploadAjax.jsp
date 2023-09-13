<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload with Ajax</title>
<style type="text/css">
	.uploadResult {
		width : 100%;
		background-color: gray; 
	}
	.uploadResult ul {
		display: flex;
		flex-flow: row;
		
	}
</style>
<body>
	<h1>Upload with Ajax</h1>

	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	
	<button id='uploadBtn'>Upload</button>
	<div class="uploadResult">
		<ul></ul>
	</div>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous">
	</script>
	<script>
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 23100000; //5MB

		function checkExtension(fileName, fileSize) {

			if (fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}

			if (regex.test(fileName)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}

		var cloneObj = $(".uploadDiv").clone();
		
		$(document).ready(function() {

			$("#uploadBtn").on("click", function(e) {

				var formData = new FormData();

				var inputFile = $("input[name='uploadFile']");

				var files = inputFile[0].files;

				for (var i = 0; i < files.length; i++) {

					if (!checkExtension(files[i].name, files[i].size)) {
						return false;
					}

					formData.append("uploadFile", files[i]);
				}

				$.ajax({
					url : '/uploadAjaxAction',
					processData : false,
					contentType : false,
					data : formData,
					type : 'POST',
					dataType: 'json',
					success : function(result) {
						alert("Upload");
						showUploadedFile(result);
						$('.uploadDiv').html(cloneObj.html());
					},
					error : function() {
						alert("fail");
					}
				});
			});
			
			let uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr) {
				let str = "";
				
				$(uploadResultArr).each(function(i, obj) {
					str += "<li>" + obj.fileName + "</li>";
				});
				
				uploadResult.append(str);
			}
			
		});
	</script>
</body>
</html>