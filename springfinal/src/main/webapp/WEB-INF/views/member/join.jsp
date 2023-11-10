<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
$(function(){
    

  // ID 문자열 검사 코드
  $("[name=memberId]").blur(function() {
    var regex = /^[a-z][a-z0-9]{4,19}$/;
    var inputId = $(this).val(); // Updated to refer to $(this) directly
    console.log(inputId);
    var isValid = regex.test(inputId); // Updated to use 'id' directly
    //긍정, 부정 class 제거
    $(this).removeClass("is-valid is-invalid");
    $(".id-feedback").removeClass("is-valid is-invalid");
    //기본 설명문 생성
    $('.d-id-feedback').removeClass("text-danger").show();
    if (isValid && inputId!=null) {
    	// 이미 사용중이 아이디인지 체크
    	$.ajax({
    		url:"http://localhost:8080/member/checkId",
    		method: "post", 
            data: { memberId: inputId }, 
   			success: function(response){
   				$('.d-id-feedback').hide();
   	          $("[name=memberId]").addClass("is-valid");
   	          $(".id-feedback").addClass("is-valid")
   			}
    	});
        }
        else{
          $(this).addClass("is-invalid");
          $('.d-id-feedback').addClass("text-danger");
        }
      });

      //이메일 형식 검사 코드
  $("[name=memberEmail]").blur(function(){
    var inputEmail = $(this).val();
    var regex = /\S+@\S+\.\S+/;
    var isValid = regex.test(inputEmail)
    $(this).removeClass("is-valid is-invalid");
    $(".email-feedback").removeClass("is-valid is-invalid");
    $(".d-e-feedback").removeClass("text-danger");
    if (!isValid) {
      $(this).addClass("is-invalid");
      $(".email-feedback").addClass("is-invalid");
      $(".d-e-feedback").addClass("text-danger");
    }
    else{
    	   $(this).addClass("is-valid");
    }
  });


  //생년월일 형식 검사 코드
  $("[name=memberBirth]").blur(function(){
    var inputContent = $(this).val();
    var regex = /^\d{8}$/;
    var isValid = regex.test(inputContent)
    $(this).removeClass("is-invalid is-valid");
    $(".d-brith-feedback").removeClass("text-danger");
    if(isValid){
      $(this).addClass("is-valid");
    }
    else{
      $(this).addClass("is-invalid");
      $(".d-brith-feedback").addClass("text-danger");
    }
  });
  
  //연락처 형식 검사 코드
  $("[name=memberContect]").blur(function(){
    var inputContent = $(this).val();
    var regex = /^\d{10,11}$/;
    var isValid = regex.test(inputContent)
    $(this).removeClass("is-invalid is-valid");
    $(".d-content-feedback").removeClass("text-danger");
    if(isValid){
      $(this).addClass("is-valid");
    }
    else{
      $(this).addClass("is-invalid");
      $(".d-content-feedback").addClass("text-danger");
    }
  });

});
      
</script>

<body>
<div class="contain-fluid">
  <div class="row">
    <div class="col">
      <div class="row">
        <div class="col text-center">
          <h1 class="h1">회원가입</h1>
        </div>
      </div>

      <form action="./join" method="post">
        <div class="row mt-4"><div class="col">
          <div class="input-group has-validation">
            <div class="form-floating id-feedback">
              <input type="text" class="form-control" name="memberId" id="inputId" placeholder="아이디" required>
              <label for="inputId">아이디</label>
              <div class="feedback gray d-id-feedback">영어 숫자로 이루어진 글자 5~20자를 작성해주세요</div>
            </div>
            <div class="invalid-feedback">
              이미사용중인 아이디입니다
            </div>
            <div class="valid-feedback">
              사용가능한 아이디입니다.
            </div>
          </div>
        </div></div>


        <div class="row mt-2"><div class="col">
          <div class="input-group has-validation">
            <div class="form-floating">
              <input type="text" class="form-control" name="memberPw" id="inputPw" placeholder="비밀번호" required>
              <label for="inputPw">비밀번호</label>
            </div>
          </div>
        </div></div>


        <div class="row mt-2"><div class="col">
          <div class="input-group has-validation">
            <div class="form-floating">
              <input type="text" class="form-control" name="memberName" id="memberName" placeholder="실명" required>
              <label for="memberName">실명</label>
            </div>
          </div>
        </div></div>





        <div class="row mt-2"><div class="col">
          <div class="input-group has-validation">
            <span class="input-group-text">@</span>
            <div class="form-floating email-feedback">
              <input type="email" class="form-control" name="memberEmail" id="memberEmail" placeholder="이메일" required>
              <label for="memberEmail">이메일</label>
            </div>
            <div class="invalid-feedback">
              이메일 형식의 맞게 적어주세요.
            </div>
          </div>
        </div></div>



        <div class="row mt-2"><div class="col">
          <div class="input-group has-validation">
            <div class="form-floating">
              <input type="text" class="form-control" name="memberContect" id="memberContect" placeholder="연락처" required>
              <label for="memberContect">연락처</label>
            </div>
          </div>
          <div class="d-content-feedback">
            '-'을 제외하고 숫자로만 적어주세요
          </div>
        </div></div>
        
        <div class="row mt-2"><div class="col">
          <div class="input-group has-validation">
            <div class="form-floating">
              <input type="text" class="form-control" name="memberBirth" id="memberBirth" placeholder="생년월일" required>
              <label for="memberBirth">생년월일</label>
              <div class="d-brith-feedback">
                '-'을 제외하고 숫자로만 적어주세요.ex->19901201
              </div>
            </div>
          </div>
        </div></div>
        
        
        
        <div class="row mt-4">
          <div class="col">
            <label>주소</label>
              <input type="search" class="form-control search-input"
                  placeholder="검색할 주소 입력">
          </div>                    
      </div>
      <div class="row">
          <div class="col">
              <ul class="list-group addr-list">
	                 
              </ul>
          </div>
      </div>

      <div class="row mt-4">
          <div class="col">
              <h1>다음내용</h1>
          </div>
      </div>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
<script>
$(function(){
  
  
	
	//[1] 다 숨겨
  $(".addr-list").hide();

  //[2] 검색하면 찾아서 보여줘
  $(".search-input").blur("input", function(){
      var keyword = $(this).val();
      console.log(keyword);
    //db에 있는 주소 비동기로 조회후 가져오는 구문
      $.ajax({
    	url: "http://localhost:8080/zip/search",
    	method: "post",
    	data:{searchVal : keyword},
      	success: function(response) {
      		console.log(response);
      	}
      });
      
      
      if(keyword.length == 0) {
          $(".addr-list").hide();
          return;
      }

      var count = 0;
      $(".addr-list").each(function(idx, el){
          var text = $(el).text().trim();
          //var index = text.indexOf(keyword);
          //if(index >= 0) {
          if(count < 5 && Hangul.search(text, keyword) >= 0) {
              $(el).show();
              count++;
          }
          else {
              $(el).hide();
          }
      });
  });

  //[3] 목록 누르면 입력창에 넣어
  $(".addr-list").find(".list-group-item").click(function(){
      $(".search-input").val($(this).text());
      $(".addr-list").hide();
  });
});
</script>
        
        
        
        

        <div class="row mt-4"><div class="col">
          <label class="form-input">등급(지울예정)</label>
          <select name="memberLevel" class="form-select">
            <option value="일반유저">일반유저</option>
            <option value="프리미엄">프리미엄</option>
            <option value="파워유저">파워유저</option>
            <option value="마스터">마스터</option>
          </select>
        </div></div>

        <div class="row"><div class="col">
          <button class="btn btn-primary w-100">가입</button>
        </div></div>
        </form>
    </div>
  </div>
</div>
  
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>