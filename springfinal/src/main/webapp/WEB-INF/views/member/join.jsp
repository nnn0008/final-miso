<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="contain-fluid">
  <div class="row">
    <div class="col-12">
    
      <div class="row">
        <div class="col text-center">
          <h1 class="h1">회원가입</h1>
        </div>
      </div>

      <form action="./join" method="post">
      <div class="contain-fluid">
 		<div class="row	">
 			<div class="col">
        <div class="row mt-4"><div class="col">
          <label class="form-label">아이디</label>
          <input type="text" name="memberId" class="form-control">
        </div></div>

        <div class="row mt-2"><div class="col">
          <label class="form-label">비밀번호</label>
          <input type="text" name="memberPw" class="form-control">
        </div></div>

        <div class="row mt-2"><div class="col">
          <label class="form-input">닉네임</label>
          <input type="text" name="memberName" class="form-control">
        </div></div>
        <div class="row mt-2"><div class="col">
          <label class="form-input">이메일</label>
          <input type="email" name="memberEmail" class="form-control">
        </div></div>
        <div class="row mt-2"><div class="col">
          <label class="form-input">연락쳐</label>
          <input type="text" name="memberContack" class="form-control">
        </div></div>
        
        <div class="row mt-4"><div class="col"><!--주소--></div></div>
        <div class="row mt-2"><div class="col">
          <label class="form-input">생년월일</label>
          <input type="date" name="memberBirth" class="form-control">
        </div></div>
        <div class="row mt-4"><div class="col">
          <label class="form-input">등급(지울예정=>지울 때 mapper 고치기)</label>
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
 			</div>
 		</div>     
      </div>
        </form>
    </div>
  </div>
  </div>
  
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>