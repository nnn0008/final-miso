<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
   
<h1>그룹 웹소켓 예제</h1>

<button type="button" class="connect-btn">연결</button>
<button type="button" class="disconnect-btn">종료</button>
<hr>

<input type="text" class="message-input">
<button type="button" class="send-btn">전송</button>

<div class="message-list"></div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	$(function(){
		//목표 : 연결버튼을 누르면 웹소켓 연결 생성, 종료버튼을 누르면 생성한 연결 조욜
		$(".connect-btn").click(function(){
			window.socket = new WebSocket("ws://localhost:8080/ws/chat");
			//연결 생성 시점에 연결에서 발생할 수 있는 상황별로 callback 함수를 지정
			//- onopen - 연결이 성공한 직후에 실행하는 함수를 설정하는 자리
			//- onclose - 연결이 종료된 직후에 실행하는 함수를 설정하는 자리
			//- onerror - 연결에서 오류가 발생한 경우 실행하는 함수를 설정하는 자리
			//- onmessage - 서버에서 메세지가 전송되는 경우 실행하는 함수를 설정하는 자리
			
			socket.onmessage = function(e){
				//console.log(e.data);
				$("<div>").text(e.data).appendTo(".message-list") 
				
				Toastify({
					  text: e.data,
					  duration: 3000,
					  //destination: "https://github.com/apvarun/toastify-js", 
					  newWindow: true,
					  close: true,
					  gravity: "bottom", // `top` or `bottom`
					  position: "right", // `left`, `center` or `right`
					  stopOnFocus: true, // Prevents dismissing of toast on hover
					  style: {
					    background: "linear-gradient(to right, #00b09b, #96c93d)",
					  },
					  onClick: function(){} // Callback after click
					}).showToast();
				
			};
		});
		$(".disconnect-btn").click(function(){
			window.socket.close();			
		});
	});
	
	//전송 버튼을 클릭하면 입력한 메세지를 가져와서 서버로 전달
	$(".send-btn").click(function(){
		//var input = document.querySelector(".message-input").value;
		var input = $(".message-input").val();
		if(input.length == 0) return;
		
		window.socket.send(input);
		$(".message-input").val("");
	});
</script>