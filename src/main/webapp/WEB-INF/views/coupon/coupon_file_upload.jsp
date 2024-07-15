<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드</title>
<link rel="stylesheet" type="text/css"
	href="../css/bootstrap.min_4.5.0.css">
<script src="../js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
</head>
<body>
	<div class="container p-3 my-3 border">
		<div class="row">
			<div class="col-md-5">
				<div class="card-body">
					<%--파일 업로드에 필요한 enctype을 설정하고 POST 메서드로 전송해야 한다.--%>
					<form action="./CouponFileUpload" method="post"
						enctype="multipart/form-data" id="signupForm">
						<fieldset>
							<div class="form-group row">
								<label for="name" class="ml-sm-4 col-form-label"> 이름 </label>
								<div class="ml-sm-4">
									<input type="text" name="name" id="name" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label for="subject" class="ml-sm-4 col-form-label"> 제목
								</label>
								<div class="ml-sm-4">
									<input type="text" name="subject" id="subject"
										class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<div class="ml-sm-4">
									<input type="file" name="fileName" id="fileName"
										class="form-control-file">
								</div>
							</div>
							<div class="form-group ml-sm-2">
								<button type="submit" class="btn btn-primary btn-sm">
									전송</button>
								<button type="reset" class="btn btn-primary btn-sm">취소
								</button>
							</div>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>