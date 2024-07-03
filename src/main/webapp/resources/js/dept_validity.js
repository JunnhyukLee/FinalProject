// 폼 경고를 경고창으로 호출한다.
$(function() {
	// 유효성 검사를 위한 기본 설정을 수정한다.
	$.validator.setDefaults({
	 onkeyup : false,
	 onclick : false,
	 onfocusout : false,
	 showErrors : function(errorMap, errorList) {
		 // 유효하지 않은 필드의 수를 반환한다.
		 if (this.numberOfInvalids()) {
			 alert(errorList[0].message);
		 }
	 }
	});
	// 정규 표현식을 사용할 수 있도록 설정한다..
	$.validator.addMethod("regex", function(value, element, regexpr) {
		// 정규 표현식의 문자열에 일치하는 부분이 있는지 확인한다.
		return regexpr.test(value);
	});
	$("#sign_dept").validate({
	 rules : {
	  deptno : {
	   required : true,
	   digits : true,
	   maxlength : 2
	  },
	  dname : {
	   required : true,
	   minlength : 2,
	   maxlength : 4,
	   // 공백이나 특수문자를 확인한다.
	   regex : /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
	  },
	  loc : {
	   required : true,
	   minlength : 2,
	   maxlength : 4,
	   // 공백이나 특수문자를 확인한다.
	   regex : /^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$/
	  }
	 },
	 messages : {
	  deptno : {
	   required : "부서 번호를 입력하세요.",
	   digits : "숫자로만 입력하세요.",
	   maxlength : "최대 {0}자리 숫자입니다."
	  },
	  dname : {
	   required : "부서 이름을 입력하세요.",
	   minlength : "최소 {0} 글자입니다.",
	   maxlength : "최대 {0} 글자입니다.",
	   regex : "공백이나 특수문자를 제거하세요."
	  },
	  loc : {
	   required : "부서 지역을 입력하세요.",
	   minlength : "최소 {0} 글자입니다.",
	   maxlength : "최대 {0} 글자입니다.",
	   regex : "공백이나 특수문자를 제거하세요."
	  }
	 }
	});
});