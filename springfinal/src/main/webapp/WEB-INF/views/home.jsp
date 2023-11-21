<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 매번 페이지 코드를 복사할 수 없으니 미리 만든 것을 불러오도록 설정 
		- 템블릿 페이지(template page)라고 부름
		- 절대경로를 사용할 것
--%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<!-- 해당 JSP 파일에 스크립트 포함 -->
<script>
$(document).ready(function() {
    $(".showCategoryButton").click(function() {
        var categoryAlert = $(".categoryAlert");
        if (categoryAlert.css("display") === "none") {
            categoryAlert.css("display", "block");
        } else {
            categoryAlert.css("display", "none");
        }
    });

    // 창 크기가 변경될 때 이벤트 처리
    $(window).on("resize", function() {
        if ($(window).width() > 780) {
            // 창 폭이 780px보다 크면
            $(".categoryAlert").css("display", "none");
        }
    });
});

</script>


 <div class="row m-2 ">
 
 <div id="iconContainer" class="d-flex justify-content-end ">
			<i class="fa-solid fa-bars fa-xl iconContainer showCategoryButton"></i>
				</div>
				<div class="row mb-3">
   				 <div class="col d-flex justify-content-end">
				<div class="alert alert-dismissible alert-light categoryAlert">
   					<div class="row d-flex justify-content-center">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #FFA5A5;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/sports.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #FBEAB7;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/poetry.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2" style="background-color: #C3DCFF;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/flight.png" width="100%">
                            </a>
                        </div>
                    </div>

                    <div class="row d-flex justify-content-center mt-2">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #FFA5E6;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/ferris-wheel.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #E2CBC4;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/handbag.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2" style="background-color: #8DACD9;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/earth.png" width="100%">
                            </a>
                        </div>
                    </div>

                    <div class="row d-flex justify-content-center mt-2">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #F5CCFF;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/music-notes.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #A5EE99;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/paint-palette.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2" style="background-color: #F5F5F5;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/ballet.png" width="100%">
                            </a>
                        </div>
                    </div>

                    <div class="row d-flex justify-content-center mt-2">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #FCCD7F;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/heart.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #C7D290;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/cappuccino.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2" style="background-color: #7B89C6;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/car.png" width="100%">
                            </a>
                        </div>
                    </div>

                    <div class="row d-flex justify-content-center mt-2">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #FFF8B2;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/camera.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #82CCB3;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/baseball-ball.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2" style="background-color: #72A8DC;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/gamepad.png" width="100%">
                            </a>
                        </div>
                    </div>

                    <div class="row d-flex justify-content-center mt-2">
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #F497A9;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/recipes.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 me-3" style="background-color: #B9FFE7;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/dog.png" width="100%">
                            </a>
                        </div>
                        <div class="col-4 category text-center p-2 mb-5" style="background-color: #DBEEFF;">
                            <a href="#" class="link">
                                <img src="${pageContext.request.contextPath}/images/butterfly.png" width="100%">
                            </a>
                        </div>
                    </div>
            </div>
</div>
</div>


                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">찜한 모임 정모</span>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                    <div class="col-4">
                        <div class="alert alert-dismissible alert-light">
                            <a href="#" class="link">정모1</a>
                        </div>
                    </div>

                </div>



                <div class="row m-2 mt-3">

                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">가입한 모임</span>
                        </div>
                    </div>

                    <div class="col d-flex flex-column align-items-start">
                        <div class="alert alert-dismissible alert-light circle">
                          <a href="#" class="link d-flex justify-content-center align-items-center" 
                          style="height: 100%; padding: 0; box-sizing: border-box;">
                            <i class="fa-solid fa-plus"></i></a>
                        </div>
                      
                        <div>
                          <label class="circle-name text-center">Java 개발자스터디</label>
                        </div>
                      
                        <div class="alert alert-dismissible alert-light circle circle-time">
                          <a href="#" class="link"></a>
                        </div>

                      </div>

                </div>

                <div class="row m-2 mt-3">

                    <div class="row mb-3">
                        <div class="col">
                            <span class="badge rounded-pill bg-miso">내 모임 정모</span>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="width: 550px">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="width: 550px">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                     <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="width: 550px">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>
                    
                     <div class="row">
                        <div class="col">

                            <div class="card text-white bg-miso mb-3" style="width: 550px">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    java 개발자 스터디
                                    <button type="button" class="btn btn-light rounded-pill ml-auto">참석</button>
                                </div>
                                <div class="card-body">
                                    정모합시다
                                </div>
                                <div class="card-header">
                                    화요일 31일 오후 3:30
                                </div>
                                <div class="card-body">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                    <img src="./images/avatar50.png" width="10%" class="pe-1">
                                </div>
                            </div>
                        </div>
                    </div>


                </div>


<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>