<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<script>
	$(function() {
		//이메일로 아이디 검사 코드
		$(".btn-search").click(function(e) {
			e.preventDefault();
			var memberName = $("[name=memberName]").val();
			var memberEmail = $("[name=memberEmail]").val();
			console.log(memberName);
			console.log(memberEmail);
			$.ajax({
				url : "http://localhost:8080/member/restSearchId",
				method : "post",
				data : {
					memberName : memberName,
					memberEmail : memberEmail
				},
				success : function(response) {
					var memberId = response;
					var template = $("#searchId-template").html();
					var htmlTemplate = $.parseHTML(template);
					
					$(htmlTemplate).find(".count-show").text(memberName+"님의 아이디는 "+response.length+"개 입니다.");
					
					for(var i=0; i < response.length; i++) {
						var memberId = response[i];
						$(htmlTemplate).find(".id-show").html("<span class='border border-primary fs-4 p-2'>"+memberId+"</span>");
					}
					$("#change-template").empty().append(htmlTemplate);
				}
			})
		});
	});
</script>
<!-- 아이디를 찾았을 때 띄울 템플렛 -->
<script id="searchId-template" type="text/template">
                <div class="row mt-5 pt-5">
                    <div class="col">
                        <h1>아이디를 찾았습니다</h1>
                    </div>
                </div>

				<div class="row">
					<div class="col">
						<h3 class="count-show"></h3>
					</div>
				</div>

                <div class="row mt-4">
                    <div class="col">
						<div class="id-show">
							
						</div>
                    </div>
                </div>
			<div class="row mt-4">
                <div class="col">
					<a href="./login">로그인</a>
				</div>
            </div>
</script>
			<div class="contain-fluid">
				<div class="row">
					<div class="col">

<div id="change-template">
						<div class="row mt-5 pt-5">
							<div class="col">
								<h1>아이디 찾기</h1>
							</div>
						</div>

						<form>
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label class="col-form-label mt-4" for="memberName">이름</label>
										<input type="text" class="form-control" name="memberName"
											id="memberName">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label class="col-form-label mt-4" for="inputDefault">이메일</label>
										<input type="text" class="form-control" name="memberEmail"
											id="inputDefault">
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col text-end">
									<button class="btn btn-primary btn-search">찾기</button>
								</div>
							</div>
						</form>
</div>


					</div>
				</div>
			</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>