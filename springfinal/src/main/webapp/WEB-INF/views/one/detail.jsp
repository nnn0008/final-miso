<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<style>
  .container {
    margin-top: 20px;
  }

  .table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
  }

  .table td {
    padding: 15px;
    border: 1px solid #ddd;
    text-align: left;
  }

  .table tr:nth-child(even) {
    background-color: #f2f2f2;
  }

  .table th {
    background-color: #4CAF50;
    color: white;
  }
</style>

	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<table class="table">
					<tr>
						<td>${OneDto.oneTitle}</td>
						</tr>
						<tr>
						<td>${OneDto.oneContent}</td>
						</tr>
						<tr>
						<td>${OneDto.oneMember}</td>
						</tr>
						<tr>
						<td>${OneDto.oneDate}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>







	<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>