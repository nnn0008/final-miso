<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

 <!-- 아이콘 사용을 위한 Font Awesome 6 CDN-->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
   

<!-- 부트스트랩 CDN -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">

<!-- 스타일시트 로딩 코드 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link href="${pageContext.request.contextPath}/css/misolayout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/miso.css" rel="stylesheet">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->


<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- websocket -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

  
    <style>
   #socketAlert { 
	 height: auto; 
	 display: none;
}

</style>

  <script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>


<script>
	
	window.notifySocket = new SockJS("${pageContext.request.contextPath}/ws/notify");
	
	notifySocket.onopen = function (e) {
	     console.log('Info: connection opened.');
	 };
	 
	 let notifications = [];

	 function showNotification(notification) {
	     let $notificationContainer = $(".notification-container");

	     let $newNotificationDiv = $("<div>")
	         .html(notification)
	         .addClass("alert alert-success bg-miso")
	         .attr("role", "alert");

	     $notificationContainer.append($newNotificationDiv);

	     // 각 알림 닫기 버튼 클릭 시 알림 제거
	     $newNotificationDiv.click(function () {
	         $newNotificationDiv.fadeOut(500, function () {
	             $newNotificationDiv.remove();
	             notifications.shift(); // 배열에서 해당 알림 제거
	         });
	     });

	     setTimeout(function () {
	         $newNotificationDiv.fadeOut(500, function () {
	             $newNotificationDiv.remove();
	             notifications.shift(); // 배열에서 해당 알림 제거
	         });
	     }, 5000);
	 }

	 window.notifySocket.onmessage = function (e) {
	     console.log("onmessage" + e.data);
	     notifications.push(e.data);
	     showNotification(e.data);
	 }



	 
	 notifySocket.onclose = function (e) {
		    console.log('Info: connection close.');
		}

	 
	 
	 </script>
    
    
    
 <!-- 오른쪽 사이드바 -->
 </article>
            <aside class="right-sidebar ">

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

                    <div class="row">
                        <div class="col p-0 pt-3 ps-1 text-inc">
                            이용약관 개인정보처리방침 쿠키 정책
 © 2023 miso, Inc.
                        </div>                     
                    </div>
                    
                                          <div class="col mt-4">
<!-- 	            <div id="socketAlert" class="alert alert-success bg-miso" role="alert" ></div> -->
	            <div class="notification-container"></div>
	            </div>
            </aside>
        </section>
    </main>